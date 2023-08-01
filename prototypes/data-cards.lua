data:extend{
  {
    type = "item-subgroup",
    name = "ll-data-cards",
    group = "intermediate-products",
    order = "g-a"
  },
  {
    type = "item",
    name = "ll-blank-data-card",
    icon = "__space-exploration-graphics__/graphics/icons/data/empty.png",
    icon_size = 64,
    subgroup = "ll-data-cards",
    order = "a",
    stack_size = 50
  },
  {
    type = "item",
    name = "ll-data-card",
    icon = "__space-exploration-graphics__/graphics/icons/data/significant.png",
    icon_size = 64,
    subgroup = "ll-data-cards",
    order = "b",
    stack_size = 50
  },
  {
    type = "item",
    name = "ll-junk-data-card",
    icon = "__space-exploration-graphics__/graphics/icons/data/junk.png",
    icon_size = 64,
    subgroup = "ll-data-cards",
    order = "c",
    stack_size = 50
  },
  {
    type = "item",
    name = "ll-broken-data-card",
    icon = "__space-exploration-graphics__/graphics/icons/data/broken.png",
    icon_size = 64,
    subgroup = "ll-data-cards",
    order = "d",
    stack_size = 50
  },
  {
    type = "recipe-category",
    name = "ll-telescope-data"
  },
  {
    type = "recipe",
    name = "ll-blank-data-card",
    enabled = false,
    category = "advanced-circuit-crafting",
    energy_required = 10,
    ingredients = {
      {"advanced-circuit", 5},
      {"ll-silicon", 5},
    },
    result = "ll-blank-data-card",
  },
  {
    type = "recipe",
    name = "ll-data-card-reformatting",
    enabled = false,
    category = "advanced-circuit-crafting",
    ingredients = {
      {"ll-junk-data-card", 1},
      {"advanced-circuit", 1},
    },
    results = {
      {type = "item", name = "ll-blank-data-card", amount = 1, probability = 0.9},
      {type = "item", name = "ll-broken-data-card", amount = 1, probability = 0.1},
    },
    main_product = "ll-blank-data-card",  -- TODO
  },
  {
    type = "recipe",
    name = "ll-broken-data-card-recycling",
    icon = "__space-exploration-graphics__/graphics/icons/data/broken.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-data-cards",
    enabled = false,
    category = "advanced-crafting",
    ingredients = {
      {"ll-broken-data-card", 1},
      {"stone", 1},
    },
    results = {
      {"advanced-circuit", 2},
      {"ll-silicon", 2},
    },
  },
  {
    type = "recipe",
    name = "ll-data-card",
    enabled = false,
    category = "ll-telescope-data",
    always_show_made_in = true,
    energy_required = 10,
    ingredients = {
      {"ll-blank-data-card", 1},
      {"processing-unit", 1},
      {type = "fluid", name = "ll-oxygen", amount = 10}
    },
    results = {
      {type = "item", name = "ll-data-card", amount = 1, probability = 0.9},
      {type = "item", name = "ll-junk-data-card", amount = 1, probability = 0.1},
    },
    main_product = "ll-data-card"
  },

}

data_util.allow_productivity("ll-blank-data-card")