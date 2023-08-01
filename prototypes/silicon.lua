data:extend{
  {
    type = "item",
    name = "ll-silica",
    icon = "__LunarLandings__/graphics/silica.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "b[iron-plate]",
    stack_size = 100
  },
  {
    type = "item",
    name = "ll-silicon",
    icon = "__LunarLandings__/graphics/silicon.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "b[iron-plate]",
    stack_size = 100
  },
  {
    type = "recipe",
    name = "ll-silicon",
    category = "smelting",
    enabled = false,
    energy_required = 16,
    ingredients = {{"coal", 1}, {"ll-silica", 5}},
    results = {{"ll-silicon", 5}}
  },
}

data_util.allow_productivity("ll-silicon")