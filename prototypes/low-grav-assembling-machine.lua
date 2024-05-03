for i, recipe in pairs({"copper-cable", "electronic-circuit", "advanced-circuit"}) do
  data.raw.recipe[recipe].category = "circuit-crafting"
end

local function add_to_crafting_categories(prototype)
  local crafting_categories = prototype.crafting_categories or {}
  for i, category in pairs(crafting_categories) do
    if category == "crafting" then
      table.insert(crafting_categories, "circuit-crafting")
      break
    end
  end
end

for _, prototype in pairs(data.raw["assembling-machine"]) do
  add_to_crafting_categories(prototype)
end
for _, prototype in pairs(data.raw["character"]) do
  add_to_crafting_categories(prototype)
end

data.raw.recipe["processing-unit"].category = "advanced-circuit-crafting"

-- SE Space Manufactory is 9x9 - too big
-- This one needs scaling down: 5x5

local scale = 5 / 9

local animation_speed = 0.3
data:extend{
  {
    type = "recipe-category",
    name = "circuit-crafting"
  },
  {
    type = "recipe-category",
    name = "advanced-circuit-crafting"
  },
  {
    type = "recipe",
    name = "ll-low-grav-assembling-machine",
    enabled = false,
    ingredients =
    {
      {"ll-lunar-foundation", 20},
      {"advanced-circuit", 50},
      {"steel-plate", 20},
      {"iron-gear-wheel", 20},
    },
    result = "ll-low-grav-assembling-machine"
  },
  {
    type = "item",
    name = "ll-low-grav-assembling-machine",
    icon = "__space-exploration-graphics__/graphics/icons/manufactory.png",
    icon_size = 64,
    subgroup = "production-machine",
    order = "c[assembling-machine-3]",
    place_result = "ll-low-grav-assembling-machine",
    stack_size = 50
  },
  {
    type = "assembling-machine",
    name = "ll-low-grav-assembling-machine",
    icon = "__space-exploration-graphics__/graphics/icons/manufactory.png",
    icon_size = 64,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "ll-low-grav-assembling-machine"},
    max_health = 900,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -3} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, 3} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {-3, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "input",
        pipe_picture = pipe_pics,
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {3, 0} }},
        secondary_draw_orders = { north = -1 }
      },
      off_when_no_fluid_recipe = true
    },
    --open_sound = data_util.machine_open_sound,
    --close_sound = data_util.machine_close_sound, TODO
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t3-1.ogg",
          volume = 0.8
        },
        {
          filename = "__base__/sound/assembling-machine-t3-2.ogg",
          volume = 0.8
        },
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
      apparent_volume = 1.5,
    },
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    collision_mask = {
      "water-tile",
      --"ground-tile",
      "item-layer",
      "object-layer",
      "player-layer",
    },
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    drawing_box = {{-2.5, -2.8}, {2.5, 2.5}},
    animation =
    {
      layers =
      {
        {
          filename = "__space-exploration-graphics-5__/graphics/entity/space-manufactory/hr/base.png",
          priority = "high",
          width = 577,
          height = 605,
          frame_count = 1,
          line_length = 1,
          repeat_count = 128,
          shift = util.by_pixel(0, -8 * scale),
          animation_speed = animation_speed,
          scale = 0.5 * scale,
        },
        {
          priority = "high",
          width = 512,
          height = 422,
          frame_count = 128,
          shift = util.by_pixel(-0, -51 * scale),
          animation_speed = animation_speed,
          scale = 0.5 * scale,
          stripes =
          {
            {
             filename = "__space-exploration-graphics-5__/graphics/entity/space-manufactory/hr/top-1.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
            {
             filename = "__space-exploration-graphics-5__/graphics/entity/space-manufactory/hr/top-2.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
            {
             filename = "__space-exploration-graphics-5__/graphics/entity/space-manufactory/hr/top-3.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
            {
             filename = "__space-exploration-graphics-5__/graphics/entity/space-manufactory/hr/top-4.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
            {
             filename = "__space-exploration-graphics-5__/graphics/entity/space-manufactory/hr/top-5.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
            {
             filename = "__space-exploration-graphics-5__/graphics/entity/space-manufactory/hr/top-6.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
            {
             filename = "__space-exploration-graphics-5__/graphics/entity/space-manufactory/hr/top-7.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
            {
             filename = "__space-exploration-graphics-5__/graphics/entity/space-manufactory/hr/top-8.png",
             width_in_frames = 4,
             height_in_frames = 4,
            },
          }
        },
        {
          filename = "__space-exploration-graphics-5__/graphics/entity/space-manufactory/hr/middle.png",
          priority = "high",
          width = 40,
          height = 82,
          frame_count = 128,
          line_length = 16,
          shift = util.by_pixel(51 * scale, 79 * scale),
          animation_speed = animation_speed,
          scale = 0.5 * scale,
        },
        --[[{
          filename = "__space-exploration-graphics-5__/graphics/entity/space-manufactory/hr/lower.png",
          priority = "high",
          width = 80,
          height = 22,
          frame_count = 128,
          line_length = 8,
          shift = util.by_pixel(62, 137),
          scale = 0.5,
        },]]--
        {
          draw_as_shadow = true,
          filename = "__space-exploration-graphics-5__/graphics/entity/space-manufactory/hr/shadow.png",
          priority = "high",
          width = 795,
          height = 430,
          frame_count = 1,
          line_length = 1,
          repeat_count = 128,
          shift = util.by_pixel(67 * scale, 38 * scale),
          scale = 0.5 * scale,
        },
      },
    },
    crafting_categories = {"circuit-crafting", "advanced-circuit-crafting"},
    crafting_speed = 2,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 50,
    },
    energy_usage = "750kW",
    module_specification =
    {
      module_slots = 6
    },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    --scale_entity_info_icon = true,
    --[[working_visualisations =
    {
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = {intensity = 0.8, size = 20, shift = {0.0, 0.0}, color = {r = 0.7, g = 0.8, b = 1}}
      },
    },]]
    surface_conditions = {nauvis = false, luna = {plain = false, lowland = false, mountain = false, foundation = true}},
  },

}