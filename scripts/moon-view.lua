---@type ScriptLib
local MoonView = {}

function MoonView.get_data(player_index)
  global.moon_view_data[player_index] = global.moon_view_data[player_index] or {}
  return global.moon_view_data[player_index]
end

function MoonView.toggle_moon_view(event)
  local player = game.players[event.player_index]
  --if not global.satellites_launched[player.force.name] then return end
  --if not player.force.technologies["ll-luna-exploration"].researched then return end
  if player.controller_type ~= defines.controllers.character then return end
  local moon_view_data = MoonView.get_data(event.player_index)
  if player.surface.name == "luna" then
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
  elseif player.surface.name == "nauvis" then
    moon_view_data.nauvis_character = player.character
    local luna_character = moon_view_data.luna_character
    if not luna_character then
      luna_character = game.get_surface("luna").create_entity{
        name = "character",
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
  end
end

MoonView.events = {
  ["ll-toggle-moon-view"] = MoonView.toggle_moon_view,
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
