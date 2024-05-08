local surface = game.get_surface("luna")
if not surface then return end

for chunk in surface.get_chunks() do
  if surface.is_chunk_generated(chunk) then
    if chunk.x % 3 == 0 and chunk.y % 3 == 0 then
      -- Place radars in the middle of each 3x3
      local chunk_area = chunk.area
      local chunk_center = {x = (chunk_area.left_top.x + chunk_area.right_bottom.x) / 2, y = (chunk_area.left_top.y + chunk_area.right_bottom.y) / 2}
      local radar = surface.create_entity({
        name = "ll-hidden-radar",
        position = chunk_center,
        force = game.forces.player,
      })
      radar.destructible = false
    end
  end
end