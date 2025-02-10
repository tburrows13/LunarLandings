-- /c game.print(serpent.block(game.player.surface.calculate_tile_properties({"elevation"}, {game.player.character.position})))

data:extend{
  {
    type = "noise-expression",
    name = "cliffiness_luna",
    --intended_property = "cliffiness",
    -- Cliffiness only determines small-scale placement to ensure that there are gaps in the mountain.
    -- Increase input_scale to make gaps smaller
    -- Increase 0.4 to reduce total number of gaps
    expression = "clamp(0.5 * log2(cliff_richness) + 0.4 +\z
                        quick_multioctave_noise{x = x,\z
                                                y = y,\z
                                                seed0 = map_seed,\z
                                                seed1 = 123,\z
                                                input_scale = 1/2,\z
                                                output_scale = 1,\z
                                                octaves = 2,\z
                                                octave_output_scale_multiplier = 1,\z
                                                octave_input_scale_multiplier = 1/3},\z
                        0, 1) + 0.5"
  },
  { -- Cliffs don't spawn on transition from negative elevation to 80+ so need to convert all non-mountain elevation to ~5
    type = "noise-expression",
    name = "cliff_elevation_luna",
    expression = "if(luna_mountain_mask, elevation, 5)"
  },
  {
    type = "noise-function",
    name = "luna_make_0_12like_lakes",
    parameters = {"x", "y", "bias", "terrain_octaves", "segmentation_multiplier"},
    expression = "max(bias + variable_persistence_multioctave_noise{x = x,\z
                                                                    y = y,\z
                                                                    seed0 = map_seed,\z
                                                                    seed1 = 1,\z
                                                                    input_scale = input_scale,\z
                                                                    output_scale = 0.125,\z
                                                                    offset_x = offset_x,\z
                                                                    octaves = terrain_octaves,\z
                                                                    persistence = 0.5},\z
                      20 + water_level - 0.1 * segmentation_multiplier * distance + \z
                      variable_persistence_multioctave_noise{x = x,\z
                                                             y = y,\z
                                                             seed0 = map_seed,\z
                                                             seed1 = 2,\z
                                                             input_scale = input_scale,\z
                                                             output_scale = 0.125,\z
                                                             offset_x = offset_x,\z
                                                             octaves = 6,\z
                                                             persistence = 0.5})",
    local_expressions =
    {
      input_scale = "segmentation_multiplier / 2",
      offset_x = "10000 / segmentation_multiplier",
    }
  },
  {
    type = "noise-expression",
    name = "luna_terrain",
    expression = "luna_make_0_12like_lakes{x = x,\z
                                      y = y,\z
                                      bias = 20,\z
                                      terrain_octaves = 8,\z
                                      segmentation_multiplier = 1}"
  },
  { -- Creates spots using spot_noise - if > 0 then mountain
    type = "noise-expression",
    name = "luna_mountain_spots",
    expression = "(blobby_spots) * 60",  -- Increase multiplier to increase number of concentric cliff circles
    --expression = "if(blobby_spots > 0, 200, 0)",
    local_expressions =
    {
      blobs0 = "basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 199, input_scale = 1/8, output_scale = 1} + \z
                basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 199, input_scale = 1/24, output_scale = 1}",
      --blobs1 = "basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 199, input_scale = 1/64, output_scale = 1.5}",
      -- Increase 5 to make mountains further apart
      -- Increase spot_radius_expression to make mountains larger
      blobby_spots = "spot_noise{x = x / 5,\z
                                  y = y / 5,\z
                                  density_expression = 2,\z
                                  spot_quantity_expression = 1 * (distance > minimum_distance_from_start),\z
                                  spot_radius_expression = 1.7 * (distance > minimum_distance_from_start),\z
                                  spot_favorability_expression = (distance > minimum_distance_from_start),\z
                                  seed0 = map_seed,\z
                                  seed1 = 199,\z
                                  region_size = 1024,\z
                                  candidate_spot_count = 21,\z
                                  suggested_minimum_candidate_point_spacing = 40,\z
                                  hard_region_target_quantity = false,\z
                                  basement_value = -2,\z
                                  maximum_spot_basement_radius = 128} + \z
                         (blobs0 - 1/4) * (1/8) + 1",
      minimum_distance_from_start = "500 / 5", -- Divided by 5 to account for `x / 5` 3674061357
    }
  },
  {
    type = "noise-expression",
    name = "luna_mountain_mask",
    expression = "luna_mountain_spots > 0"
  },
  { -- Contains plain and lowland
    type = "noise-expression",
    name = "luna_flat_mask",
    expression = "1 - luna_mountain_mask"
  },
  {
    type = "noise-expression",
    name = "luna_elevation",
    intended_property = "elevation",
    expression = "if(luna_mountain_mask, luna_mountain_spots + 80,\z
                     min(luna_terrain, max_flat_elevation))",
    local_expressions =
    {
      max_flat_elevation = "10",
    }
  },
}