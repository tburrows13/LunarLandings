local SurfaceConditions = {}

local is_train = {
  ["locomotive"] = true,
  ["cargo-wagon"] = true,
  ["fluid-wagon"] = true,
  ["artillery-wagon"] = true,
}

local maglev_trains = {
  ["space-locomotive"] = true,
  ["space-cargo-wagon"] = true,
  ["space-fluid-wagon"] = true,
}

local function on_built_entity(event)
  local entity = event.entity
  if not entity.valid or not is_train[entity.type] then return end
  if entity.surface.name == "luna" then
    if not maglev_trains[entity.name] then
      if event.name == defines.events.on_built_entity then
        local player = game.get_player(event.player_index)  ---@cast player -?
        player.create_local_flying_text{text = {"ll-flying-text-info.cannot-be-placed-on", entity.localised_name, {"space-location-name.luna"}}, create_at_cursor = true}
        player.mine_entity(entity)  -- TODO play sound
      else
        local inventory = game.create_inventory(0)  -- Create inventory so that game spills item on ground
        if entity.last_user then
          entity.last_user.print{"ll-console-info.cannot-be-placed-on", entity.localised_name, {"space-location-name.luna"}}
        end
        entity.mine{inventory = inventory, force = true, raise_destroyed = true}
        inventory.destroy()
      end
    end
  else
    if maglev_trains[entity.name] then
      if event.name == defines.events.on_built_entity then
        local player = game.get_player(event.player_index)  ---@cast player -?
        player.create_local_flying_text{text = {"ll-flying-text-info.cannot-be-placed-on", entity.localised_name, {"space-location-name.nauvis"}}, create_at_cursor = true}
        player.mine_entity(entity)
      else
        local inventory = game.create_inventory(0)  -- Create inventory so that game spills item on ground
        if entity.last_user then
          entity.last_user.print{"ll-console-info.cannot-be-placed-on", entity.localised_name, {"space-location-name.nauvis"}}
        end
        entity.mine{inventory = inventory, force = true, raise_destroyed = true}
        inventory.destroy()
      end
    end
  end
end


local function on_robot_created(event)
  if event.surface_index == storage.luna_surface_index then
    table.insert(storage.robots_to_kill, event.target_entity)
  end
end

local function on_ion_robot_created(event)
  if event.surface_index ~= storage.luna_surface_index then
    table.insert(storage.robots_to_kill, event.target_entity)
  end
end
local function on_script_trigger_effect(event)
  if event.effect_id == "ll-robot-created" then
    on_robot_created(event)
    return
  end
  if event.effect_id == "ll-ion-robot-created" then
    on_ion_robot_created(event)
    return
  end
end

local function on_tick(event)
  for _, robot in pairs(storage.robots_to_kill) do
    local cargo_inventory = robot.get_inventory(defines.inventory.robot_cargo)
    local repair_inventory = robot.get_inventory(defines.inventory.robot_repair)
    local surface = robot.surface
    local position = robot.position
    surface.spill_inventory{position = robot.position, inventory = cargo_inventory, allow_belts = false, drop_full_stack = true}
    surface.spill_inventory{position = robot.position, inventory = repair_inventory, allow_belts = false, drop_full_stack = true}

    local items_to_place_this = robot.prototype.items_to_place_this
    if items_to_place_this then
      surface.spill_item_stack{position = robot.position, stack = items_to_place_this[1], allow_belts = false, drop_full_stack = true}
    end
    robot.force.print({"robot-cannot-be-used-on", robot.localised_name, surface.localised_name})  -- TODO replace with planet.localised_name, which doesn't exist?
    robot.destroy()
  end
end

SurfaceConditions.events = {
  [defines.events.on_built_entity] = on_built_entity,
  [defines.events.on_robot_built_entity] = on_built_entity,
  [defines.events.script_raised_built] = on_built_entity,
  [defines.events.script_raised_revive] = on_built_entity,
  [defines.events.on_script_trigger_effect] = on_script_trigger_effect,
  [defines.events.on_tick] = on_tick,
}

function SurfaceConditions.on_init()
  storage.robots_to_kill = {}
end

function SurfaceConditions.on_configuration_changed()
  storage.robots_to_kill = storage.robots_to_kill or {}
end

return SurfaceConditions
