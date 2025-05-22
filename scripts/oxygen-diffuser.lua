local Buckets = require "scripts.buckets"

---@type ScriptLib
local OxygenDiffuser = {}

-- TODO Beacon Overhaul compatibility

local oxygen_machines = {
  ["assembling-machine-1"] = true,
  ["assembling-machine-2"] = true,
  ["assembling-machine-3"] = true,
  ["ll-low-grav-assembling-machine"] = true,
  ["chemical-plant"] = true,
  ["oil-refinery"] = true,
  ["centrifuge"] = true,
  ["recycler"] = true,
}

local function affected_by_oxygen_diffuser(entity, ignore_unit_number)
  local beacons = entity.get_beacons()
  if beacons then
    for _, beacon in pairs(beacons) do
      if beacon.name == "ll-oxygen-diffuser" and beacon.unit_number ~= ignore_unit_number then
        return true
      end
    end
  end
  return false
end

local function on_script_trigger_effect(event)
  if event.effect_id ~= "ll-oxygen-diffuser-created" then return end

  local entity = event.target_entity
  local position = entity.position
  local fluidbox = entity.surface.create_entity{
    name = "ll-oxygen-diffuser-fluidbox",
    position = position,
    force = entity.force,
    create_build_effect_smoke = false,
  }

  local diffuser_data = {
    entity = entity,
    fluidbox = fluidbox,
    fluid_production_statistics = entity.force.get_fluid_production_statistics(entity.surface),
    position = position,
  }
  Buckets.add(storage.oxygen_diffusers, entity.unit_number, diffuser_data)

  script.register_on_object_destroyed(entity)

  entity.energy = 1  -- Allows it to instantly go to working/insufficient-oxygen statuses
  update_diffuser(diffuser_data.entity, diffuser_data.fluidbox, diffuser_data.fluid_production_statistics)
end


local function on_entity_built(event)
  local entity = event.entity
  if not entity.valid then return end
  if entity.surface.name ~= "luna" then return end

  --if entity.name == "ll-oxygen-diffuser" then

  if entity.type == "assembling-machine" and oxygen_machines[entity.name] then
    if not affected_by_oxygen_diffuser(entity) then
      entity.disabled_by_script = true
      entity.custom_status = {diode = defines.entity_status_diode.red, label = {"custom-entity-status.ll-requires-oxygen-diffuser-nearby"}}
      if event.name == defines.events.on_built_entity then
        local player = game.get_player(event.player_index)  ---@cast player -?
        player.create_local_flying_text{text = {"ll-console-info.requires-oxygen"}, position = entity.position}
      end
    end
  end
end

local function on_entity_removed(event)
  local entity = event.entity
  if entity.name == "ll-oxygen-diffuser" then
    local assemblers = entity.get_beacon_effect_receivers()
    local unit_number = entity.unit_number
    for _, assembler in pairs(assemblers) do
      if assembler.type == "assembling-machine" and oxygen_machines[assembler.name]
        and not affected_by_oxygen_diffuser(assembler, unit_number) then
        -- Disable entities which are no longer covered by diffuser
        assembler.disabled_by_script = true
        assembler.custom_status = {diode = defines.entity_status_diode.red, label = {"custom-entity-status.ll-requires-oxygen-diffuser-nearby"}}
      end
    end
  end
end

local function on_object_destroyed(event)
  if event.type ~= defines.target_type.entity then return end
  local diffuser_data = Buckets.get(storage.oxygen_diffusers, event.useful_id)

  if diffuser_data then
    if diffuser_data.fluidbox.valid then
      diffuser_data.fluidbox.destroy()
    end
    Buckets.remove(storage.oxygen_diffusers, event.useful_id)
  end
end

function update_diffuser(diffuser, fluidbox, fluid_production_statistics)
  -- Check activity of machines in range, then remove the appropriate amount of oxygen
  local assemblers = diffuser.get_beacon_effect_receivers()

  if not next(assemblers) then return end

  -- Filter out non-assembling machines
  for i, assembler in pairs(assemblers) do
    if assembler.type ~= "assembling-machine" or not oxygen_machines[assembler.name] then
      assemblers[i] = nil
    end
  end
  local machines_working = 0
  for _, assembler in pairs(assemblers) do
    local status = assembler.status
    if status == defines.entity_status.working
      or status == defines.entity_status.low_power
      or status == defines.entity_status.disabled_by_script
    then
      machines_working = machines_working + 1
    end
  end

  -- Diffuser has no power
  if diffuser.energy == 0 then
    for _, assembler in pairs(assemblers) do
      assembler.disabled_by_script = true
      assembler.custom_status = {diode = defines.entity_status_diode.red, label = {"custom-entity-status.ll-requires-oxygen"}}
    end
    diffuser.disabled_by_script = false
    diffuser.custom_status = nil
    return
  end

  local oxygen_required = machines_working * 0.005 * storage.oxygen_diffusers.interval  -- 0.3 oxygen per second per machine
  local oxygen_in_fluidbox = fluidbox.get_fluid_count("ll-oxygen")
  if oxygen_in_fluidbox >= oxygen_required then
    for _, assembler in pairs(assemblers) do
      assembler.disabled_by_script = false
      assembler.custom_status = nil
    end
    fluidbox.remove_fluid{name = "ll-oxygen", amount = oxygen_required}
    fluid_production_statistics.on_flow("ll-oxygen", -oxygen_required)
    diffuser.disabled_by_script = false
    diffuser.custom_status = {diode = defines.entity_status_diode.green, label = {"entity-status.working"}}
  else
    for _, assembler in pairs(assemblers) do
      assembler.disabled_by_script = true
      assembler.custom_status = {diode = defines.entity_status_diode.red, label = {"custom-entity-status.ll-requires-oxygen"}}
    end
    diffuser.disabled_by_script = true
    diffuser.custom_status = {diode = defines.entity_status_diode.red, label = {"custom-entity-status.ll-insufficient-oxygen-supply"}}
  end
end

local function on_tick(event)
  for unit_number, diffuser_data in pairs(Buckets.get_bucket(storage.oxygen_diffusers, event.tick)) do
    if diffuser_data.entity.valid and diffuser_data.fluidbox.valid and diffuser_data.fluid_production_statistics.valid then
      update_diffuser(diffuser_data.entity, diffuser_data.fluidbox, diffuser_data.fluid_production_statistics)
    else
      if diffuser_data.entity.valid then
        diffuser_data.entity.destroy()
      end
      if diffuser_data.fluidbox.valid then
        diffuser_data.fluidbox.destroy()
      end
      Buckets.remove(storage.oxygen_diffusers, unit_number)
    end
  end
end

OxygenDiffuser.events = {
  [defines.events.on_tick] = on_tick,
  [defines.events.on_script_trigger_effect] = on_script_trigger_effect,
  [defines.events.on_built_entity] = on_entity_built,
  [defines.events.on_robot_built_entity] = on_entity_built,
  [defines.events.script_raised_built] = on_entity_built,
  [defines.events.script_raised_revive] = on_entity_built,
  [defines.events.on_cancelled_deconstruction] = on_entity_built,
  [defines.events.on_player_mined_entity] = on_entity_removed,
  [defines.events.on_robot_pre_mined] = on_entity_removed,
  [defines.events.on_marked_for_deconstruction] = on_entity_removed,

  [defines.events.on_object_destroyed] = on_object_destroyed,
}

function OxygenDiffuser.on_init()
  storage.oxygen_diffusers = Buckets.new()
end

function OxygenDiffuser.on_configuration_changed()
  storage.oxygen_diffusers = storage.oxygen_diffusers or {}
end

return OxygenDiffuser