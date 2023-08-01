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
  {
    production_type = "output",
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = 1,
    pipe_connections = {{ type="output", position = {-2, -1} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "output",
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = 1,
    pipe_connections = {{ type="output", position = {1, -2} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "output",
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = 1,
    pipe_connections = {{ type="output", position = {2, 1} }},
    secondary_draw_orders = { north = -1 }
  },
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
    enabled = false,
    category = "ll-electric-smelting",
    subgroup = "fluid-recipes",
    ingredients = {{"ll-ice", 1}},
    results = {
      {type = "fluid", name = "water", amount = 100, fluidbox_index = 2},
    }
  },
  {
    type = "recipe",
    name = "ll-boil-water",
    enabled = false,
    category = "ll-electric-smelting",
    subgroup = "fluid-recipes",
    ingredients = {
      {type = "fluid", name = "water", amount = 100, fluidbox_index = 0},
    },
    results = {
      {type = "fluid", name = "steam", amount = 100, temperature = 500, fluidbox_index = 2},
    }
  },
}