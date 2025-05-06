local Buckets = require "scripts.buckets"

---@type ScriptLib
local IonRobots = {}

local function on_script_trigger_effect(event)
  if event.effect_id ~= "ll-ion-roboport-created" then return end

  local entity = event.target_entity
  local position = entity.position
  local fluidbox = entity.surface.create_entity{
    name = "ll-ion-roboport-fluidbox",
    position = position,
    force = entity.force,
    create_build_effect_smoke = false,
  }

  local roboport_data = {
    entity = entity,
    fluidbox = fluidbox,
    logistic_cell = entity.logistic_cell,
    fluid_production_statistics = entity.force.get_fluid_production_statistics(entity.surface),
  }
  Buckets.add(storage.ion_roboports, entity.unit_number, roboport_data)

  script.register_on_object_destroyed(entity)

  --update_diffuser(diffuser_data.entity, diffuser_data.fluidbox, diffuser_data.fluid_production_statistics)
end

local function on_object_destroyed(event)
  if event.type ~= defines.target_type.entity then return end
  local roboport_data = Buckets.get(storage.oxygen_diffusers, event.useful_id)

  if roboport_data then
    if roboport_data.fluidbox.valid then
      roboport_data.fluidbox.destroy()
    end
    Buckets.remove(storage.ion_roboports, event.useful_id)
  end
end

---@param roboport LuaEntity
---@param fluidbox LuaEntity
---@param logistic_cell LuaLogisticCell
---@param fluid_production_statistics LuaFlowStatistics
function update_roboport(roboport, fluidbox, logistic_cell, fluid_production_statistics)
  local charging_robot_count = logistic_cell.charging_robot_count
  if charging_robot_count > 0 then
    local oxygen_required = charging_robot_count * 0.005 * storage.ion_roboports.interval  -- 0.3 oxygen per second per charging robot
    local oxygen_in_fluidbox = fluidbox.get_fluid_count("ll-oxygen")
    if oxygen_in_fluidbox >= oxygen_required then
      fluidbox.remove_fluid{name = "ll-oxygen", amount = oxygen_required}
      fluid_production_statistics.on_flow("ll-oxygen", -oxygen_required)
      roboport.force = "player"
      roboport.custom_status = nil
    else
      roboport.force = "ll-mass-driver"  -- Disable roboport by changing its force to a friendly force
      roboport.custom_status = {diode = defines.entity_status_diode.red, label = {"custom-entity-status.ll-insufficient-oxygen-supply"}}
    end
  elseif roboport.force.name == "ll-mass-driver" then
    local oxygen_in_fluidbox = fluidbox.get_fluid_count("ll-oxygen")
    if oxygen_in_fluidbox > 10 then
      roboport.force = "player"
      roboport.custom_status = nil
    end
  end
end

local function on_tick(event)
  for unit_number, roboport_data in pairs(Buckets.get_bucket(storage.ion_roboports, event.tick)) do
    if roboport_data.entity.valid and roboport_data.fluidbox.valid and roboport_data.fluid_production_statistics.valid then
      update_roboport(roboport_data.entity, roboport_data.fluidbox, roboport_data.logistic_cell, roboport_data.fluid_production_statistics)
    else
      if roboport_data.entity.valid then
        roboport_data.entity.destroy()
      end
      if roboport_data.fluidbox.valid then
        roboport_data.fluidbox.destroy()
      end
      Buckets.remove(storage.ion_roboports, unit_number)
    end
  end
end

IonRobots.events = {
  [defines.events.on_tick] = on_tick,
  [defines.events.on_script_trigger_effect] = on_script_trigger_effect,
  [defines.events.on_object_destroyed] = on_object_destroyed,
}

function IonRobots.on_init()
  storage.ion_roboports = Buckets.new(10)
end

function IonRobots.on_configuration_changed()
  storage.ion_roboports = storage.ion_roboports or Buckets.new(10)
end

return IonRobots