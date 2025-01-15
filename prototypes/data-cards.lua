data:extend{
  {
    type = "item-subgroup",
    name = "ll-data-cards",
    group = "intermediate-products",
    order = "g-b"
  },
  {
    type = "item",
    name = "ll-blank-data-card",
    icon = "__space-exploration-graphics__/graphics/icons/data/empty.png",
    icon_size = 64,
    subgroup = "ll-data-cards",
    order = "a",
    stack_size = 50,
    weight = 2.5 * kg,
  },
  {
    type = "item",
    name = "ll-data-card",
    icon = "__space-exploration-graphics__/graphics/icons/data/significant.png",
    icon_size = 64,
    subgroup = "ll-data-cards",
    order = "b",
    stack_size = 50,
    weight = 2.5 * kg,
  },
  {
    type = "item",
    name = "ll-quantum-data-card",
    icon = "__space-exploration-graphics__/graphics/icons/data/entanglement.png",
    icon_size = 64,
    subgroup = "ll-data-cards",
    order = "c",
    stack_size = 50,
    weight = 2.5 * kg,
  },
  {
    type = "item",
    name = "ll-junk-data-card",
    icon = "__space-exploration-graphics__/graphics/icons/data/junk.png",
    icon_size = 64,
    subgroup = "ll-data-cards",
    order = "d",
    stack_size = 50,
    weight = 2.5 * kg,
  },
  {
    type = "item",
    name = "ll-broken-data-card",
    icon = "__space-exploration-graphics__/graphics/icons/data/broken.png",
    icon_size = 64,
    subgroup = "ll-data-cards",
    order = "e",
    stack_size = 50,
    weight = 2.5 * kg,
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
      {type="item", name="advanced-circuit", amount=5},
      {type="item", name="ll-silicon", amount=20},
      {type="item", name="stone-brick", amount=1}
    },
    results = {{type="item", name="ll-blank-data-card", amount=1}},
    allow_productivity = true,
  },
  {
    type = "recipe",
    name = "ll-data-card-reformatting",
    icons = {
      {
        icon = "__LunarLandings__/graphics/icons/background.png",
        scale = 0.5
      },
      {
        icon = "__space-exploration-graphics__/graphics/icons/data/junk.png",
        scale = 0.35,
        shift = {-5, -5},
      },
      {
        icon = "__space-exploration-graphics__/graphics/icons/data/empty.png",
        scale = 0.35,
        shift = {5, 5},
      },
      {
        icon = "__LunarLandings__/graphics/icons/arrow.png",
        scale = 0.45,
        shift = {2, 1},
      }
    },
    icon_size = 64,
    subgroup = "ll-data-cards",
    enabled = false,
    category = "advanced-crafting",
    ingredients = {
      {type="item", name="ll-junk-data-card", amount=1},
      {type="item", name="advanced-circuit", amount=1},
    },
    results = {
      {type = "item", name = "ll-blank-data-card", amount = 1, probability = 0.9},
      {type = "item", name = "ll-broken-data-card", amount = 1, probability = 0.1},
    },
  },
  {
    type = "recipe",
    name = "ll-broken-data-card-recycling",
    icons = {
      {
        icon = "__space-exploration-graphics__/graphics/icons/data/broken.png",
        icon_size = 64,
      },
      {
        icon = "__LunarLandings__/graphics/icons/recycle.png",
        icon_size = 64,
        scale = 0.3,
        shift = {-8, 8},
      }
    },
    subgroup = "ll-data-cards",
    enabled = false,
    allow_decomposition = false,
    category = "advanced-crafting",
    ingredients = {
      {type="item", name="ll-broken-data-card", amount=1},
      {type="item", name="stone", amount=1},
    },
    results = {
      {type="item", name="advanced-circuit", amount=2},
      {type="item", name="ll-silicon", amount=2},
    },
  },
  {
    type = "recipe",
    name = "ll-data-card",
    enabled = false,
    category = "ll-telescope-data",
    always_show_made_in = true,
    energy_required = 5,
    ingredients = {
      {type="item", name="ll-blank-data-card", amount=1},
      {type="item", name="processing-unit", amount=1},
      {type = "fluid", name = "ll-oxygen", amount = 10}
    },
    results = {
      {type = "item", name = "ll-data-card", amount = 1, probability = 0.9},
      {type = "item", name = "ll-junk-data-card", amount = 1, probability = 0.1},
    },
    main_product = "ll-data-card"
  },
  {
    type = "recipe",
    name = "ll-quantum-data-card",
    enabled = false,
    category = "ll-telescope-data",
    always_show_made_in = true,
    energy_required = 10,
    ingredients = {
      {type="item", name="ll-data-card", amount=1},
      {type="item", name="ll-quantum-processor", amount=1},
      {type="item", name="ll-superposed-polariton", amount=1},
      {type = "fluid", name = "ll-oxygen", amount = 10}
    },
    results = {
      {type = "item", name = "ll-quantum-data-card", amount = 1, probability = 0.7},
      {type = "item", name = "ll-junk-data-card", amount = 1, probability = 0.3},
      {type = "item", name = "ll-up-polariton", amount = 1, probability = 0.10},
      {type = "item", name = "ll-right-polariton", amount = 1, probability = 0.40},
      {type = "item", name = "ll-down-polariton", amount = 1, probability = 0.35},
      {type = "item", name = "ll-left-polariton", amount = 1, probability = 0.15},
    },
    main_product = "ll-quantum-data-card"
  },
}
