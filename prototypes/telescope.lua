data:extend{
  {
    type = "recipe",
    name = "ll-telescope",
    enabled = false,
    energy_required = 8,
    ingredients =
    {
      {type="item", name="iron-gear-wheel", amount=30},
      {type="item", name="processing-unit", amount=10},
      {type="item", name="lab", amount=2},
    },
    results = {{type="item", name="ll-telescope", amount=1}}
  },
  {
    type = "item",
    name = "ll-telescope",
    icon = "__space-exploration-graphics__/graphics/icons/telescope.png",
    icon_size = 64,
    subgroup = "production-machine",
    order = "h[telescope]",
    place_result = "ll-telescope",
    stack_size = 50
  },
  {
    type = "assembling-machine",
    name = "ll-telescope",
    icon = "__space-exploration-graphics__/graphics/icons/telescope.png",
    icon_size = 64,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.1, result = "ll-telescope"},
    max_health = 500,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    drawing_box = {{-1.5, -1.9}, {1.5, 1.5}},
    resistances =
    {
      {
        type = "impact",
        percent = 10
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        --pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections = {{ flow_direction="input", direction = defines.direction.south, position = {0, 1} }},
        secondary_draw_orders = { north = -1 }
      },
    },
    --fluid_boxes_off_when_no_fluid_recipe = true,
    open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.5},
    close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.5},
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound = {
      apparent_volume = 1.5,
      idle_sound = {
        filename = "__base__/sound/idle1.ogg",
        volume = 0.6
      },
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t1-1.ogg",
          volume = 0.8
        },
        {
          filename = "__base__/sound/assembling-machine-t1-2.ogg",
          volume = 0.8
        }
      }
    },
    collision_mask = {
      layers = {
        water_tile = true,
        item = true,
        object = true,
        player = true,
      }
    },
    graphics_set = {
      animation =
      {
        layers =
        {
          {
            filename = "__space-exploration-graphics-4__/graphics/entity/telescope/sr/telescope.png",
            priority = "high",
            width = 2080/8/2,
            height = 2128/8/2,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(6, -19),
            animation_speed = 0.3,
            hr_version = {
              filename = "__space-exploration-graphics-4__/graphics/entity/telescope/hr/telescope.png",
              priority = "high",
              width = 2080/8,
              height = 2128/8,
              frame_count = 64,
              line_length = 8,
              shift = util.by_pixel(6, -19),
              animation_speed = 0.3,
              scale = 0.5,
            }
          },
          {
            draw_as_shadow = true,
            filename = "__space-exploration-graphics-4__/graphics/entity/telescope/sr/telescope-shadow.png",
            priority = "high",
            width = 2608/8/2,
            height = 1552/8/2,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(32, 7),
            animation_speed = 0.3,
            hr_version = {
              draw_as_shadow = true,
              filename = "__space-exploration-graphics-4__/graphics/entity/telescope/hr/telescope-shadow.png",
              priority = "high",
              width = 2608/8,
              height = 1552/8,
              frame_count = 64,
              line_length = 8,
              shift = util.by_pixel(32, 7),
              animation_speed = 0.3,
              scale = 0.5,
            }
          },
        },
      },
    },
    crafting_categories = {"ll-telescope-data"},
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = {},
    },
    energy_usage = "1000kW",
    ingredient_count = 12,
    module_slots = 4,
    allowed_effects = {"consumption", "speed",  "pollution"}, -- not "productivity",
    --[[working_visualisations =
    {
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = {intensity = 0.5, size = 8, shift = {0.0, 0.0}, color = {r = 0.9, g = 1, b = 0.8}}
      },
    },]]
    --surface_conditions = {nauvis = false, luna = {plain = false, lowland = false, mountain = true, foundation = false}}
  },

}