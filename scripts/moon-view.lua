---@type ScriptLib
local MoonView = {}

-- TODO handle incorrect character after respawn or editor-change-surface

local SHORTCUT_NAME = "ll-toggle-moon-view"

function MoonView.get_data(player_index)
  global.moon_view_data[player_index] = global.moon_view_data[player_index] or {}
  return global.moon_view_data[player_index]
end

function MoonView.get_associated_character(player)
  local associated_characters = player.get_associated_characters()
  if next(associated_characters) then
    return associated_characters[1]
  else
    return nil
  end
end

function MoonView.toggle_moon_view(event)
  local player = game.players[event.player_index]
  if not player.force.technologies["ll-luna-exploration"].researched then
    player.print({"ll-console-info.luna-connection-not-established"})
    return
  end
  if player.controller_type ~= defines.controllers.character then return end
  local moon_view_data = MoonView.get_data(event.player_index)
  if player.surface.name == "luna" then
    local luna_character = player.character
    local nauvis_character = MoonView.get_associated_character(player)
    if not nauvis_character then
      -- Check old method
      nauvis_character = moon_view_data.nauvis_character
    end
    if not nauvis_character or not nauvis_character.valid then
      nauvis_character = game.get_surface("nauvis").create_entity{
        name = "character",
        position = {0, 0},
        force = player.force,
        create_build_effect_smoke = false,
      }
    end
    -- Player is on moon
    -- Can't set controller to character on another surface, and teleporting the player also teleports the character
    player.set_controller{
      type = defines.controllers.spectator,
    }
    player.teleport({0, 0}, "nauvis")
    player.set_controller{
      type = defines.controllers.character,
      character = nauvis_character
    }
    luna_character.color = player.color
    luna_character.walking_state = {walking = false}
    luna_character.associated_player = player
    player.set_shortcut_toggled(SHORTCUT_NAME, false)

    moon_view_data.nauvis_character = nil  -- Clear info from old method
    moon_view_data.luna_character = nil
  elseif player.surface.name == "nauvis" then
    local nauvis_character = player.character
    local luna_character = MoonView.get_associated_character(player)
    if not luna_character then
      -- Check old method
      luna_character = moon_view_data.luna_character
    end
    if not luna_character or not luna_character.valid then
      luna_character = game.get_surface("luna").create_entity{
        name = "ll-remote-drone",
        position = {0, 0},
        force = player.force,
        direction = defines.direction.east,
        create_build_effect_smoke = false,
      }
    end
    player.set_controller{
      type = defines.controllers.spectator,
    }
    player.teleport({0, 0}, "luna")
    player.set_controller{
      type = defines.controllers.character,
      character = luna_character,
    }
    nauvis_character.color = player.color
    nauvis_character.walking_state = {walking = false}
    nauvis_character.associated_player = player
    player.set_shortcut_toggled(SHORTCUT_NAME, true)

    moon_view_data.nauvis_character = nil  -- Clear info from old method
    moon_view_data.luna_character = nil
  end
end

local function on_lua_shortcut(event)
  if event.prototype_name == SHORTCUT_NAME then
    MoonView.toggle_moon_view(event)
  end
end

local function on_player_respawned(event)
  local player = game.get_player(event.player_index)
  if player.surface.name ~= "luna" then return end
  local old_character = player.character
  local luna_character = game.get_surface("luna").create_entity{
    name = "ll-remote-drone",
    position = old_character.position,
    force = player.force,
    direction = defines.direction.east,
    create_build_effect_smoke = false,
  }
  player.set_controller{
    type = defines.controllers.character,
    character = luna_character,
  }
  old_character.destroy()
end

local function on_chunk_generated(event)
  local surface = event.surface
  if surface.name ~= "luna" then return end
  local position = event.position
  if position.x % 3 ~= 0 or position.y % 3 ~= 0 then return end  -- Place radars in the middle of each 3x3
  local chunk_area = event.area
  local chunk_center = {x = (chunk_area.left_top.x + chunk_area.right_bottom.x) / 2, y = (chunk_area.left_top.y + chunk_area.right_bottom.y) / 2}
  local radar = surface.create_entity({
    name = "ll-hidden-radar",
    position = chunk_center,
    force = game.forces.player,
  })
  radar.destructible = false
end

MoonView.events = {
  [SHORTCUT_NAME] = MoonView.toggle_moon_view,
  [defines.events.on_lua_shortcut] = on_lua_shortcut,
  [defines.events.on_player_respawned] = on_player_respawned,
  [defines.events.on_chunk_generated] = on_chunk_generated,
}

MoonView.on_init = function ()
  global.moon_view_data = {}
end

MoonView.on_configuration_changed = function(changed_data)
  global.moon_view_data = global.moon_view_data or {}
end

return MoonView
