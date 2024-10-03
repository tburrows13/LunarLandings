local rich_moon_rock = table.deepcopy(data.raw.resource["stone"])

rich_moon_rock.name = "ll-rich-moon-rock"
rich_moon_rock.minable.result = "ll-rich-moon-rock"

rich_moon_rock.icon = "__LunarLandings__/graphics/icons/rich-moon-rock.png"
rich_moon_rock.stages = {
  sheet =
  {
    filename = "__LunarLandings__/graphics/moon-rock/rich-moon-rock.png",
    priority = "extra-high",
    size = 128,
    frame_count = 8,
    variation_count = 8,
    scale = 0.5
  }
}

rich_moon_rock.map_color = {r=0.9, g=0.9, b=1}

rich_moon_rock.selection_priority = 49

rich_moon_rock.surface_conditions = {nauvis = false, luna = true}

data:extend{
  rich_moon_rock,
  {
    type = "item",
    name = "ll-rich-moon-rock",
    icon = "__LunarLandings__/graphics/icons/rich-moon-rock.png",
    icon_size = 64,
    pictures =
    {
      { size = 64, filename = "__LunarLandings__/graphics/icons/rich-moon-rock.png",   scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/rich-moon-rock-1.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/rich-moon-rock-2.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/rich-moon-rock-3.png", scale = 0.25, mipmap_count = 4 }
    },
    subgroup = "raw-resource",
    order = "h[moon]-b[rich-moon-rock]",
    stack_size = 50
  },
  {
    type = "recipe",
    name = "ll-rich-moon-rock-processing",
    category = "ll-arc-smelting",
    enabled = false,
    allow_decomposition = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="ll-rich-moon-rock", amount=20},
    },
    results=
    {
      {type="item", name="ll-aluminium-ore", amount = 5},
      {type="item", name="iron-ore", amount = 5},
      {type="item", name="ll-moon-rock", amount_min = 0, amount_max = 2},
    },
    icon = "__LunarLandings__/graphics/icons/aluminium-ore.png",
    icon_size = 64,
    subgroup = "ll-raw-material-moon",
    order = "b[rich-moon-rock]"
  },
}

--x_util.allow_productivity("ll-moon-rock-processing-with-oxygen-helium")
x_util.allow_productivity("ll-rich-moon-rock-processing")
