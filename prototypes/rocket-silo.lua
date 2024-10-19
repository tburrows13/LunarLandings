local rocket = data.raw["rocket-silo-rocket"]["rocket-silo-rocket"]
rocket.inventory_size = 20

data.raw["item"]["rocket-silo"].localised_name = {"entity-name.rocket-silo"}
data.raw["item"]["rocket-silo"].stack_size = 5

local rocket_silo = data.raw["rocket-silo"]["rocket-silo"]
rocket_silo.localised_name = {"entity-name.ll-rocket-silo-up"}
rocket_silo.to_be_inserted_to_rocket_inventory_size = 20
rocket_silo.fluid_boxes = {
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    pipe_connections = {{ flow_direction = "input", direction = defines.direction.north, position = {0, -4} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    pipe_connections = {{ flow_direction = "input", direction = defines.direction.south, position = {0, 4} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    pipe_connections = {{ flow_direction = "input", direction = defines.direction.east, position = {4, 0} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    pipe_connections = {{ flow_direction = "input", direction = defines.direction.west, position = {-4, 0} }},
    secondary_draw_orders = { north = -1 }
  },
}
rocket_silo.fluid_boxes_off_when_no_fluid_recipe = true

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
      {type="item", name="steel-plate", amount=1000},
      {type="item", name="ll-lunar-foundation", amount=500},
      {type="item", name="pipe", amount=100},
      {type="item", name="ll-quantum-processor", amount=200},
      {type="item", name="electric-engine-unit", amount=200}
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
  {type="item", name="steel-plate", amount=200},
  {type="item", name="concrete", amount=200},
  {type="item", name="pipe", amount=20},
  {type="item", name="advanced-circuit", amount=100},
  {type="item", name="electric-engine-unit", amount=40}
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
    volume = 1000,
    pipe_connections = {{ flow_direction = "input", direction = defines.direction.north, position = {0, -4} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    pipe_connections = {{ flow_direction = "input", direction = defines.direction.south, position = {0, 4} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    pipe_connections = {{ flow_direction = "input", direction = defines.direction.east, position = {4, 0} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    pipe_connections = {{ flow_direction = "input", direction = defines.direction.west, position = {-4, 0} }},
    secondary_draw_orders = { north = -1 }
  },
}
rocket_down.fluid_boxes_off_when_no_fluid_recipe = true


local rocket_silo_interstellar = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
rocket_silo_interstellar.name = "ll-rocket-silo-interstellar"
rocket_silo_interstellar.icon = "__space-exploration-graphics__/graphics/icons/probe-rocket-silo.png"
rocket_silo_interstellar.localised_name = {"entity-name.ll-rocket-silo-interstellar"}
rocket_silo_interstellar.minable.result = "ll-rocket-silo-interstellar"
rocket_silo_interstellar.crafting_categories = {"rocket-building-interstellar"}
rocket_silo_interstellar.rocket_parts_required = 50
rocket_silo_interstellar.fixed_recipe = "rocket-part-interstellar"
rocket_silo_interstellar.rocket_entity = "ll-rocket-interstellar"
rocket_silo_interstellar.ll_surface_conditions = {nauvis = false, luna = true}

rocket_silo_interstellar.base_day_sprite = {layers = {
  {
    filename = "__base__/graphics/entity/rocket-silo/06-rocket-silo.png",
    width = 608,
    height = 596,
    shift = util.by_pixel(3, -1),
    scale = 0.5
  },
  {
    filename = "__space-exploration-graphics-5__/graphics/entity/probe/hr/06-rocket-silo-mask.png",
    width = 608,
    height = 596,
    shift = util.by_pixel(3, -1),
    tint = {r=0.9,b=0.3,g=0.3},
    scale = 0.5
  },
}}
rocket_silo_interstellar.base_front_sprite = {
  layers = {
    {
      filename = "__base__/graphics/entity/rocket-silo/14-rocket-silo-front.png",
      width = 580,
      height = 262,
      shift = util.by_pixel(-1, 78),
      scale = 0.5
    },
    {
      filename = "__space-exploration-graphics-5__/graphics/entity/probe/hr/14-rocket-silo-front-mask.png",
      width = 580,
      height = 262,
      shift = util.by_pixel(-1, 78),
      tint = {r=0.9,b=0.3,g=0.3},
      scale = 0.5
    },
  }
}

local rocket_interstellar = table.deepcopy(data.raw["rocket-silo-rocket"]["rocket-silo-rocket"])
rocket_interstellar.name = "ll-rocket-interstellar"
rocket_interstellar.inventory_size = 1
rocket_interstellar.rocket_sprite = util.add_shift_offset(util.by_pixel(0, 32*3.5), --util.mul_shift(rocket_rise_offset, -1),
{
  filename = "__space-exploration-graphics-5__/graphics/entity/probe/hr/probe-rocket.png",
  width = 310,
  height = 596,
  shift = util.by_pixel(-5, -27),
  scale = 0.5
})


data:extend{rocket_down, rocket_silo_interstellar, rocket_interstellar}

x_util.disallow_productivity("rocket-part")
