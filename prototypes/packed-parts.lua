local function stacked_icons(filename)
  return {
    {
      icon = filename,
      --scale = 0.3,
      shift = {0, 3}
    },
    {
      icon = filename,
      --scale = 0.3,
    },
    {
      icon = filename,
      --scale = 0.3,
      shift = {0, -3}
    },
  }
end

data:extend{
  {
    type = "item-subgroup",
    name = "ll-packed-rocket-ingredients",
    group = "intermediate-products",
    order = "g-a"
  },
  {
    type = "item",
    name = "ll-packed-rocket-control-unit",
    localised_name = {"item-name.ll-packed-rocket-ingredient", {"item-name.rocket-control-unit"}},
    localised_description = {"item-description.ll-packed-rocket-ingredient"},
    icons = stacked_icons("__base__/graphics/icons/rocket-control-unit.png"),
    icon_size = 64,
    subgroup = "ll-packed-rocket-ingredients",
    order = "n[rocket-control-unit]",
    stack_size = 4
  },
  {
    type = "recipe",
    name = "ll-pack-rocket-control-unit",
    localised_name = {"recipe-name.ll-pack-rocket-ingredient", {"item-name.rocket-control-unit"}},
    icons = stacked_icons("__base__/graphics/icons/rocket-control-unit.png"),
    icon_size = 64,
    category = "crafting",
    subgroup = "ll-packed-rocket-ingredients",
    order = "n-a",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"rocket-control-unit", 5},
    },
    results = {{type="item", name="ll-packed-rocket-control-unit", amount=1}},
    main_product = "",
  },
  {
    type = "recipe",
    name = "ll-unpack-rocket-control-unit",
    localised_name = {"recipe-name.ll-unpack-rocket-ingredient", {"item-name.rocket-control-unit"}},
    icons = stacked_icons("__base__/graphics/icons/rocket-control-unit.png"),
    icon_size = 64,
    category = "crafting",
    subgroup = "ll-packed-rocket-ingredients",
    order = "n-b",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"ll-packed-rocket-control-unit", 1},
    },
    results = {{type="item", name="rocket-control-unit", amount=5}},
    main_product = "",
  },
  {
    type = "item",
    name = "ll-packed-low-density-structure",
    localised_name = {"item-name.ll-packed-rocket-ingredient", {"item-name.low-density-structure"}},
    localised_description = {"item-description.ll-packed-rocket-ingredient"},
    icons = stacked_icons("__base__/graphics/icons/low-density-structure.png"),
    icon_size = 64,
    subgroup = "ll-packed-rocket-ingredients",
    order = "o[low-density-structure]",
    stack_size = 4
  },
  {
    type = "recipe",
    name = "ll-pack-low-density-structure",
    localised_name = {"recipe-name.ll-pack-rocket-ingredient", {"item-name.low-density-structure"}},
    icons = stacked_icons("__base__/graphics/icons/low-density-structure.png"),
    icon_size = 64,
    category = "crafting",
    subgroup = "ll-packed-rocket-ingredients",
    order = "o-a",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"low-density-structure", 5},
    },
    results = {{type="item", name="ll-packed-low-density-structure", amount=1}},
    main_product = "",
  },
  {
    type = "recipe",
    name = "ll-unpack-low-density-structure",
    localised_name = {"recipe-name.ll-unpack-rocket-ingredient", {"item-name.low-density-structure"}},
    icons = stacked_icons("__base__/graphics/icons/low-density-structure.png"),
    icon_size = 64,
    category = "crafting",
    subgroup = "ll-packed-rocket-ingredients",
    order = "o-b",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"ll-packed-low-density-structure", 1},
    },
    results = {{type="item", name="low-density-structure", amount=5}},
    main_product = "",
  },
  {
    type = "item",
    name = "ll-packed-heat-shielding",
    localised_name = {"item-name.ll-packed-rocket-ingredient", {"item-name.ll-heat-shielding"}},
    localised_description = {"item-description.ll-packed-rocket-ingredient"},
    icons = stacked_icons("__space-exploration-graphics__/graphics/icons/heat-shielding.png"),
    icon_size = 64,
    subgroup = "ll-packed-rocket-ingredients",
    order = "q[low-density-structure]",
    stack_size = 4
  },
  {
    type = "recipe",
    name = "ll-pack-heat-shielding",
    localised_name = {"recipe-name.ll-pack-rocket-ingredient", {"item-name.ll-heat-shielding"}},
    icons = stacked_icons("__space-exploration-graphics__/graphics/icons/heat-shielding.png"),
    icon_size = 64,
    category = "crafting",
    subgroup = "ll-packed-rocket-ingredients",
    order = "q-a",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"ll-heat-shielding", 5},
    },
    results = {{type="item", name="ll-packed-heat-shielding", amount=1}},
    main_product = "",
  },
  {
    type = "recipe",
    name = "ll-unpack-heat-shielding",
    localised_name = {"recipe-name.ll-unpack-rocket-ingredient", {"item-name.ll-heat-shielding"}},
    icons = stacked_icons("__space-exploration-graphics__/graphics/icons/heat-shielding.png"),
    icon_size = 64,
    category = "crafting",
    subgroup = "ll-packed-rocket-ingredients",
    order = "q-b",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"ll-packed-heat-shielding", 1},
    },
    results = {{type="item", name="ll-heat-shielding", amount=5}},
    main_product = "",
  },
}