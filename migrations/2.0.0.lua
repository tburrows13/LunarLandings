for _, player in pairs(game.players) do
  player.opened = nil
end

for unit_number, arc_furnace_data in pairs(storage.arc_furnaces) do
  if arc_furnace_data.entity.valid and arc_furnace_data.reactor.valid then
    arc_furnace_data.storage_tank_s = nil
    arc_furnace_data.storage_tank_w = nil
    arc_furnace_data.storage_tank_n = nil
    arc_furnace_data.storage_tank_e = nil
    arc_furnace_data.entity.fluidbox.add_linked_connection(1, arc_furnace_data.reactor, 1)
  else
    storage.arc_furnaces[unit_number] = nil
  end
end

rendering.clear("LunarLandings")
storage.arc_furnace_heat_renders = {}

for _, force in pairs(game.forces) do
  force.technologies["ll-luna-exploration"].enabled = true
end

storage.satellites_launched = nil

if game.surfaces["luna"] then
  game.planets["luna"].associate_surface("luna")
end
