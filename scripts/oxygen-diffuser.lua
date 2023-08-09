local OxygenDiffuser = {}

-- TODO Beacon Overhaul compatibility

local oxygen_machines = {
  ["assembling-machine-1"] = true,
  ["assembling-machine-2"] = true,
  ["assembling-machine-3"] = true,
  ["ll-low-grav-assembling-machine"] = true,
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
  global.oxygen_diffusers[entity.unit_number] = {
    entity = entity,
    fluidbox = fluidbox,
    position = position,
  }

  script.register_on_entity_destroyed(entity)
end


local function on_entity_built(event)
  local entity = event.created_entity or event.entity
  -- TODO event filters
  if not entity.valid then return end
  if entity.surface.name ~= "luna" then return end

  if entity.name == "ll-oxygen-diffuser" then
    local assemblers = entity.get_beacon_effect_receivers()
    for _, assembler in pairs(assemblers) do
      if assembler.type == "assembling-machine" and oxygen_machines[assembler.name] then
        -- Enable entities now covered by diffuser
        assembler.active = true
      end
    end

  elseif entity.type == "assembling-machine" and oxygen_machines[entity.name] then
    if not affected_by_oxygen_diffuser(entity) then
      entity.active = false
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
        assembler.active = false
      end
    end
  end
end

local function on_entity_destroyed(event)
  local diffuser_data = global.oxygen_diffusers[event.unit_number]

  if diffuser_data then
    if diffuser_data.fluidbox.valid then
      diffuser_data.fluidbox.destroy()
    end
  end
end

local function update_diffuser(entity, fluidbox)
  -- Check activity of machines in range, then remove the appropriate amount of oxygen
  local assemblers = entity.get_beacon_effect_receivers()

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

  local oxygen_required = machines_working * 0.05
  local oxygen_in_fluidbox = fluidbox.get_fluid_count("ll-oxygen")
  if oxygen_in_fluidbox >= oxygen_required then
    for _, assembler in pairs(assemblers) do
      assembler.active = true
    end
    fluidbox.remove_fluid{name = "ll-oxygen", amount = oxygen_required}
    -- TODO production stats
  else
    for _, assembler in pairs(assemblers) do
      assembler.active = false
    end
  end

end

local function on_tick(event)
  for unit_number, diffuser_data in pairs(global.oxygen_diffusers) do
    if diffuser_data.entity.valid and diffuser_data.fluidbox.valid then
      update_diffuser(diffuser_data.entity, diffuser_data.fluidbox)
    else
      if diffuser_data.entity.valid then
        diffuser_data.entity.destroy()
      end
      if diffuser_data.fluidbox.valid then
        diffuser_data.fluidbox.destroy()
      end
      global.oxygen_diffusers[unit_number] = nil
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

  [defines.events.on_entity_destroyed] = on_entity_destroyed,
}

function OxygenDiffuser.on_init()
  global.oxygen_diffusers = {}
end

function OxygenDiffuser.on_configuration_changed()
  global.oxygen_diffusers = global.oxygen_diffusers or {}
end

return OxygenDiffuser