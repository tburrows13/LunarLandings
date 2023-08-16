data:extend{
  {
    type = "item",
    name = "ll-aluminium-ore",
    icon = "__LunarLandings__/graphics/icons/aluminium-ore.png",
    icon_size = 64,
    icon_mipmaps = 4,
    pictures =
    {
      { size = 64, filename = "__LunarLandings__/graphics/icons/aluminium-ore.png",   scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/aluminium-ore-2.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/aluminium-ore-3.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/aluminium-ore-4.png", scale = 0.25, mipmap_count = 4 }
    },
    subgroup = "raw-resource",
    order = "h[moon]-c[aluminium-ore]",
    stack_size = 50
  },
  {
    type = "item",
    name = "ll-alumina",
    icon = "__LunarLandings__/graphics/icons/alumina.png",
    icon_size = 128,
    icon_mipmaps = 1,
    pictures =
    {
      { size = 128, filename = "__LunarLandings__/graphics/icons/alumina.png",   scale = 0.125, mipmap_count = 1 },
      { size = 128, filename = "__LunarLandings__/graphics/icons/alumina-1.png", scale = 0.125, mipmap_count = 1 },
      { size = 128, filename = "__LunarLandings__/graphics/icons/alumina-2.png", scale = 0.125, mipmap_count = 1 },
      { size = 128, filename = "__LunarLandings__/graphics/icons/alumina-3.png", scale = 0.125, mipmap_count = 1 }
    },
    subgroup = "ll-raw-material-moon",
    order = "c[alumina]",
    stack_size = 50
  },
  {
    type = "item",
    name = "ll-aluminium-plate",
    icon = "__LunarLandings__/graphics/icons/aluminium-plate.png",
    icon_size = 128,
    icon_mipmaps = 1,
    subgroup = "ll-raw-material-moon",
    order = "d[aluminium-plate]",
    stack_size = 100
  },
  {
    type = "fluid",
    name = "ll-red-mud",
    default_temperature = 25,
    --heat_capacity = "0.1KJ",
    base_color = {r=0.15, g=0.32, b=0.03},  -- TODO set
    flow_color = {r=0.43, g=0.75, b=0.31},
    icon = "__LunarLandings__/graphics/icons/red-mud.png",
    icon_size = 64, icon_mipmaps = 4,
    order = "e[lubricant]"
  },
  -- Heat outputs will be added to recipes in heat-recipes.lua (data-final-fixes)
  {
    type = "recipe",
    name = "ll-alumina",
    category = "ll-arc-smelting",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="ll-aluminium-ore", amount=10},
      {type="fluid", name="sulfuric-acid", amount=2},
    },
    results =
    {
      {type="item", name="ll-alumina", amount=5},
      {type="fluid", name="ll-red-mud", amount=4, fluidbox_index = 1},
    },
    main_product = "ll-alumina",
    --[[icon = "__LunarLandings__/graphics/icons/moon-rock.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "a[oil-processing]-c[advanced-oil-processing]"]]
  },
  {
    type = "recipe",
    name = "ll-aluminium-plate",
    category = "ll-arc-smelting",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="ll-alumina", amount=4},
      {type="item", name="coal", amount=1},
    },
    results =
    {
      {type = "item", name = "ll-aluminium-plate", amount = 6},
    },
    main_product = "ll-aluminium-plate",
    --[[icon = "__LunarLandings__/graphics/icons/moon-rock.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "a[oil-processing]-c[advanced-oil-processing]"]]
  },
  {
    type = "recipe",
    name = "ll-red-mud-recovery",  -- TODO set fluid tint
    category = "chemistry",
    enabled = false,
    allow_decomposition = false,
    energy_required = 20,
    ingredients =
    {
      {type="fluid", name="ll-red-mud", amount=10},
    },
    results=
    {
      {type="item", name="stone-brick", amount_min=0, amount_max = 4},
      {type="item", name="iron-ore", amount_min=0, amount_max = 4},
    },
    icon = "__LunarLandings__/graphics/icons/red-mud.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "ll-raw-material-moon",
    order = "h[red-mud]"
  },
  {
    type = "recipe",
    name = "ll-low-density-structure-aluminium",
    localised_name = {"recipe-name.ll-low-density-structure-aluminium"},
    category = "crafting",
    energy_required = 20,
    enabled = false,
    ingredients =
    {
      {"steel-plate", 2},
      {"copper-plate", 5},
      {"ll-aluminium-plate", 5},
      {"plastic-bar", 5}
    },
    result = "low-density-structure",
    order = "o[low-density-structure]-a"
  },
}

data_util.allow_productivity("ll-alumina")
data_util.allow_productivity("ll-aluminium-plate")
