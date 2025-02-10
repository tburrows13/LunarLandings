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
    icon = "__LunarLandings__/graphics/icons/silica.png",
    icon_size = 64,
    subgroup = "ll-raw-material-moon",
    order = "a[silica]",
    stack_size = 100,
    weight = 1 * kg,
  },
  {
    type = "item",
    name = "ll-silicon",
    icon = "__LunarLandings__/graphics/icons/silicon.png",
    icon_size = 64,
    subgroup = "ll-raw-material-moon",
    order = "b[silicon]",
    stack_size = 100,
    weight = 1 * kg,
  },
  {
    type = "recipe",
    name = "ll-silicon",
    category = "ll-electric-smelting",
    enabled = false,
    energy_required = 8,
    ingredients = {{type="item", name="coal", amount=1}, {type="item", name="ll-silica", amount=2}},
    results = {{type="item", name="ll-silicon", amount=5}},
    allow_productivity = true,
  },
}
