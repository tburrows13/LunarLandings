-- TODO change "Select recipe for assembling" text in this and arc furnace

local furnace = data.raw.furnace["electric-furnace"]
furnace.type = "assembling-machine"
table.insert(furnace.crafting_categories, "ll-electric-smelting")
furnace.fluid_boxes =
{
  {
    production_type = "input",
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = -1,
    pipe_connections = {{ type="input", position = {-1, 2} }},
    secondary_draw_orders = { north = -1 }
  },
  --[[{
    production_type = "output",
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = 1,
    pipe_connections = {{ type="output", position = {-2, -1} }},
    secondary_draw_orders = { north = -1 }
  },]]
  {
    production_type = "output",
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = 1,
    pipe_connections = {{ type="output", position = {1, -2} }},
    secondary_draw_orders = { north = -1 }
  },
  --[[{
    production_type = "output",
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = 1,
    pipe_connections = {{ type="output", position = {2, 1} }},
    secondary_draw_orders = { north = -1 }
  },]]
  off_when_no_fluid_recipe = true
}

data:extend{furnace}
data.raw["furnace"]["electric-furnace"] = nil --disable original furnace

data:extend{
  {
    type = "recipe-category",
    name = "ll-electric-smelting"
  },
  {
    type = "recipe",
    name = "ll-melt-ice",
    icon = "__base__/graphics/icons/fluid/water.png",
    icon_size = 64, icon_mipmaps = 4,
    enabled = false,
    category = "ll-electric-smelting",
    subgroup = "fluid-recipes",
    order = "a[fluid]-a[water]",
    energy_required = 5,
    ingredients = {{"ll-ice", 1}},
    results = {
      {type = "fluid", name = "water", amount = 100, fluidbox_index = 1},
    },
    main_product = ""
  },
  {
    type = "recipe",
    name = "ll-boil-water",
    icon = "__base__/graphics/icons/fluid/steam.png",
    icon_size = 64, icon_mipmaps = 4,
    enabled = false,
    category = "ll-electric-smelting",
    subgroup = "fluid-recipes",
    order = "a[fluid]-b[steam]",
    energy_required = 5,
    ingredients = {
      {type = "fluid", name = "water", amount = 100},
    },
    results = {
      {type = "fluid", name = "steam", amount = 100, temperature = 500, fluidbox_index = 1},
    },
    main_product = ""
  },
}

x_util.allow_productivity("ll-melt-ice")
x_util.allow_productivity("ll-boil-water")
