local main_menu_simulations = {}

-- Copied from space-age
--special variables:
-- sim_planet = current sim surface
-- on_tick = override to do stuff on given tick when timeline_tools are included
local make_simulation = function(duration, planet, filename, script)
  return
  {
    checkboard = false,
    save = "__LunarLandings__/simulations/" .. filename,
    length = duration,
    init =
    [[
      local sim_planet = game.surfaces["]] .. planet .. [["]
      local logo = sim_planet.find_entities_filtered{name = "factorio-logo-22tiles", limit = 1}[1]
      logo.destructible = false
      local center = {logo.position.x, logo.position.y+21}
      game.simulation.camera_surface_index = sim_planet.index
      game.simulation.camera_position = center
      game.simulation.camera_zoom = 0.5
      game.tick_paused = false
    ]]
    ..
    script
  }
end

local timeline_tools =
  [[
    local tick = 0
    local on_tick = function() end
    script.on_nth_tick(1,
      function()
        tick = tick + 1
        on_tick()
      end)
  ]]

main_menu_simulations.luna_1 = make_simulation(60 * 60, "luna", "menu-simulation-luna-1.zip",
timeline_tools ..
[[
  local character = game.surfaces.luna.create_entity{name = "ll-remote-drone", position = {logo.position.x-35, logo.position.y+70}, create_build_effect_smoke = false}
  character.color = {r = 0, g = 1, b = 0.2}
  character.walking_state = {walking = true, direction = defines.direction.southwest}
  character.walking_state = {walking = false}

  on_tick = function()
    if tick==420 and character.valid then
      character.walking_state = {walking = true, direction = defines.direction.north}
    end
    if tick==670 and character.valid then
      character.walking_state = {walking = false}
    end
    if tick==700 and character.valid then
      character.walking_state = {walking = true, direction = defines.direction.northeast}
    end
    if tick==850 and character.valid then
      character.walking_state = {walking = false}
    end
    if tick==900 and character.valid then
      character.walking_state = {walking = true, direction = defines.direction.north}
    end
    if tick==990 and character.valid then
      character.walking_state = {walking = false}
    end
    if tick==1040 and character.valid then
      character.walking_state = {walking = true, direction = defines.direction.east}
    end
    if tick==1270 and character.valid then
      character.walking_state = {walking = false}
    end
    if tick==1500 and character.valid then
      character.walking_state = {walking = true, direction = defines.direction.southeast}
    end
    if tick==1540 and character.valid then
      character.walking_state = {walking = false}
    end
    if tick==1700 and character.valid then
      character.walking_state = {walking = true, direction = defines.direction.north}
    end
    if tick==2200 and character.valid then
      character.walking_state = {walking = true, direction = defines.direction.southwest}
      character.walking_state = {walking = false}
    end
  end
]]
)


data.raw["utility-constants"]["default"].main_menu_simulations = main_menu_simulations