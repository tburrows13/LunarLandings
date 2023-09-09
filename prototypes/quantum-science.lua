data:extend{
  {
    type = "tool",
    name = "ll-quantum-science-pack",
    localised_description = {"item-description.quantum-pack"},
    icon = "__LunarLandings__/graphics/icons/quantum-science-pack.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "science-pack",
    order = "h[quantum-science-pack]",
    stack_size = 200,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value"
  },
  {
    type = "recipe",
    name = "ll-quantum-science-pack",
    enabled = false,
    energy_required = 14,
    ingredients =
    {
      {type = "item", name = "ll-quantum-data-card", amount = 1, catalyst_amount = 1},
      {type = "item", name = "ll-quantum-resonator", amount = 1},
      --{"ll-low-grav-assembling-machine", 1}, -- TODO
      --{"ll-aluminium-plate", 5}  -- TODO
    },
    main_product = "ll-quantum-science-pack",
    results = {
      {"ll-quantum-science-pack", 6},
      {type = "item", name = "ll-blank-data-card", amount = 1, probability = 0.9, catalyst_amount = 1},  -- TODO check if this works properly
      {type = "item", name = "ll-broken-data-card", amount = 1, probability = 0.1, catalyst_amount = 1},
    },
  },
}

table.insert(data.raw.lab.lab.inputs, 8, "ll-quantum-science-pack")
data_util.allow_productivity("ll-quantum-science-pack")