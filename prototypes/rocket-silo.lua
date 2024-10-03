local rocket = data.raw["rocket-silo-rocket"]["rocket-silo-rocket"]
rocket.inventory_size = 20

data.raw["item"]["rocket-silo"].localised_name = {"entity-name.rocket-silo"}
data.raw["item"]["rocket-silo"].stack_size = 5

local rocket_silo = data.raw["rocket-silo"]["rocket-silo"]
rocket_silo.localised_name = {"entity-name.ll-rocket-silo-up"}
rocket_silo.rocket_result_inventory_size = 20
rocket_silo.fluid_boxes = {
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = -1,
    pipe_connections = {{ type="input", position = {0, -5} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = 1,
    pipe_connections = {{ type="input", position = {0, 5} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = 1,
    pipe_connections = {{ type="input", position = {5, 0} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = 1,
    pipe_connections = {{ type="input", position = {-5, 0} }},
    secondary_draw_orders = { north = -1 }
  },

  off_when_no_fluid_recipe = true
}


data:extend{
  {
    type = "recipe-category",
    name = "rocket-building-luna"
  },
  {
    type = "recipe-category",
    name = "rocket-building-interstellar"
  },
  {
    type = "item",
    name = "ll-rocket-silo-interstellar",
    icon = "__space-exploration-graphics__/graphics/icons/probe-rocket-silo.png",
    icon_size = 64,
    subgroup = "space-related",
    order = "x[interstellar-rocket-silo]",
    place_result = "ll-rocket-silo-interstellar",
    stack_size = 1
  },
  {
    type = "recipe",
    name = "ll-rocket-silo-interstellar",
    enabled = false,
    ingredients =
    {
      {"steel-plate", 1000},
      {"ll-lunar-foundation", 500},
      {"pipe", 100},
      {"ll-quantum-processor", 200},
      {"electric-engine-unit", 200}
    },
    energy_required = 30,
    results = {{type="item", name="ll-rocket-silo-interstellar", amount=1}},
    requester_paste_multiplier = 1
  },
}

--[[data.raw["rocket-silo"]["rocket-silo"].created_effect = {
  type = "direct",
  action_delivery = {
    type = "instant",
    source_effects = {
      {
        type = "script",
        effect_id = "ll-rocket-silo-created",
      },
    }
  }
}]]

rocket_silo.rocket_parts_required = 20

data.raw.recipe["rocket-silo"].ingredients =
{
  {"steel-plate", 200},
  {"concrete", 200},
  {"pipe", 20},
  {"advanced-circuit", 100},
  {"electric-engine-unit", 40}
}


local rocket_down = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
rocket_down.name = "ll-rocket-silo-down"
rocket_down.localised_name = {"entity-name.ll-rocket-silo-down"}
rocket_down.minable.result = "rocket-silo"
rocket_down.placeable_by = {item = "rocket-silo", count = 1}
rocket_down.crafting_categories = {"rocket-building-luna"}
rocket_down.rocket_parts_required = 5
rocket_down.fixed_recipe = "rocket-part-down"
table.insert(rocket_down.flags, "not-in-made-in")
rocket_down.fluid_boxes =
{
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = -1,
    pipe_connections = {{ type="input", position = {0, -5} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = 1,
    pipe_connections = {{ type="input", position = {0, 5} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = 1,
    pipe_connections = {{ type="input", position = {5, 0} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = 1,
    pipe_connections = {{ type="input", position = {-5, 0} }},
    secondary_draw_orders = { north = -1 }
  },

  off_when_no_fluid_recipe = true
}

local rocket_silo_interstellar = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
rocket_silo_interstellar.name = "ll-rocket-silo-interstellar"
rocket_silo_interstellar.icon = "__space-exploration-graphics__/graphics/icons/probe-rocket-silo.png"
rocket_silo_interstellar.localised_name = {"entity-name.ll-rocket-silo-interstellar"}
rocket_silo_interstellar.minable.result = "ll-rocket-silo-interstellar"
rocket_silo_interstellar.crafting_categories = {"rocket-building-interstellar"}
rocket_silo_interstellar.rocket_parts_required = 50
rocket_silo_interstellar.fixed_recipe = "rocket-part-interstellar"
rocket_silo_interstellar.rocket_entity = "ll-rocket-interstellar"
rocket_silo_interstellar.surface_conditions = {nauvis = false, luna = true}

rocket_silo_interstellar.base_day_sprite = {layers = {
  {
    filename = "__base__/graphics/entity/rocket-silo/06-rocket-silo.png",
    width = 300,
    height = 300,
    shift = util.by_pixel(2, -2),
    hr_version =
    {
      filename = "__base__/graphics/entity/rocket-silo/hr-06-rocket-silo.png",
      width = 608,
      height = 596,
      shift = util.by_pixel(3, -1),
      scale = 0.5
    }
  },
  {
    filename = "__space-exploration-graphics-5__/graphics/entity/probe/sr/06-rocket-silo-mask.png",
    width = 608/2,
    height = 596/2,
    shift = util.by_pixel(3, -1),
    tint = {r=0.9,b=0.3,g=0.3},
    hr_version =
    {
      filename = "__space-exploration-graphics-5__/graphics/entity/probe/hr/06-rocket-silo-mask.png",
      width = 608,
      height = 596,
      shift = util.by_pixel(3, -1),
      tint = {r=0.9,b=0.3,g=0.3},
      scale = 0.5
    }
  },
}}
rocket_silo_interstellar.base_front_sprite = {
  layers = {
    {
      filename = "__base__/graphics/entity/rocket-silo/14-rocket-silo-front.png",
      width = 292,
      height = 132,
      shift = util.by_pixel(-2, 78),
      hr_version =
      {
        filename = "__base__/graphics/entity/rocket-silo/hr-14-rocket-silo-front.png",
        width = 580,
        height = 262,
        shift = util.by_pixel(-1, 78),
        scale = 0.5
      }
    },
    {
      filename = "__space-exploration-graphics-5__/graphics/entity/probe/sr/14-rocket-silo-front-mask.png",
      width = 580/2,
      height = 262/2,
      shift = util.by_pixel(-1, 78),
      tint = {r=0.9,b=0.3,g=0.3},
      hr_version =
      {
        filename = "__space-exploration-graphics-5__/graphics/entity/probe/hr/14-rocket-silo-front-mask.png",
        width = 580,
        height = 262,
        shift = util.by_pixel(-1, 78),
        tint = {r=0.9,b=0.3,g=0.3},
        scale = 0.5
      }
    },
  }
}

local rocket_interstellar = table.deepcopy(data.raw["rocket-silo-rocket"]["rocket-silo-rocket"])
rocket_interstellar.name = "ll-rocket-interstellar"
rocket_interstellar.inventory_size = 1
rocket_interstellar.rocket_sprite = util.add_shift_offset(util.by_pixel(0, 32*3.5), --util.mul_shift(rocket_rise_offset, -1),
{
  filename = "__space-exploration-graphics-5__/graphics/entity/probe/sr/probe-rocket.png",
  width = 310/2,
  height = 596/2,
  shift = util.by_pixel(-5, -27),
  hr_version = {
    filename = "__space-exploration-graphics-5__/graphics/entity/probe/hr/probe-rocket.png",
    width = 310,
    height = 596,
    shift = util.by_pixel(-5, -27),
    scale = 0.5
  }
})


data:extend{rocket_down, rocket_silo_interstellar, rocket_interstellar}

x_util.disallow_productivity("rocket-part")
