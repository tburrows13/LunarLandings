data:extend{
  {
    type = "tool",
    name = "ll-quantum-science-pack",
    localised_description = {"item-description.science-pack"},
    icon = "__LunarLandings__/graphics/icons/quantum-science-pack.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "science-pack",
    order = "g-b[quantum-science-pack]",
    stack_size = 200,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value"
  },
  {
    type = "recipe",
    name = "ll-quantum-science-pack",
    enabled = false,
    energy_required = 50,
    ingredients =
    {
      {type = "item", name = "ll-quantum-data-card", amount = 5, catalyst_amount = 1},
      {type = "item", name = "ll-quantum-resonator", amount = 1},
      {type = "item", name = "uranium-235", amount = 1},
    },
    main_product = "ll-quantum-science-pack",
    results = {
      {"ll-quantum-science-pack", 5},
      {type = "item", name = "ll-blank-data-card", amount = 5, probability = 0.9, catalyst_amount = 1},
      {type = "item", name = "ll-broken-data-card", amount = 5, probability = 0.1, catalyst_amount = 1},
    },
  },
}

table.insert(data.raw.lab.lab.inputs, 8, "ll-quantum-science-pack")
x_util.allow_productivity("ll-quantum-science-pack")