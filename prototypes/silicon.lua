data:extend{
  {
    type = "item-subgroup",
    name = "ll-raw-material-moon",
    group = "intermediate-products",
    order = "c-a"
  },
  {
    type = "item",
    name = "ll-silica",
    icon = "__LunarLandings__/graphics/silica.png",
    icon_size = 64,
    subgroup = "ll-raw-material-moon",
    order = "a[silica]",
    stack_size = 100
  },
  {
    type = "item",
    name = "ll-silicon",
    icon = "__LunarLandings__/graphics/silicon.png",
    icon_size = 64,
    subgroup = "ll-raw-material-moon",
    order = "b[silicon]",
    stack_size = 100
  },
  {
    type = "recipe",
    name = "ll-silicon",
    category = "ll-electric-smelting",
    enabled = false,
    energy_required = 8,
    ingredients = {{"coal", 1}, {"ll-silica", 2}},
    results = {{"ll-silicon", 5}}
  },
}

x_util.allow_productivity("ll-silicon")