local moon_rock = table.deepcopy(data.raw.resource["stone"])

moon_rock.name = "ll-moon-rock"
moon_rock.minable.result = "ll-moon-rock"

moon_rock.icon = "__LunarLandings__/graphics/icons/moon-rock.png"
moon_rock.stages = {
  sheet =
  {
    filename = "__LunarLandings__/graphics/moon-rock/moon-rock.png",
    priority = "extra-high",
    size = 128,
    frame_count = 8,
    variation_count = 8,
    scale = 0.5
  }
}


moon_rock.map_color = {r=0.8, g=0.8, b=0.8}

moon_rock.selection_priority = 49

moon_rock.surface_conditions = {nauvis = false, luna = true}

data:extend{
  moon_rock,
  {
    type = "recipe-category",
    name = "ll-electric-smelting"
  },
  {
    type = "item",
    name = "ll-moon-rock",
    icon = "__LunarLandings__/graphics/icons/moon-rock.png",
    icon_size = 64,
    pictures =
    {
      { size = 64, filename = "__LunarLandings__/graphics/icons/moon-rock.png",   scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/moon-rock-1.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/moon-rock-2.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/moon-rock-3.png", scale = 0.25, mipmap_count = 4 }
    },
    subgroup = "raw-resource",
    order = "h[moon]-a[moon-rock]",
    stack_size = 50
  },
  --[[{
    type = "recipe",
    name = "ll-moon-rock-processing-with-oxygen-helium",
    category = "ll-electric-smelting",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type="item", name="ll-moon-rock", amount=10},
    },
    results=
    {
      {type="item", name="ll-silica", amount=5},
      {type="item", name="stone", amount=5},
      {type="fluid", name="ll-oxygen", amount=50, fluidbox_index = 1},
      {type="fluid", name="ll-helium-3", amount=50, fluidbox_index = 3},
    },
    icon = "__LunarLandings__/graphics/icons/moon-rock.png",
    icon_size = 64,
    subgroup = "raw-material",
    order = "a[oil-processing]-b[advanced-oil-processing]"
  },]]
  --[[{
    type = "recipe",
    name = "ll-moon-rock-processing-with-helium",
    icons = {
      {
        icon = "__LunarLandings__/graphics/icons/moon-rock.png",
        icon_size = 64,
      },
      {
        icon = "__LunarLandings__/graphics/fluids/helium-3.png",
        icon_size = 64,
        scale = 0.25,
        shift = {-3, 3},
      },
    },
    category = "ll-electric-smelting",
    enabled = false,
    allow_decomposition = false,
    energy_required = 5,
    ingredients =
    {
      {type="item", name="ll-moon-rock", amount=10},
    },
    results=
    {
      {type="item", name="ll-silica", amount=5},
      {type="item", name="stone", amount=5},
      {type="fluid", name="ll-helium-3", amount=5, fluidbox_index = 1},
    },
    icon = "__LunarLandings__/graphics/icons/moon-rock.png",
    icon_size = 64,
    subgroup = "ll-raw-material-moon",
    order = "a[moon-rock]-c"
  },]]
  {
    type = "recipe",
    name = "ll-moon-rock-processing-with-oxygen",
    icons = {
      {
        icon = "__LunarLandings__/graphics/icons/moon-rock.png",
        icon_size = 64,
      },
      {
        icon = "__LunarLandings__/graphics/fluid/oxygen.png",
        icon_size = 64,
        scale = 0.25,
        shift = {-3, 3},
      },
    },
    category = "ll-electric-smelting",
    enabled = false,
    allow_decomposition = false,
    energy_required = 5,
    ingredients =
    {
      {type="item", name="ll-moon-rock", amount=10},
    },
    results=
    {
      {type="item", name="ll-silica", amount=5},
      {type="item", name="stone", amount=5},
      {type="fluid", name="ll-oxygen", amount=100, fluidbox_index = 1},
    },
    icon = "__LunarLandings__/graphics/icons/moon-rock.png",
    icon_size = 64,
    subgroup = "ll-raw-material-moon",
    order = "a[moon-rock]-b"
  },

  {
    type = "recipe",
    name = "ll-moon-rock-processing",
    category = "ll-electric-smelting",
    enabled = false,
    allow_decomposition = false,
    energy_required = 5,
    ingredients =
    {
      {type="item", name="ll-moon-rock", amount=10},
    },
    results=
    {
      {type="item", name="ll-silica", amount=5},
      {type="item", name="stone", amount=5},
    },
    icon = "__LunarLandings__/graphics/icons/moon-rock.png",
    icon_size = 64,
    subgroup = "ll-raw-material-moon",
    order = "a[moon-rock]-a"
  },
}

--x_util.allow_productivity("ll-moon-rock-processing-with-oxygen-helium")
x_util.allow_productivity("ll-moon-rock-processing-with-oxygen")
--x_util.allow_productivity("ll-moon-rock-processing-with-helium")
x_util.allow_productivity("ll-moon-rock-processing")
