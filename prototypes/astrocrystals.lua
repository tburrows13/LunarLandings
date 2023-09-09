local resource_autoplace = require("__core__/lualib/resource-autoplace")

data:extend({
  {
    type = "resource",
    name = "ll-astrocrystals",
    category = "ll-core",
    icon = "__LunarLandings__/graphics/item/raw-imersite/raw-imersite.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = { "placeable-neutral" },
    order = "a-b-a",
    subgroup = "raw-resource",
    infinite = false,
    highlight = true,
    minimum = 50,
    normal = 350,
    infinite_depletion_amount = 10,
    resource_patch_search_radius = 12,
    tree_removal_probability = 1,
    tree_removal_max_distance = 32 * 32,
    minable = {
      hardness = 1,
      mining_time = 2,
      result = "ll-astrocrystals",
    },
    collision_box = { { -3.4, -3.4 }, { 3.4, 3.4 } },
    selection_box = { { -3.5, -3.5 }, { 3.5, 3.5 } },
    autoplace = resource_autoplace.resource_autoplace_settings({
      name = "ll-astrocrystals",
      order = "f",
      base_density = 1,
      richness_multiplier = 1,
      richness_multiplier_distance_bonus = 1.5,
      base_spots_per_km2 = 0.2,
      has_starting_area_placement = false,
      random_spot_size_minimum = 0.01,
      random_spot_size_maximum = 0.1,
      regular_blob_amplitude_multiplier = 1,
      richness_post_multiplier = 1.0,
      additional_richness = 350000,
      regular_rq_factor_multiplier = 0.1,
      candidate_spot_count = 22,
    }),
    stage_counts = { 0 },
    stages = {
      sheet = {
        filename = "__LunarLandings__/graphics/resources/imersite/imersite-rift.png",
        priority = "extra-high",
        width = 250,
        height = 250,
        frame_count = 6,
        variation_count = 1,
        scale = 0.8,
        hr_version = {
          filename = "__LunarLandings__/graphics/resources/imersite/hr-imersite-rift.png",
          priority = "extra-high",
          width = 500,
          height = 500,
          frame_count = 6,
          variation_count = 1,
          scale = 0.4,
        },
      },
    },
    stages_effect = {
      sheets = {
        {
          filename = "__LunarLandings__/graphics/resources/imersite/imersite-rift-glow.png",
          priority = "extra-high",
          width = 250,
          height = 250,
          frame_count = 6,
          variation_count = 1,
          draw_as_glow = true,
          scale = 0.8,
          hr_version = {
            filename = "__LunarLandings__/graphics/resources/imersite/hr-imersite-rift-glow.png",
            priority = "extra-high",
            width = 500,
            height = 500,
            frame_count = 6,
            variation_count = 1,
            scale = 0.4,
            draw_as_glow = true,
          },
        },
      },
    },
    effect_animation_period = 5,
    effect_animation_period_deviation = 1,
    effect_darkness_multiplier = 3.5,
    min_effect_alpha = 0.2,
    max_effect_alpha = 0.3,
    map_color = { r = 1, g = 0.5, b = 1 },
    mining_visualisation_tint = { r = 0.792, g = 0.050, b = 0.858 },
    map_grid = false,
  },
  {
    type = "item",
    name = "ll-astrocrystals",
    icon = "__LunarLandings__/graphics/item/raw-imersite/raw-imersite.png",
    icon_size = 64, icon_mipmaps = 4,
    pictures =
    {
      {
        layers = {
          {
            size = 64,
            filename = "__LunarLandings__/graphics/item/raw-imersite/raw-imersite.png",
            scale = 0.25,
            mipmap_count = 4,
          },
          {
            draw_as_light = true,
            flags = { "light" },
            blend_mode = "additive",
            tint = { r = 0.3, g = 0.3, b = 0.3, a = 0.3 },
            size = 64,
            filename = "__LunarLandings__/graphics/item/raw-imersite/raw-imersite-light.png",
            scale = 0.25,
            mipmap_count = 4,
          },
        },
      },
      {
        layers = {
          {
            size = 64,
            filename = "__LunarLandings__/graphics/item/raw-imersite/raw-imersite-1.png",
            scale = 0.25,
            mipmap_count = 4,
          },
          {
            draw_as_light = true,
            flags = { "light" },
            blend_mode = "additive",
            tint = { r = 0.3, g = 0.3, b = 0.3, a = 0.3 },
            size = 64,
            filename = "__LunarLandings__/graphics/item/raw-imersite/raw-imersite-1-light.png",
            scale = 0.25,
            mipmap_count = 4,
          },
        },
      },
      {
        layers = {
          {
            size = 64,
            filename = "__LunarLandings__/graphics/item/raw-imersite/raw-imersite-2.png",
            scale = 0.25,
            mipmap_count = 4,
          },
          {
            draw_as_light = true,
            flags = { "light" },
            blend_mode = "additive",
            tint = { r = 0.3, g = 0.3, b = 0.3, a = 0.3 },
            size = 64,
            filename = "__LunarLandings__/graphics/item/raw-imersite/raw-imersite-2-light.png",
            scale = 0.25,
            mipmap_count = 4,
          },
        },
      },
      {
        layers = {
          {
            size = 64,
            filename = "__LunarLandings__/graphics/item/raw-imersite/raw-imersite-3.png",
            scale = 0.25,
            mipmap_count = 4,
          },
          {
            draw_as_light = true,
            flags = { "light" },
            blend_mode = "additive",
            tint = { r = 0.3, g = 0.3, b = 0.3, a = 0.3 },
            size = 64,
            filename = "__LunarLandings__/graphics/item/raw-imersite/raw-imersite-3-light.png",
            scale = 0.25,
            mipmap_count = 4,
          },
        },
      },
    },
    subgroup = "raw-resource",
    order = "g[uranium-ore]",
    stack_size = 50
  },
  {
    type = "fluid",
    name = "ll-astroflux",
    default_temperature = 25,
    heat_capacity = "0.1KJ",
    base_color = {r=0, g=0, b=0},  -- TODO
    flow_color = {r=0.5, g=0.5, b=0.5},  -- TODO
    icon = "__LunarLandings__/graphics/fluid/neodym-solution.png",
    icon_size = 64, icon_mipmaps = 4,
    order = "a[fluid]-b[crude-oil]"
  },
  {
    type = "recipe",
    name = "ll-astrocrystal-processing",
    energy_required = 12,
    enabled = false,
    category = "crafting-with-fluid",  -- TODO centrifuge? get pink tint
    ingredients = {{"ll-astrocrystals", 4}},
    icon = "__LunarLandings__/graphics/item/raw-imersite/raw-imersite.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "l[exotic-mineral-processing]",
    results =
    {
      {
        type = "fluid",
        name = "ll-astroflux",
        amount = 10,
      },
      {
        name = "ll-right-polariton",
        probability = 0.0025,
        amount = 1
      },
      {
        name = "ll-left-polariton",
        probability = 0.0025,
        amount = 1
      },
      {
        name = "ll-up-polariton",
        probability = 0.0025,
        amount = 1
      },
      {
        name = "ll-down-polariton",
        probability = 0.0025,
        amount = 1
      },

    }
  },

})

data_util.allow_productivity("ll-astrocrystal-processing")