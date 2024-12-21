data:extend{
  {
    type = "recipe",
    name = "ll-quantum-processor",
    category = "advanced-circuit-crafting",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="processing-unit", amount=1},
      {type="item", name="ll-alumina", amount=5},
      {type = "fluid", name = "ll-astroflux", amount = 5}
    },
    results = {{type="item", name="ll-quantum-processor", amount=1}},
    allow_productivity = true,
  },
  {
    type = "item",
    name = "ll-quantum-processor",
    icon = "__LunarLandings__/graphics/icons/quantum-processor.png",
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "g[processing-unit]-a[quantum]",
    stack_size = 100
  },
}
