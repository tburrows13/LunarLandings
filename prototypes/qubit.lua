data:extend{
  {
    type = "item-subgroup",
    name = "ll-qubits",
    group = "intermediate-products",
    order = "g-b"
  },
  {
    type = "item",
    name = "ll-superposed-qubit",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-qubits",
    order = "a[transport-belt]-a[transport-belt]",
    stack_size = 1
  },
  {
    type = "item",
    name = "ll-right-qubit",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-right.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-qubits",
    order = "a[transport-belt]-a[transport-belt]",
    stack_size = 1
  },
  {
    type = "item",
    name = "ll-left-qubit",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-left.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-qubits",
    order = "a[transport-belt]-a[transport-belt]",
    stack_size = 1
  },
  {
    type = "item",
    name = "ll-up-qubit",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-up.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-qubits",
    order = "a[transport-belt]-a[transport-belt]",
    stack_size = 1
  },
  {
    type = "item",
    name = "ll-down-qubit",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-down.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-qubits",
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
      {"ll-right-qubit", 1},
      {"ll-left-qubit", 1},
    },
    results = {
      {type = "item", name = "ll-superposed-qubit", amount = 2, probability = 0.99},
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
      {"ll-up-qubit", 1},
      {"ll-down-qubit", 1},
    },
    results = {
      {type = "item", name = "ll-superposed-qubit", amount = 2, probability = 0.99},
    },
    show_amount_in_title = false,
    always_show_products = true,
  },
  {
    type = "recipe",
    name = "ll-polarisation-up",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-up.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-qubits",
    order = "b[polarisation]-a[up]",
    enabled = false,
    category = "centrifuging",
    energy_required = 10,
    ingredients = {
      {"ll-up-qubit", 1},
    },
    results = {
      {type = "item", name = "ll-left-qubit", amount = 1, probability = 0.5},
      {type = "item", name = "ll-right-qubit", amount = 1, probability = 0.5},
    },
  },
  {
    type = "recipe",
    name = "ll-polarisation-right",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-right.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-qubits",
    order = "b[polarisation]-b[right]",
    enabled = false,
    category = "centrifuging",
    energy_required = 10,
    ingredients = {
      {"ll-right-qubit", 1},
    },
    results = {
      {type = "item", name = "ll-up-qubit", amount = 1, probability = 0.5},
      {type = "item", name = "ll-down-qubit", amount = 1, probability = 0.5},
    },
  },
  {
    type = "recipe",
    name = "ll-polarisation-down",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-down.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-qubits",
    order = "b[polarisation]-c[down]",
    enabled = false,
    category = "centrifuging",
    energy_required = 10,
    ingredients = {
      {"ll-down-qubit", 1},
    },
    results = {
      {type = "item", name = "ll-left-qubit", amount = 1, probability = 0.5},
      {type = "item", name = "ll-right-qubit", amount = 1, probability = 0.5},
    },
  },
  {
    type = "recipe",
    name = "ll-polarisation-left",
    icon = "__LunarLandings__/graphics/item/matter-cube/matter-cube-left.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-qubits",
    order = "b[polarisation]-d[left]",
    enabled = false,
    category = "centrifuging",
    energy_required = 10,
    ingredients = {
      {"ll-left-qubit", 1},
    },
    results = {
      {type = "item", name = "ll-up-qubit", amount = 1, probability = 0.5},
      {type = "item", name = "ll-down-qubit", amount = 1, probability = 0.5},
    },
  },
}