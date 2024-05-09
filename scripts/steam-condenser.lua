local Buckets = require "scripts.buckets"

---@type ScriptLib
local SteamCondenser = {}

local function condenser_position_to_area(position)
  return {
    left_top = {
      x = position.x - 5.5,
      y = position.y - 5.5,
    },
    right_bottom = {
      x = position.x + 5.5,
      y = position.y + 5.5,
    },
  }
end

local function turbine_position_to_area(position)
  return {
    left_top = {
      x = position.x - 5.5,
      y = position.y - 1 - 5.5,
    },
    right_bottom = {
      x = position.x + 5.5,
      y = position.y + 1 + 5.5,
    },
  }
end

local function distance_squared(position1, position2)
  return (position1.x - position2.x)^2 + (position1.y - position2.y)^2
end

local function on_script_trigger_effect(event)
  if event.effect_id ~= "ll-steam-condenser-created" then return end

  local entity = event.target_entity
  local position = entity.position

  local turbines = entity.surface.find_entities_filtered{
    area = condenser_position_to_area(position),
    name = "steam-turbine",  -- TODO make work with any type = "generator"
  }

  local turbines_by_unit_number = {}
  for _, turbine in pairs(turbines) do
    local turbine_data = global.turbines[turbine.unit_number]
    if not turbine_data.condenser then
      turbine_data.condenser = entity.unit_number
      turbines_by_unit_number[turbine.unit_number] = turbine
    else
      local player = entity.last_user
      if player then
        player.print({"ll-console-info.too-many-condensers-in-range"})
      end
    end
  end

  Buckets.add(global.steam_condensers, entity.unit_number, {
    entity = entity,
    --fluidbox = entity.fluidbox[2],
    position = position,
    turbines = turbines_by_unit_number,
  })

  script.register_on_entity_destroyed(entity)
end


local function on_entity_built(event)
  local entity = event.created_entity or event.entity
  if not entity.valid then return end

  if entity.name == "steam-turbine" then
    local turbine_data = {}
    local condensers = entity.surface.find_entities_filtered{
      area = turbine_position_to_area(entity.position),
      name = "ll-steam-condenser",
    }
    if #condensers > 1 then
      local player = entity.last_user
      if player then
        player.print({"ll-console-info.too-many-condensers-in-range"})
      end
    end
    if next(condensers) then
      local condenser_unit_number = condensers[1].unit_number
      local condenser_data = Buckets.get(global.steam_condensers, condenser_unit_number)
      if condenser_data then
        condenser_data.turbines[entity.unit_number] = entity
        turbine_data.condenser = condenser_unit_number
      end
    elseif entity.surface.name == "luna" then
      --game.print("No condenser found for turbine")
    end
    global.turbines[entity.unit_number] = turbine_data
    script.register_on_entity_destroyed(entity)
  end
end

local function on_entity_destroyed(event)
  if not event.unit_number then return end  -- entity was tree/rock
  -- Condenser destroyed
  local condenser_data = Buckets.get(global.steam_condensers, event.unit_number)
  if condenser_data then
    for unit_number, turbine in pairs(condenser_data.turbines) do
      local turbine = condenser_data.turbines[unit_number]
      on_entity_built{created_entity = turbine}  -- send the turbine off to check for another condenser
    end
    Buckets.remove(global.steam_condensers, event.unit_number)
  end

  -- Turbine destroyed, turbine will get removed from condenser data when the condenser updates
  global.turbines[event.unit_number] = nil
end

local function update_condenser(entity, turbines)
  if not next(turbines) then return end

  local total_energy = 0
  local to_remove = {}
  for unit_number, turbine in pairs(turbines) do
    if turbine.valid then
      total_energy = total_energy + turbine.energy_generated_last_tick * global.steam_condensers.interval
    else
      table.insert(to_remove, unit_number) 
    end
  end
  for _, unit_number in pairs(to_remove) do
    turbines[unit_number] = nil
  end

  -- Assume generator effectivity = 1, steam temp = 500
  -- Energy of 1 steam is 200 Joule / unit / degrees C
  -- total_energy = 200 * total_steam * (500 - 15)
  -- total_steam = total_energy / 97000
  local total_steam = total_energy / 97000

  if total_steam > 0 then
    local fluidbox = entity.fluidbox[2]
    if fluidbox then
      fluidbox.amount = fluidbox.amount + total_steam
      entity.fluidbox[2] = fluidbox
    else
      entity.fluidbox[2] = {
        name = "steam",
        amount = total_steam,
        temperature = 500,
      }
    end
  end
end

local function on_tick(event)
  for unit_number, condenser_data in pairs(Buckets.get_bucket(global.steam_condensers, event.tick)) do
    if condenser_data.entity.valid then
      update_condenser(condenser_data.entity, condenser_data.turbines)
    else
      Buckets.remove(global.steam_condensers, unit_number)
    end
  end
end

SteamCondenser.events = {
  [defines.events.on_tick] = on_tick,
  [defines.events.on_script_trigger_effect] = on_script_trigger_effect,
  [defines.events.on_built_entity] = on_entity_built,
  [defines.events.on_robot_built_entity] = on_entity_built,
  [defines.events.script_raised_built] = on_entity_built,
  [defines.events.script_raised_revive] = on_entity_built,
  --[[[defines.events.on_cancelled_deconstruction] = on_entity_built,
  [defines.events.on_player_mined_entity] = on_entity_removed,
  [defines.events.on_robot_pre_mined] = on_entity_removed,
  [defines.events.on_marked_for_deconstruction] = on_entity_removed,
  ]]
  [defines.events.on_entity_destroyed] = on_entity_destroyed,
}

function SteamCondenser.on_init()
  global.steam_condensers = Buckets.new()
  global.turbines = {}
end

function SteamCondenser.on_configuration_changed()
  global.steam_condensers = global.steam_condensers or {}
  global.turbines = global.turbines or {}
end

return SteamCondenser