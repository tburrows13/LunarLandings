data:extend{
  {
    type = "module",
    name = "ll-quantum-module",
    localised_description = {"item-description.productivity-module"},
    icon = "__LunarLandings__/graphics/icons/quantum-module.png",
    icon_size = 64,
    subgroup = "module",
    category = "productivity",
    tier = 4,
    order = "c[productivity]-d[quantum-module]",
    stack_size = 50,
    effect =
    {
      productivity = {bonus = 0.15},
      consumption = {bonus = 1},
      --pollution = {bonus = 0.1},
      --speed = {bonus = -0.15}
    },
  },
  {
    type = "recipe",
    name = "ll-quantum-module",
    enabled = false,
    ingredients =
    {
      {type="item", name="speed-module-3", amount=1},
      {type="item", name="effectivity-module-3", amount=1},
      {type="item", name="productivity-module-3", amount=1},
      {type="item", name="ll-quantum-processor", amount=5},
      {type="item", name="ll-superposed-polariton", amount=1},
    },
    results = {
      {type = "item", name = "ll-quantum-module", amount = 1},
      {type = "item", name = "ll-up-polariton", amount = 1, probability = 0.15},
      {type = "item", name = "ll-right-polariton", amount = 1, probability = 0.05},
      {type = "item", name = "ll-down-polariton", amount = 1, probability = 0.30},
      {type = "item", name = "ll-left-polariton", amount = 1, probability = 0.50},
    },
    energy_required = 60,
    results = {{type="item", name="productivity-module-3", amount=1}},
    main_product = "ll-quantum-module",
  },

}