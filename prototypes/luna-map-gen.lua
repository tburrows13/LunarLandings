-- /c game.print(serpent.block(game.player.surface.calculate_tile_properties({"elevation"}, {game.player.character.position})))

data:extend{
  {
    type = "noise-expression",
    name = "luna_terrain",
    expression = "make_0_12like_lakes{x = x,\z
                                      y = y,\z
                                      bias = -1000,\z
                                      terrain_octaves = 8,\z
                                      segmentation_multiplier = 1}"
  },
  {
    type = "noise-expression",
    name = "luna_elevation",
    intended_property = "elevation",
    expression = "luna_terrain"-- + luna_mountains"
  },
}