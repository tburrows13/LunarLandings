local sounds = require("__base__.prototypes.entity.sounds")

data:extend{
  {
    type = "item",
    name = "ll-ice",
    icon = "__LunarLandings__/graphics/icons/ice.png",
    icon_size = 64,
    pictures =
    {
      { size = 64, filename = "__LunarLandings__/graphics/icons/ice.png",   scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/ice-2.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/ice-3.png", scale = 0.25, mipmap_count = 4 },
    },
    subgroup = "raw-resource",
    order = "h[moon]-d[ice]",
    stack_size = 50
  },
  {
    type = "resource",
    name = "ll-ice",
    icon = "__space-exploration-graphics__/graphics/icons/water-ice.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    category = "ll-core",
    subgroup = "raw-resource",
    order="a-b-a",
    selection_priority = 49,
    highlight = true,
    infinite = true,
    minimum = 40000,
    normal = 100000,
    infinite_depletion_amount = 1,
    resource_patch_search_radius = 12,
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
    collision_box = {{-5.4, -5.4}, {5.4, 5.4}},
    selection_box = {{-5.5, -5.5}, {5.5, 5.5}},
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
        shift = util.by_pixel(-2, -2),
        scale = 0.6,
      }
    },
    map_color = {0.1, 0.2, 0.5},
    map_grid = false,
    surface_conditions = {nauvis = false, luna = true},
  }

}