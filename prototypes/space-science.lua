data:extend{
  {
    type = "tool",
    name = "ll-space-science-pack",
    localised_description = {"item-description.science-pack"},
    icon = "__LunarLandings__/graphics/icons/space-science-pack.png",
    icon_size = 64,
    subgroup = "science-pack",
    order = "g-a[space-science-pack]",
    stack_size = 200,
    weight = 1 * kg,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value"
  },
  {
    type = "recipe",
    name = "ll-space-science-pack",
    enabled = false,
    energy_required = 35,
    category = "advanced-crafting",
    ingredients =
    {
      {type = "item", name = "ll-data-card", amount = 5},
      {type="item", name="ll-low-grav-assembling-machine", amount=1},
      {type="item", name="ll-aluminium-plate", amount=60}
    },
    main_product = "ll-space-science-pack",
    results = {
      {type="item", name="ll-space-science-pack", amount=5},
      {type = "item", name = "ll-blank-data-card", amount = 5, probability = 0.9, ignored_by_productivity = 5},
      {type = "item", name = "ll-broken-data-card", amount = 5, probability = 0.1, ignored_by_productivity = 5},
    },
    allow_productivity = true,
  },
}

table.insert(data.raw.lab.lab.inputs, 7, "ll-space-science-pack")
