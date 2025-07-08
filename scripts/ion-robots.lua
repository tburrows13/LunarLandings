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
  storage.luna_roboports_processed = true
end

function IonRobots.on_configuration_changed()
  storage.ion_roboports = storage.ion_roboports or Buckets.new(10)

  if not storage.luna_roboports_processed then
    storage.luna_roboports_processed = true
    local luna = game.surfaces["luna"]
    if luna then
      local luna_roboports = luna.find_entities_filtered{type = "roboport"}
      local roboport_count = #luna_roboports
      for _, roboport in pairs(luna_roboports) do
        if roboport.name ~= "ll-ion-roboport" then
          local robot_inventory = roboport.get_inventory(defines.inventory.roboport_robot)
          if robot_inventory and #robot_inventory > 0 then
            luna.spill_inventory{inventory = robot_inventory, position = roboport.position, force = roboport.force, allow_belts = false, drop_full_stack = true}
          end
          local repair_inventory = roboport.get_inventory(defines.inventory.roboport_material)
          if repair_inventory and #repair_inventory > 0 then
            luna.spill_inventory{inventory = repair_inventory, position = roboport.position, force = roboport.force, allow_belts = false, drop_full_stack = true}
          end

          local items_to_place_this = roboport.prototype.items_to_place_this
          if items_to_place_this then
            luna.spill_item_stack{position = roboport.position, stack = items_to_place_this[1], allow_belts = false, drop_full_stack = true}
          end
          roboport.destroy()
        end
      end
      game.print("[img=utility/warning_icon] [LL] Regular roboports and robots can no longer be used on Luna. " .. tostring(roboport_count) .. " Luna roboports and their contents have been dropped onto the ground.\nUse [entity=ll-ion-roboport] [entity=ll-ion-logistic-robot] and [entity=ll-ion-construction-robot] instead, which are powered by both electricity and [fluid=ll-oxygen].\nAll logistic chest types may now be used on Luna.")
    end
  end
end

return IonRobots