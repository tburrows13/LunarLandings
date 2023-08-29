data:extend{
  {
    type = "item-subgroup",
    name = "ll-polaritons",
    group = "intermediate-products",
    order = "g-b"
  },
  {
    type = "item",
    name = "ll-superposed-polariton",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-polaritons",
    order = "a[transport-belt]-a[transport-belt]",
    stack_size = 1
  },
  {
    type = "item",
    name = "ll-right-polariton",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-right.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-polaritons",
    order = "a[transport-belt]-a[transport-belt]",
    stack_size = 1
  },
  {
    type = "item",
    name = "ll-left-polariton",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-left.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-polaritons",
    order = "a[transport-belt]-a[transport-belt]",
    stack_size = 1
  },
  {
    type = "item",
    name = "ll-up-polariton",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-up.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-polaritons",
    order = "a[transport-belt]-a[transport-belt]",
    stack_size = 1
  },
  {
    type = "item",
    name = "ll-down-polariton",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-down.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-polaritons",
    order = "a[transport-belt]-a[transport-belt]",
    stack_size = 1
  },
  {
    type = "recipe",
    name = "ll-superposition-right-left",
    enabled = false,
    category = "centrifuging",
    energy_required = 10,
    ingredients = {
      {"ll-right-polariton", 1},
      {"ll-left-polariton", 1},
    },
    results = {
      {type = "item", name = "ll-superposed-polariton", amount = 2, probability = 0.99},
    },
    show_amount_in_title = false,
    always_show_products = true,
  },
  {
    type = "recipe",
    name = "ll-superposition-up-down",
    enabled = false,
    category = "centrifuging",
    energy_required = 10,
    ingredients = {
      {"ll-up-polariton", 1},
      {"ll-down-polariton", 1},
    },
    results = {
      {type = "item", name = "ll-superposed-polariton", amount = 2, probability = 0.99},
    },
    show_amount_in_title = false,
    always_show_products = true,
  },
  {
    type = "recipe",
    name = "ll-polarisation-up",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-up.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-polaritons",
    order = "b[polarisation]-a[up]",
    enabled = false,
    category = "centrifuging",
    energy_required = 10,
    ingredients = {
      {"ll-up-polariton", 1},
    },
    results = {
      {type = "item", name = "ll-left-polariton", amount = 1, probability = 0.5},
      {type = "item", name = "ll-right-polariton", amount = 1, probability = 0.5},
    },
  },
  {
    type = "recipe",
    name = "ll-polarisation-right",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-right.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-polaritons",
    order = "b[polarisation]-b[right]",
    enabled = false,
    category = "centrifuging",
    energy_required = 10,
    ingredients = {
      {"ll-right-polariton", 1},
    },
    results = {
      {type = "item", name = "ll-up-polariton", amount = 1, probability = 0.5},
      {type = "item", name = "ll-down-polariton", amount = 1, probability = 0.5},
    },
  },
  {
    type = "recipe",
    name = "ll-polarisation-down",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-down.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-polaritons",
    order = "b[polarisation]-c[down]",
    enabled = false,
    category = "centrifuging",
    energy_required = 10,
    ingredients = {
      {"ll-down-polariton", 1},
    },
    results = {
      {type = "item", name = "ll-left-polariton", amount = 1, probability = 0.5},
      {type = "item", name = "ll-right-polariton", amount = 1, probability = 0.5},
    },
  },
  {
    type = "recipe",
    name = "ll-polarisation-left",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-left.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-polaritons",
    order = "b[polarisation]-d[left]",
    enabled = false,
    category = "centrifuging",
    energy_required = 10,
    ingredients = {
      {"ll-left-polariton", 1},
    },
    results = {
      {type = "item", name = "ll-up-polariton", amount = 1, probability = 0.5},
      {type = "item", name = "ll-down-polariton", amount = 1, probability = 0.5},
    },
  },
}