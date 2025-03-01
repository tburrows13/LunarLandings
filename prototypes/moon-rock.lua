require("__base__/prototypes/factoriopedia-util");

local moon_rock = table.deepcopy(data.raw.resource["stone"])

moon_rock.name = "ll-moon-rock"
moon_rock.minable.result = "ll-moon-rock"
moon_rock.order = "a-c-a"

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
moon_rock.factoriopedia_simulation =  { init = make_resource("ll-moon-rock") }

moon_rock.map_color = {r=0.8, g=0.8, b=0.8}

moon_rock.selection_priority = 49

--moon_rock.surface_conditions = {nauvis = false, luna = true}

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
      { size = 64, filename = "__LunarLandings__/graphics/icons/moon-rock.png",   scale = 0.5 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/moon-rock-1.png", scale = 0.5 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/moon-rock-2.png", scale = 0.5 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/moon-rock-3.png", scale = 0.5 }
    },
    subgroup = "raw-resource",
    order = "h[moon]-a[moon-rock]",
    stack_size = 50,
    weight = 2 * kg
  },
  {
    type = "recipe",
    name = "ll-moon-rock-processing",
    icon = "__LunarLandings__/graphics/icons/moon-rock-processing.png",
    icon_size = 64,
    category = "ll-electric-smelting",
    enabled = false,
    allow_decomposition = false,
    energy_required = 5,
    ingredients =
    {
      {type="item", name="ll-moon-rock", amount=10},
    },
    results =
    {
      {type="item", name="ll-silica", amount=5},
      {type="item", name="stone", amount=5},
      {type="fluid", name="ll-oxygen", amount=2, fluidbox_index = 1},
    },
    allow_productivity = true,
    subgroup = "ll-raw-material-moon",
    order = "a[moon-rock]-b"
  },
  {
    type = "recipe",
    name = "ll-oxygen-extraction",
    icon = "__LunarLandings__/graphics/fluid/oxygen.png",
    icon_size = 64,
    category = "ll-electric-smelting",
    enabled = false,
    allow_decomposition = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="ll-moon-rock", amount=10},
      {type="fluid", name="water", amount=1, fluidbox_index = 1},
    },
    results=
    {
      {type="item", name="ll-moon-rock", amount_min=6, amount_max=9},
      {type="fluid", name="ll-oxygen", amount=40, fluidbox_index = 1},
    },
    allow_productivity = false,
    subgroup = "ll-raw-material-moon",
    order = "a[moon-rock]-b"
  },
}
