---@type ScriptLib
local MoonView = {}

-- TODO handle incorrect character after respawn or editor-change-surface

local SHORTCUT_NAME = "ll-toggle-moon-view"

function MoonView.get_data(player_index)
  global.moon_view_data[player_index] = global.moon_view_data[player_index] or {}
  return global.moon_view_data[player_index]
end

function MoonView.toggle_moon_view(event)
  local player = game.players[event.player_index]
  if not player.force.technologies["ll-luna-exploration"].researched then
    game.print("Connection to Luna robot not established. Research Luna Exploration first.")
    return
  end
  if player.controller_type ~= defines.controllers.character then return end
  local moon_view_data = MoonView.get_data(event.player_index)
  if player.surface.name == "luna" then
    moon_view_data.luna_character = player.character
    -- Player is on moon
    -- Can't set controller to character on another surface, and teleporting the player also teleports the character
    player.set_controller{
      type = defines.controllers.spectator,
    }
    player.teleport({0, 0}, "nauvis")
    player.set_controller{
      type = defines.controllers.character,
      character = moon_view_data.nauvis_character
    }
    player.set_shortcut_toggled(SHORTCUT_NAME, false)
  elseif player.surface.name == "nauvis" then
    moon_view_data.nauvis_character = player.character
    local luna_character = moon_view_data.luna_character
    if not luna_character or not luna_character.valid then
      luna_character = game.get_surface("luna").create_entity{
        name = "ll-remote-drone",
        position = {0, 0},
        force = player.force,
        create_build_effect_smoke = false,
      }
      moon_view_data.luna_character = luna_character
    end
    player.set_controller{
      type = defines.controllers.spectator,
    }
    player.teleport({0, 0}, "luna")
    player.set_controller{
      type = defines.controllers.character,
      character = luna_character,
    }
    player.set_shortcut_toggled(SHORTCUT_NAME, true)
  end
end

local function on_lua_shortcut(event)
  if event.prototype_name == SHORTCUT_NAME then
    MoonView.toggle_moon_view(event)
  end
end

MoonView.events = {
  [SHORTCUT_NAME] = MoonView.toggle_moon_view,
  [defines.events.on_lua_shortcut] = on_lua_shortcut,
}

MoonView.on_init = function ()
  global.moon_view_data = {}
end

MoonView.on_configuration_changed = function(changed_data)
  global.moon_view_data = global.moon_view_data or {}
end

MoonView.on_nth_tick = {
  [360] = function()
    game.forces["player"].rechart("luna")
  end
}

return MoonView
