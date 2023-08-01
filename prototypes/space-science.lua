data:extend{
  {
    type = "tool",
    name = "ll-space-science-pack",
    localised_description = {"item-description.science-pack"},
    icon = "__LunarLandings__/graphics/icons/space-science-pack.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "science-pack",
    order = "g[space-science-pack",
    stack_size = 200,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value"
  },
  {
    type = "recipe",
    name = "ll-space-science-pack",
    enabled = false,
    energy_required = 14,
    ingredients =
    {
      {type = "item", name = "ll-data-card", amount = 1, catalyst_amount = 1},
      {"ll-low-grav-assembling-machine", 1}, -- TODO consider core extractor?
    },
    main_product = "ll-space-science-pack",
    results = {
      {"ll-space-science-pack", 1},
      {type = "item", name = "ll-blank-data-card", amount = 1, probability = 0.9, catalyst_amount = 1},  -- TODO check if this works properly
      {type = "item", name = "ll-broken-data-card", amount = 1, probability = 0.1, catalyst_amount = 1},
    },
  },
}

data_util.allow_productivity("ll-space-science-pack")