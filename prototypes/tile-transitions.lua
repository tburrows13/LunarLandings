local tile_graphics = require("__base__/prototypes/tile/tile-graphics")
local tile_spritesheet_layout = tile_graphics.tile_spritesheet_layout
local patch_for_inner_corner_of_transition_between_transition = tile_graphics.patch_for_inner_corner_of_transition_between_transition

local ground_to_out_of_map_transition =
{
  to_tiles = out_of_map_tile_type_names,
  transition_group = out_of_map_transition_group_id,

  background_layer_offset = 1,
  background_layer_group = "zero",
  offset_background_layer_by_tile_layer = true,

  spritesheet = "__base__/graphics/terrain/out-of-map-transition/out-of-map-transition.png",
  layout = tile_spritesheet_layout.transition_4_4_8_1_1,
  overlay_enabled = false
}


local function dark_dirt_transitions()
  return {
    {
      to_tiles = water_tile_type_names,
      transition_group = water_transition_group_id,

      spritesheet = "__base__/graphics/terrain/water-transitions/dark-dirt.png",
      layout = tile_spritesheet_layout.transition_8_8_8_2_4,
      background_enabled = false,
      effect_map_layout =
      {
        spritesheet = "__base__/graphics/terrain/effect-maps/water-dirt-mask.png",
        o_transition_count = 1
      }
    },
    ground_to_out_of_map_transition
  }
end

local dirt_out_of_map_transition =
{
  transition_group1 = default_transition_group_id,
  transition_group2 = out_of_map_transition_group_id,

  background_layer_offset = 1,
  background_layer_group = "zero",
  offset_background_layer_by_tile_layer = true,

  spritesheet = "__base__/graphics/terrain/out-of-map-transition/dirt-out-of-map-transition.png",
  layout = tile_spritesheet_layout.transition_3_3_3_1_0,
  overlay_enabled = false
}

local function dark_dirt_transitions_between_transitions()
  return {
    {
      transition_group1 = default_transition_group_id,
      transition_group2 = water_transition_group_id,

      spritesheet = "__base__/graphics/terrain/water-transitions/dark-dirt-transition.png",
      layout = tile_spritesheet_layout.transition_3_3_3_1_0,
      background_enabled = false,
      effect_map_layout =
      {
        spritesheet = "__base__/graphics/terrain/effect-maps/water-dirt-to-land-mask.png",
        o_transition_count = 0
      },
      water_patch = patch_for_inner_corner_of_transition_between_transition,
    },
    dirt_out_of_map_transition,
    {
      transition_group1 = water_transition_group_id,
      transition_group2 = out_of_map_transition_group_id,

      background_layer_offset = 1,
      background_layer_group = "zero",
      offset_background_layer_by_tile_layer = true,

      spritesheet = "__base__/graphics/terrain/out-of-map-transition/dark-dirt-shore-out-of-map-transition.png",
      layout = tile_spritesheet_layout.transition_3_3_3_1_0,
      effect_map_layout =
      {
        spritesheet = "__base__/graphics/terrain/effect-maps/water-dirt-to-out-of-map-mask.png",
        u_transition_count = 0,
        o_transition_count = 0
      }
    }
  }
end


local function cliff_transitions()
  return {
        {
          to_tiles = {
            "water",
            "deepwater",
            "water-green",
            "deepwater-green",
            "water-shallow",
            "water-mud",
            "water-wube"
          },
          transition_group = 1,
          spritesheet = "__alien-biomes-graphics__/graphics/terrain/water-transitions/cliff.png",
          layout = {
            overlay = {
              inner_corner = {
                count = 8,
                line_length = 8,
                scale = 0.5,
                tile_height = 2,
                x = 0,
                y = 0,
              },
              o_transition = {
                count = 4,
                line_length = 4,
                scale = 0.5,
                tile_height = 1,
                x = 0,
                y = 2304,
              },
              outer_corner = {
                count = 8,
                line_length = 8,
                scale = 0.5,
                tile_height = 2,
                x = 0,
                y = 576,
              },
              side = {
                count = 8,
                line_length = 8,
                scale = 0.5,
                tile_height = 2,
                x = 0,
                y = 1152,
              },
              u_transition = {
                count = 2,
                line_length = 2,
                scale = 0.5,
                tile_height = 2,
                x = 0,
                y = 1728,
              }
            },
            background = {
              inner_corner = {
                count = 8,
                line_length = 8,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 0,
              },
              o_transition = {
                count = 4,
                line_length = 4,
                scale = 0.5,
                tile_height = 1,
                x = 1088,
                y = 2304,
              },
              outer_corner = {
                count = 8,
                line_length = 8,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 576,
              },
              side = {
                count = 8,
                line_length = 8,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 1152
              },
              u_transition = {
                count = 2,
                line_length = 2,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 1728,
              }
            },
            mask = {
              inner_corner = {
                count = 8,
                line_length = 8,
                scale = 0.5,
                x = 2176,
                y = 0,
              },
              o_transition = {
                count = 4,
                line_length = 4,
                scale = 0.5,
                x = 2176,
                y = 2304,
              },
              outer_corner = {
                count = 8,
                line_length = 8,
                scale = 0.5,
                x = 2176,
                y = 576,
              },
              side = {
                count = 8,
                line_length = 8,
                scale = 0.5,
                x = 2176,
                y = 1152,
              },
              u_transition = {
                count = 2,
                line_length = 2,
                scale = 0.5,
                x = 2176,
                y = 1728,
              }
            },
          },
        },
        {
          to_tiles = {
            "out-of-map"
          },
          transition_group = 2,
          spritesheet = "__base__/graphics/terrain/out-of-map-transition/out-of-map-transition.png",
          background_layer_group = "zero",
          background_layer_offset = 1,
          offset_background_layer_by_tile_layer = true,
          layout = {
            background = {
              inner_corner = {
                count = 4,
                line_length = 4,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 0
              },
              o_transition = {
                count = 1,
                line_length = 1,
                scale = 0.5,
                tile_height = 1,
                x = 1088,
                y = 2304,
              },
              outer_corner = {
                count = 4,
                line_length = 4,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 576,
              },
              side = {
                count = 8,
                line_length = 8,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 1152,
              },
              u_transition = {
                count = 1,
                line_length = 1,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 1728,
              }
            },
            mask = {
              inner_corner = {
                count = 4,
                line_length = 4,
                scale = 0.5,
                x = 2176,
                y = 0,
              },
              o_transition = {
                count = 1,
                line_length = 1,
                scale = 0.5,
                x = 2176,
                y = 2304,
              },
              outer_corner = {
                count = 4,
                line_length = 4,
                scale = 0.5,
                x = 2176,
                y = 576,
              },
              side = {
                count = 8,
                line_length = 8,
                scale = 0.5,
                x = 2176,
                y = 1152,
              },
              u_transition = {
                count = 1,
                line_length = 1,
                scale = 0.5,
                x = 2176,
                y = 1728,
              }
            },
          },
        }
      }

end

function cliff_transitions_between_transitions()
  return {
        {
          --transition_group = 0,
          transition_group1 = 0,
          transition_group2 = 1,
          spritesheet = "__alien-biomes-graphics__/graphics/terrain/water-transitions/cliff-transition.png",
          layout = {
            overlay = {
              inner_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                tile_height = 2,
                x = 0,
                y = 0,
              },
              outer_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                tile_height = 2,
                x = 0,
                y = 576,
              },
              side = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                tile_height = 2,
                x = 0,
                y = 1152,
              },
              u_transition = {
                count = 1,
                line_length = 1,
                scale = 0.5,
                tile_height = 2,
                x = 0,
                y = 1728,
              }
            },
            background = {
              inner_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 0,
              },
              outer_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 576,
              },
              side = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 1152,
              },
              u_transition = {
                count = 1,
                line_length = 1,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 1728,
              }
            },
            mask = {
              inner_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                x = 2176,
                y = 0,
              },
              outer_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                x = 2176,
                y = 576,
              },
              side = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                x = 2176,
                y = 1152,
              },
              u_transition = {
                count = 1,
                line_length = 1,
                scale = 0.5,
                x = 2176,
                y = 1728,
              }
            },
          },
          water_patch = {
            filename = "__base__/graphics/terrain/water-transitions/water-patch.png",
            height = 64,
            scale = 0.5,
            width = 64
          }
        },
        {
          --transition_group = 0,
          transition_group1 = 0,
          transition_group2 = 2,
          background_layer_group = "zero",
          background_layer_offset = 1,
          offset_background_layer_by_tile_layer = true,
          spritesheet = "__base__/graphics/terrain/out-of-map-transition/dirt-out-of-map-transition.png",
          layout = {
            background = {
              inner_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 0,
              },
              outer_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 576,
              },
              side = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 1152,
              },
              u_transition = {
                count = 1,
                line_length = 1,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 1728,
              }
            },
            mask = {
              inner_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                x = 2176,
                y = 0,
              },
              outer_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                x = 2176,
                y = 576,
              },
              side = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                x = 2176,
                y = 1152,
              },
              u_transition = {
                count = 1,
                line_length = 1,
                scale = 0.5,
                x = 2176,
                y = 1728,
              }
            },
          },
          water_patch = nil
        },
        {
          --transition_group = 1,
          transition_group1 = 1,
          transition_group2 = 2,
          background_layer_group = "zero",
          background_layer_offset = 1,
          offset_background_layer_by_tile_layer = true,
          spritesheet = "__base__/graphics/terrain/out-of-map-transition/dark-dirt-shore-out-of-map-transition.png",
          layout = {
            overlay = {
              inner_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                tile_height = 2,
                x = 0,
                y = 0,
              },
              outer_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                tile_height = 2,
                x = 0,
                y = 576,
              },
              side = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                tile_height = 2,
                x = 0,
                y = 1152,
              },
              u_transition = {
                count = 1,
                line_length = 1,
                scale = 0.5,
                tile_height = 2,
                x = 0,
                y = 1728,
              }
            },
            background = {
              inner_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 0,
              },
              outer_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 576,
              },
              side = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 1152,
              },
              u_transition = {
                count = 1,
                line_length = 1,
                scale = 0.5,
                tile_height = 2,
                x = 1088,
                y = 1728,
              }
            },
            mask = {
              inner_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                x = 2176,
                y = 0,
              },
              outer_corner = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                x = 2176,
                y = 576,
              },
              side = {
                count = 3,
                line_length = 3,
                scale = 0.5,
                x = 2176,
                y = 1152,
              },
              u_transition = {
                count = 1,
                line_length = 1,
                scale = 0.5,
                x = 2176,
                y = 1728,
              }
            },
          },
          water_patch = nil
        }
      }
end

return {
  dark_dirt_transitions = dark_dirt_transitions,
  dark_dirt_transitions_between_transitions = dark_dirt_transitions_between_transitions,
  cliff_transitions = cliff_transitions,
  cliff_transitions_between_transitions = cliff_transitions_between_transitions,
}
