local Buckets = require "scripts.buckets"

local SteamCondenser = {}

---@param position MapPosition
---@return BoundingBox
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

---@param bounding_box BoundingBox
---@return BoundingBox
local function turbine_bounding_box_to_area(bounding_box)
  return {
    left_top = {
      x = bounding_box.left_top.x - 4,
      y = bounding_box.left_top.y - 4,
    },
    right_bottom = {
      x = bounding_box.right_bottom.x + 4,
      y = bounding_box.right_bottom.y + 4,
    },
  }
end

local function distance_squared(position1, position2)
  return (position1.x - position2.x)^2 + (position1.y - position2.y)^2
end

---@param event EventData.on_script_trigger_effect
local function on_script_trigger_effect(event)
  if event.effect_id ~= "ll-steam-condenser-created" then return end
  local entity = event.target_entity
  if not entity then return end
  local position = entity.position

  local turbines = entity.surface.find_entities_filtered{
    area = condenser_position_to_area(position),
    name = "steam-turbine",  -- TODO make work with any type = "generator"
  }

  local turbines_by_unit_number = {}
  for _, turbine in pairs(turbines) do
    local turbine_data = storage.turbines[turbine.unit_number]
    if not turbine_data then
      -- Happens in tips and tricks simulations at least
      turbine_data = {}
      storage.turbines[turbine.unit_number] = turbine_data
    end
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

  Buckets.add(storage.steam_condensers, entity.unit_number, {
    entity = entity,
    --fluidbox = entity.fluidbox[2],
    position = position,
    turbines = turbines_by_unit_number,
  })

  script.register_on_object_destroyed(entity)
end

---@param event EventData.on_built_entity | EventData.on_robot_built_entity | EventData.on_space_platform_built_entity | EventData.script_raised_built | EventData.script_raised_revive
local function on_entity_built(event)
  local entity = event.entity
  if not entity.valid then return end

  if entity.name == "steam-turbine" then
    local turbine_data = {}
    local condensers = entity.surface.find_entities_filtered{
      area = turbine_bounding_box_to_area(entity.bounding_box),
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
      local condenser_data = Buckets.get(storage.steam_condensers, condenser_unit_number)
      if condenser_data then
        condenser_data.turbines[entity.unit_number] = entity
        turbine_data.condenser = condenser_unit_number
      end
    elseif entity.surface.name == "luna" then
      --game.print("No condenser found for turbine")
    end
    storage.turbines[entity.unit_number] = turbine_data
    script.register_on_object_destroyed(entity)
  end
end

---@param event EventData.on_object_destroyed
local function on_object_destroyed(event)
  if not event.useful_id then return end  -- entity was tree/rock
  -- Condenser destroyed
  local condenser_data = Buckets.get(storage.steam_condensers, event.useful_id)
  if condenser_data then
    for unit_number, turbine in pairs(condenser_data.turbines) do
      on_entity_built{entity = turbine  --[[@as EventData.on_built_entity]]}  -- send the turbine off to check for another condenser
    end
    Buckets.remove(storage.steam_condensers, event.useful_id)
  end

  -- Turbine destroyed, turbine will get removed from condenser data when the condenser updates
  storage.turbines[event.useful_id] = nil
end

--- Show turbine/condenser connection where hovering the mouse over either
--- entity, similar to how beacons/machines work.
--- @param event EventData.on_selected_entity_changed
local function on_selected_entity_changed (event)
  local player = game.get_player(event.player_index)  ---@cast player -?

  -- Don't want to set up all the plumbing to create this data.
  -- This is a slow event, so it might be okay for now.
  storage.players = storage.players or { }
  local player_data = storage.players[event.player_index]
  if not player_data then
    storage.players[event.player_index] = { }
    player_data = storage.players[event.player_index]
  end

  -- Always destroy all current highlight boxes, if any, to keep logic simple.
  -- Regardless of which entity is now selected.
  if player_data.highlight_boxes then
    for _, box in pairs(player_data.highlight_boxes) do box.destroy() end
  end
  player_data.highlight_boxes = { }

  -- Draw new custom selection if we need to 
  local entity = player.selected
  if not entity or not entity.valid then return end

  if entity.name == "ll-steam-condenser" then
    local condenser_data = Buckets.get(storage.steam_condensers, entity.unit_number)
    if condenser_data and condenser_data.turbines then
      local surface = entity.surface
      for _, turbine in pairs(condenser_data.turbines) do
        if turbine.valid then
          table.insert(player_data.highlight_boxes, surface.create_entity{
            name = "highlight-box",
            position = turbine.position,
            source = turbine,
            box_type = "train-visualization", -- White box
            render_player_index = event.player_index,
          })
        end
      end
    end
  elseif entity.name == "steam-turbine" then
    local turbine_data = storage.turbines[entity.unit_number]
    if turbine_data then
      local condenser = Buckets.get(storage.steam_condensers, turbine_data.condenser)
      if condenser and condenser.entity.valid then
        table.insert(player_data.highlight_boxes, condenser.entity.surface.create_entity{
          name = "highlight-box",
          position = condenser.position,
          source = condenser.entity,
          box_type = "train-visualization", -- White box
          render_player_index = event.player_index,
        })
      end
    end
  end
end

---@param entity LuaEntity
---@param turbines table<number, LuaEntity>
local function update_condenser(entity, turbines)
  if not next(turbines) then return end

  local total_energy = 0
  local to_remove = {}
  for unit_number, turbine in pairs(turbines) do
    if turbine.valid then
      total_energy = total_energy + turbine.energy_generated_last_tick * storage.steam_condensers.interval
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

---@param event EventData.on_tick
local function on_tick(event)
  for unit_number, condenser_data in pairs(Buckets.get_bucket(storage.steam_condensers, event.tick)) do
    if condenser_data.entity.valid then
      update_condenser(condenser_data.entity, condenser_data.turbines)
    else
      Buckets.remove(storage.steam_condensers, unit_number)
    end
  end
end

function SteamCondenser.reset_condenser_connections()
  local steam_condensers = storage.steam_condensers
  storage.steam_condensers = Buckets.new()
  storage.turbines = {}

  for _, surface in pairs(game.surfaces) do
    local turbines = surface.find_entities_filtered{type = "generator", name = "steam-turbine"}
    for _, turbine in pairs(turbines) do
      on_entity_built{created_entity = turbine}
    end
  end
  for _, condenser_list in pairs(steam_condensers.list) do
    for _, condenser_data in pairs(condenser_list) do
      on_script_trigger_effect({
        effect_id = "ll-steam-condenser-created",
        target_entity = condenser_data.entity,
      })
    end
  end
end

SteamCondenser.events = {
  [defines.events.on_tick] = on_tick,
  [defines.events.on_script_trigger_effect] = on_script_trigger_effect,
  [defines.events.on_built_entity] = on_entity_built,
  [defines.events.on_robot_built_entity] = on_entity_built,
  [defines.events.on_space_platform_built_entity] = on_entity_built,
  [defines.events.script_raised_built] = on_entity_built,
  [defines.events.script_raised_revive] = on_entity_built,
  --[[[defines.events.on_cancelled_deconstruction] = on_entity_built,
  [defines.events.on_player_mined_entity] = on_entity_removed,
  [defines.events.on_robot_pre_mined] = on_entity_removed,
  [defines.events.on_marked_for_deconstruction] = on_entity_removed,
  ]]
  [defines.events.on_object_destroyed] = on_object_destroyed,
  [defines.events.on_selected_entity_changed] = on_selected_entity_changed,
}

function SteamCondenser.on_init()
  storage.steam_condensers = Buckets.new()
  storage.turbines = {}
end

function SteamCondenser.on_configuration_changed()
  storage.steam_condensers = storage.steam_condensers or {}
  storage.turbines = storage.turbines or {}

  -- Trigger reset for all condenser-turbine connections when connection logic has changed
  if not storage.migrations.reset_steam_condensers then
    storage.migrations.reset_steam_condensers = true
    SteamCondenser.reset_condenser_connections()
  end
end

return SteamCondenser