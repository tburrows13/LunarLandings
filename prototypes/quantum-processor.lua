data:extend{
  {
    type = "recipe",
    name = "ll-quantum-processor",
    category = "advanced-circuit-crafting",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {"processing-unit", 1},
      {"ll-alumina", 5},
      {"ll-astrocrystals", 5}
    },
    result = "ll-quantum-processor"
  },
  {
    type = "item",
    name = "ll-quantum-processor",
    icon = "__LunarLandings__/graphics/icons/quantum-processor.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "intermediate-product",
    order = "g[processing-unit]-a[quantum]",
    stack_size = 100
  },
}

data_util.allow_productivity("ll-quantum-processor")