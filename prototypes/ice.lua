local sounds = require("__base__.prototypes.entity.sounds")

data:extend{
  {
    type = "item",
    name = "ll-ice",
    icon = "__space-exploration-graphics__/graphics/icons/water-ice.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "raw-resource",
    order = "h[moon]-d[ice]",
    stack_size = 50
  },
  {
    type = "resource",
    name = "ll-ice",
    icon = "__space-exploration-graphics__/graphics/icons/water-ice.png",
    icon_size = 64, icon_mipmaps = 1,
    flags = {"placeable-neutral"},
    category = "ll-core",
    subgroup = "raw-resource",
    order="a-b-a",
    infinite = true,
    infinite_depletion_amount = 0,
    selection_priority = 49,
    highlight = true,
    minimum = 60000,
    normal = 300000,
    --infinite_depletion_amount = 10,
    resource_patch_search_radius = 12,
    --tree_removal_probability = 0.7,
    --tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_time = 1,
      results =
      {
        {
          type = "item",
          name = "ll-ice",
          amount = 1
        }
      }
    },
    walking_sound = sounds.oil,
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    --[[autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "crude-oil",
      order = "c", -- Other resources are "b"; oil won't get placed if something else is already there.
      base_density = 8.2,
      base_spots_per_km2 = 1.8,
      random_probability = 1/48,
      random_spot_size_minimum = 1,
      random_spot_size_maximum = 1, -- don't randomize spot size
      additional_richness = 220000, -- this increases the total everywhere, so base_density needs to be decreased to compensate
      has_starting_area_placement = false,
      regular_rq_factor_multiplier = 1
    },]]
    stage_counts = {0},
    stages =
    {
      sheet =
      {
        filename = "__LunarLandings__/graphics/ice.png",
        priority = "extra-high",
        width = 474,
        height = 337,
        frame_count = 1,
        variation_count = 1,
        shift = util.by_pixel(0, -2),
        scale = 0.25,
        hr_version =
        {
          filename = "__LunarLandings__/graphics/ice.png",
          priority = "extra-high",
          width = 474,
          height = 337,
          frame_count = 1,
          variation_count = 1,
          shift = util.by_pixel(0, -2),
          scale = 0.25
        }
      }
    },
    map_color = {0.1, 0.2, 0.8},
    map_grid = false,
    surface_conditions = {nauvis = false, luna = true},
  }

}