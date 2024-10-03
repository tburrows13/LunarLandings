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
      {type = "item", name = "ll-data-card", amount = 5, catalyst_amount = 5},
      {"ll-low-grav-assembling-machine", 1},
      {"ll-aluminium-plate", 60}
    },
    main_product = "ll-space-science-pack",
    results = {
      {"ll-space-science-pack", 5},
      {type = "item", name = "ll-blank-data-card", amount = 5, probability = 0.9, catalyst_amount = 5},
      {type = "item", name = "ll-broken-data-card", amount = 5, probability = 0.1, catalyst_amount = 5},
    },
  },
}

table.insert(data.raw.lab.lab.inputs, 7, "ll-space-science-pack")
x_util.allow_productivity("ll-space-science-pack")