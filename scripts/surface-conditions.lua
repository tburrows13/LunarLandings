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

local function destroy_entity(entity)
end

local function on_built_entity(event)
  local entity = event.created_entity or event.entity
  if not is_train[entity.type] then return end
  if entity.surface.name == "luna" then
    if not maglev_trains[entity.name] then
      if event.name == defines.events.on_built_entity then
        local player = game.get_player(event.player_index)
        player.create_local_flying_text{text = {"ll-flying-text-info.cannot-be-placed-on", entity.localised_name, "Luna"}, create_at_cursor = true}
        player.mine_entity(entity)  -- TODO play sound
      else
        local inventory = game.create_inventory(0)  -- Create inventory so that game spills item on ground
        if entity.last_user then
          entity.last_user.print{"ll-console-info.cannot-be-placed-on", entity.localised_name, "Luna"}
        end
        entity.mine{inventory = inventory, force = true, raise_destroyed = true}
        inventory.destroy()
      end
    end
  else
    if maglev_trains[entity.name] then
      if event.name == defines.events.on_built_entity then
        local player = game.get_player(event.player_index)
        player.create_local_flying_text{text = {"ll-flying-text-info.cannot-be-placed-on", entity.localised_name, "Nauvis"}, create_at_cursor = true}
        player.mine_entity(entity)
      else
        local inventory = game.create_inventory(0)  -- Create inventory so that game spills item on ground
        if entity.last_user then
          entity.last_user.print{"ll-console-info.cannot-be-placed-on", entity.localised_name, "Nauvis"}
        end
        entity.mine{inventory = inventory, force = true, raise_destroyed = true}
        inventory.destroy()
      end
    end  
  end
end

SurfaceConditions.events = {
  [defines.events.on_built_entity] = on_built_entity,
  [defines.events.on_robot_built_entity] = on_built_entity,
  [defines.events.script_raised_built] = on_built_entity,
  [defines.events.script_raised_revive] = on_built_entity,
}

return SurfaceConditions
