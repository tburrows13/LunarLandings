for _, player in pairs(game.players) do
  player.opened = nil
end

for _, arc_furnace_data in pairs(storage.arc_furnaces) do
  arc_furnace_data.storage_tank_s.destroy()
  arc_furnace_data.storage_tank_w.destroy()
  arc_furnace_data.storage_tank_n.destroy()
  arc_furnace_data.storage_tank_e.destroy()
  arc_furnace_data.entity.fluidbox.add_linked_connection(1, arc_furnace_data.reactor, 1)
end