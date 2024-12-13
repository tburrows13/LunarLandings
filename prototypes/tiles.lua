local tile_trigger_effects = require("__base__.prototypes.tile.tile-trigger-effects")
local sounds = require("__base__.prototypes.entity.sounds")
--local transitions = require("__alien-biomes__/prototypes/tile/tile-transitions-static")

local moon_autoplace = {
  default_enabled = false,
  probability_expression = "(elevation) * inf"
}
local rough_moon_autoplace = {
  default_enabled = false,
  probability_expression = "(-elevation) * inf"
}
local mountain_moon_autoplace = {
  default_enabled = false,
  probability_expression = "(elevation - 20) * 100 * inf"
}


data:extend{
  {
    type = "item-subgroup",
    name = "luna-tiles",
    group = "tiles",
    order = "b-a"
  },
  {
    name = "ll-luna-plain",
    type = "tile",
    order = "e[moon]-a",
    subgroup = "luna-tiles",
    collision_mask = {layers={ground_tile=true}},
    autoplace = moon_autoplace,
    layer = 10,  -- Will be overwritten by Alien Biomes in data-final-fixes, then in Lunar Landings
    variants = tile_variations_template(
      "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid.png", "__base__/graphics/terrain/masks/transition-1.png",
      {
        max_size = 4,
        [1] = { weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045 } },
        [2] = { probability = 1, weights = {0.070, 0.070, 0.025, 0.070, 0.070, 0.070, 0.007, 0.025, 0.070, 0.050, 0.015, 0.026, 0.030, 0.005, 0.070, 0.027 } },
        [4] = { probability = 1.00, weights = {0.070, 0.070, 0.070, 0.070, 0.070, 0.070, 0.015, 0.070, 0.070, 0.070, 0.015, 0.050, 0.070, 0.070, 0.065, 0.070 }, },
        --[8] = { probability = 1.00, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} }
      }
    ),

    --transitions = transitions.cliff_transitions(),  -- to_tiles is set later -- TODO 2.0
    --transitions_between_transitions = transitions.cliff_transitions_between_transitions(),

    walking_sound = table.deepcopy(data.raw.tile["dirt-1"].walking_sound),
    map_color={r=150, g=150, b=150},
    --scorch_mark_color = {r = 0.541, g = 0.407, b = 0.248, a = 1.000},
    vehicle_friction_modifier = 1.5,
    can_be_part_of_blueprint = false,

    --trigger_effect = tile_trigger_effects.dirt_1_trigger_effect()
  },
  {
    name = "ll-luna-lowland",
    type = "tile",
    order = "e[moon]-b",
    subgroup = "luna-tiles",
    collision_mask = {layers={ground_tile=true}},
    autoplace = rough_moon_autoplace,
    layer = 22,
    variants = tile_variations_template(
      "__alien-biomes-graphics__/graphics/terrain/mineral-grey-dirt-2.png", "__base__/graphics/terrain/masks/transition-1.png",
      {
        max_size = 4,
        [1] = { weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045 } },
        [2] = { probability = 1, weights = {0.070, 0.070, 0.025, 0.070, 0.070, 0.070, 0.007, 0.025, 0.070, 0.050, 0.015, 0.026, 0.030, 0.005, 0.070, 0.027 } },
        [4] = { probability = 1.00, weights = {0.070, 0.070, 0.070, 0.070, 0.070, 0.070, 0.015, 0.070, 0.070, 0.070, 0.015, 0.050, 0.070, 0.070, 0.065, 0.070 }, },
        --[8] = { probability = 1.00, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} }
      }
    ),

    transitions = dark_dirt_transitions,
    transitions_between_transitions = dark_dirt_transitions_between_transitions,

    walking_sound = dirt_sounds,
    map_color={r=50, g=50, b=50},
    scorch_mark_color = {r = 0.420, g = 0.304, b = 0.191, a = 1.000},
    vehicle_friction_modifier = dirt_vehicle_speed_modifier,

    trigger_effect = tile_trigger_effects.dirt_4_trigger_effect()
  },
  {
    name = "ll-luna-mountain",
    type = "tile",
    order = "e[moon]-c",
    subgroup = "luna-tiles",
    collision_mask = {layers={ground_tile=true}},
    autoplace = mountain_moon_autoplace,
    layer = 22,
    variants = tile_variations_template(
      "__alien-biomes-graphics__/graphics/terrain/mineral-white-dirt-4.png", "__base__/graphics/terrain/masks/transition-1.png",
      {
        max_size = 4,
        [1] = { weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045 } },
        [2] = { probability = 1, weights = {0.070, 0.070, 0.025, 0.070, 0.070, 0.070, 0.007, 0.025, 0.070, 0.050, 0.015, 0.026, 0.030, 0.005, 0.070, 0.027 } },
        [4] = { probability = 1.00, weights = {0.070, 0.070, 0.070, 0.070, 0.070, 0.070, 0.015, 0.070, 0.070, 0.070, 0.015, 0.050, 0.070, 0.070, 0.065, 0.070 }, },
        --[8] = { probability = 1.00, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} }
      }
    ),

    --transitions = transitions.cliff_transitions(),  -- to_tiles is set later -- TODO 2.0
    --transitions_between_transitions = transitions.cliff_transitions_between_transitions(),

    walking_sound = dirt_sounds,
    map_color={r=200, g=200, b=200},
    scorch_mark_color = {r = 0.420, g = 0.304, b = 0.191, a = 1.000},
    vehicle_friction_modifier = dirt_vehicle_speed_modifier,

    trigger_effect = tile_trigger_effects.dirt_4_trigger_effect()
  },

  {
    type = "tile",
    name = "ll-lunar-foundation",
    order = "e[moon]-d[foundation]",
    subgroup = "luna-tiles",
    needs_correction = false,
    minable = {mining_time = 0.1, result = "ll-lunar-foundation"},
    mined_sound = sounds.deconstruct_bricks(0.8),
    collision_mask = {layers={ground_tile=true}},
    walking_speed_modifier = 1.5,
    layer = 64,
    transition_overlay_layer_offset = 2, -- need to render border overlay on top of hazard-concrete
    decorative_removal_probability = 0.25,
    check_collision_with_entities = true,
    variants =
    {
      empty_transitions = true,
      main = {
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile1.png",
        count = 12,
        size = 1,
        scale = 0.5
      },},

      inner_corner =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-inner-corner.png",
        count = 1,
        scale = 0.5
      },
      inner_corner_mask =
      {
        picture = "__base__/graphics/terrain/concrete/concrete-inner-corner-mask.png",
        count = 16,
        scale = 0.5
      },

      outer_corner =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-outer-corner.png",
        count = 1,
        scale = 0.5
      },
      outer_corner_mask =
      {
        picture = "__base__/graphics/terrain/concrete/concrete-outer-corner-mask.png",
        count = 8,
        scale = 0.5
      },

      side =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-side.png",
        count = 16,
        scale = 0.5
      },
      side_mask =
      {
        picture = "__base__/graphics/terrain/concrete/concrete-side-mask.png",
        count = 16,
        scale = 0.5
      },

      u_transition =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-u.png",
        count = 1,
        scale = 0.5
      },
      u_transition_mask =
      {
        picture = "__base__/graphics/terrain/concrete/concrete-u-mask.png",
        count = 8,
        scale = 0.5
      },

      o_transition =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-o.png",
        count = 1,
        scale = 0.5
      },
      o_transition_mask =
      {
        picture = "__base__/graphics/terrain/concrete/concrete-o-mask.png",
        count = 4,
        scale = 0.5
      },
    },

    transitions = concrete_transitions,
    transitions_between_transitions = concrete_transitions_between_transitions,

    --walking_sound = refined_concrete_sounds,
    --build_sound = concrete_tile_build_sounds,

    map_color={r=49, g=48, b=45},
    scorch_mark_color = {r = 0.373, g = 0.307, b = 0.243, a = 1.000},
    --vehicle_friction_modifier = concrete_vehicle_speed_modifier,

    trigger_effect = tile_trigger_effects.concrete_trigger_effect()
  },
  {
    type = "item",
    name = "ll-lunar-foundation",
    icon = "__space-exploration-graphics__/graphics/icons/space-platform-plating.png",
    icon_size = 64,
    subgroup = "terrain",
    order = "e[moon]-a[foundation]",
    stack_size = 100,
    place_as_tile =
    {
      result = "ll-lunar-foundation",
      condition_size = 1,
      condition = {layers={water_tile=true}},  -- Will be overwritten in data-final-fixes
    }
  },
  {
    type = "recipe",
    name = "ll-lunar-foundation",
    energy_required = 15,
    enabled = false,
    category = "crafting-with-fluid",
    ingredients =
    {
      {type="item", name="stone-brick", amount=40},
      {type="item", name="steel-plate", amount=4},
      {type="fluid", name="water", amount=10}
    },
    results = {{type="item", name="ll-lunar-foundation", amount=5}},
  },
}

--data.raw.tile["ll-luna-plain"].transitions[1].to_tiles = {"ll-luna-lowland"}  -- TODO 2.0
--data.raw.tile["ll-luna-mountain"].transitions[1].to_tiles = {"ll-luna-lowland"}

data.raw["legacy-straight-rail"]["legacy-straight-rail"].ll_surface_conditions = {nauvis = true, luna = false}
data.raw["legacy-curved-rail"]["legacy-curved-rail"].ll_surface_conditions = {nauvis = true, luna = false}
data.raw["straight-rail"]["straight-rail"].ll_surface_conditions = {nauvis = true, luna = false}
data.raw["half-diagonal-rail"]["half-diagonal-rail"].ll_surface_conditions = {nauvis = true, luna = false}
data.raw["curved-rail-a"]["curved-rail-a"].ll_surface_conditions = {nauvis = true, luna = false}
data.raw["curved-rail-b"]["curved-rail-b"].ll_surface_conditions = {nauvis = true, luna = false}
data.raw["assembling-machine"]["assembling-machine-1"].ll_surface_conditions = {nauvis = true, luna = {plain = false, lowland = false, mountain = false, foundation = true}}
data.raw["assembling-machine"]["assembling-machine-2"].ll_surface_conditions = {nauvis = true, luna = {plain = false, lowland = false, mountain = false, foundation = true}}
data.raw["assembling-machine"]["assembling-machine-3"].ll_surface_conditions = {nauvis = true, luna = {plain = false, lowland = false, mountain = false, foundation = true}}
data.raw["assembling-machine"]["chemical-plant"].ll_surface_conditions = {nauvis = true, luna = {plain = false, lowland = false, mountain = false, foundation = true}}
data.raw["assembling-machine"]["oil-refinery"].ll_surface_conditions = {nauvis = true, luna = {plain = false, lowland = false, mountain = false, foundation = true}}
data.raw["assembling-machine"]["centrifuge"].ll_surface_conditions = {nauvis = true, luna = {plain = false, lowland = false, mountain = false, foundation = true}}
