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
    name = "ll-packed-rocket-parts",
    group = "intermediate-products",
    order = "g-a"
  },
  {
    type = "item",
    name = "ll-packed-rocket-control-unit",
    localised_name = {"item-name.ll-packed-rocket-part", {"item-name.rocket-control-unit"}},
    localised_description = {"item-description.ll-packed-rocket-part"},
    icons = stacked_icons("__base__/graphics/icons/rocket-control-unit.png"),
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "ll-packed-rocket-parts",
    order = "n[rocket-control-unit]",
    stack_size = 1
  },
  {
    type = "recipe",
    name = "ll-pack-rocket-control-unit",
    localised_name = {"recipe-name.ll-pack-rocket-part", {"item-name.rocket-control-unit"}},
    icons = stacked_icons("__base__/graphics/icons/rocket-control-unit.png"),
    icon_size = 64, icon_mipmaps = 4,
    category = "crafting",
    subgroup = "ll-packed-rocket-parts",
    order = "n-a",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"rocket-control-unit", 10},
    },
    results = {{type="item", name="ll-packed-rocket-control-unit", amount=1}},
    main_product = "",
  },
  {
    type = "recipe",
    name = "ll-unpack-rocket-control-unit",
    localised_name = {"recipe-name.ll-unpack-rocket-part", {"item-name.rocket-control-unit"}},
    icons = stacked_icons("__base__/graphics/icons/rocket-control-unit.png"),
    icon_size = 64, icon_mipmaps = 4,
    category = "crafting",
    subgroup = "ll-packed-rocket-parts",
    order = "n-b",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"ll-packed-rocket-control-unit", 1},
    },
    results = {{type="item", name="rocket-control-unit", amount=10}},
    main_product = "",
  },
  {
    type = "item",
    name = "ll-packed-low-density-structure",
    localised_description = {"item-description.ll-packed-rocket-part"},
    icons = stacked_icons("__base__/graphics/icons/low-density-structure.png"),
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "ll-packed-rocket-parts",
    order = "o[low-density-structure]",
    stack_size = 1
  },
  {
    type = "recipe",
    name = "ll-pack-low-density-structure",
    icons = stacked_icons("__base__/graphics/icons/low-density-structure.png"),
    icon_size = 64, icon_mipmaps = 4,
    category = "crafting",
    subgroup = "ll-packed-rocket-parts",
    order = "o-a",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"low-density-structure", 10},
    },
    results = {{type="item", name="ll-packed-low-density-structure", amount=1}},
    main_product = "",
  },
  {
    type = "recipe",
    name = "ll-unpack-low-density-structure",
    icons = stacked_icons("__base__/graphics/icons/low-density-structure.png"),
    icon_size = 64, icon_mipmaps = 4,
    category = "crafting",
    subgroup = "ll-packed-rocket-parts",
    order = "o-b",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"ll-packed-rocket-control-unit", 1},
    },
    results = {{type="item", name="low-density-structure", amount=10}},
    main_product = "",
  },
  {
    type = "item",
    name = "ll-packed-heat-shielding",
    localised_description = {"item-description.ll-packed-rocket-part"},
    icons = stacked_icons("__space-exploration-graphics__/graphics/icons/heat-shielding.png"),
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "ll-packed-rocket-parts",
    order = "q[low-density-structure]",
    stack_size = 1
  },
  {
    type = "recipe",
    name = "ll-pack-heat-shielding",
    icons = stacked_icons("__space-exploration-graphics__/graphics/icons/heat-shielding.png"),
    icon_size = 64, icon_mipmaps = 1,
    category = "crafting",
    subgroup = "ll-packed-rocket-parts",
    order = "q-a",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"ll-heat-shielding", 10},
    },
    results = {{type="item", name="ll-packed-heat-shielding", amount=1}},
    main_product = "",
  },
  {
    type = "recipe",
    name = "ll-unpack-heat-shielding",
    icons = stacked_icons("__space-exploration-graphics__/graphics/icons/heat-shielding.png"),
    icon_size = 64, icon_mipmaps = 1,
    category = "crafting",
    subgroup = "ll-packed-rocket-parts",
    order = "q-b",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {"ll-packed-heat-shielding", 1},
    },
    results = {{type="item", name="ll-heat-shielding", amount=10}},
    main_product = "",
  },
}