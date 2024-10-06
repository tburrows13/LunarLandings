local Buckets = require "scripts.buckets"

---@type ScriptLib
local RTG = {}
local ln_2 = 0.69314718

local initial_energy = 80*10^9  -- 80 GJ
local initial_power = 600*10^3  -- 600 kW
local half_life = 0.1 * initial_energy * ln_2 / initial_power  -- 600 kW

local initial_health = 600

local function on_tick(event)
  for unit_number, rtg_data in pairs(Buckets.get_bucket(storage.rtgs, event.tick)) do
    local entity = rtg_data.entity
    if entity.valid then
      local current_multiplier = 1 / (2^((event.tick-rtg_data.tick_created)/(half_life * 60)))
      local power = initial_power * current_multiplier / 60
      entity.power_production = power
      local health = initial_health * current_multiplier
      entity.health = health
    else
      Buckets.remove(storage.rtgs, unit_number)
    end
  end
end

local function on_entity_built(event)
  local entity = event.created_entity or event.entity
  if not entity.valid or entity.name ~= "ll-rtg" then return end

  Buckets.add(storage.rtgs, entity.unit_number, {
    entity = entity,
    tick_created = event.tick
  })
end

local function on_entity_mined(event)
  local entity = event.entity
  if entity.name ~= "ll-rtg" then return end

  if entity and entity.valid then
    local buffer = event.buffer
    for i = 1, #buffer do
      local item_stack = buffer[i]
      item_stack.health = 1
    end
  end

  Buckets.remove(storage.rtgs, entity.unit_number)
end

RTG.events = {
  [defines.events.on_tick] = on_tick,
  [defines.events.on_built_entity] = on_entity_built,
  [defines.events.on_robot_built_entity] = on_entity_built,
  [defines.events.script_raised_built] = on_entity_built,
  [defines.events.script_raised_revive] = on_entity_built,
  [defines.events.on_player_mined_entity] = on_entity_mined,
  [defines.events.on_robot_mined_entity] = on_entity_mined,
}

RTG.on_init = function ()
  storage.rtgs = Buckets.new()
end

RTG.on_configuration_changed = function(changed_data)
  storage.rtgs = storage.rtgs or {}
end

return RTG
