local sounds = require("__base__.prototypes.entity.sounds")


ei_pipe_big_data = {
  north = util.empty_sprite(),
  south = {
      layers = {
          {
            filename = "__LunarLandings__/graphics/pipe-covers/data_south_covers.png",
            width = 512,
            height = 512,
            -- shift = {0,-2.15},
            scale = 0.35,
            shift = util.by_pixel(0, -96), 
          },
          {
            filename = "__LunarLandings__/graphics/pipe-covers/south_basic_covers_data.png",
            priority = "high",
            width = 55,
            height = 50,
            shift = {0.01, -0.58},
            scale = 0.5
          }
      }
  },
  west = {
    filename = "__LunarLandings__/graphics/pipe-covers/big_west_covers.png",
    priority = "high",
    width = 512,
    height = 512,
    scale = 0.35,
    shift = util.by_pixel(96, 0),        
  },
  east = {
    filename = "__LunarLandings__/graphics/pipe-covers/big_east_covers.png",
    priority = "high",
    width = 512,
    height = 512,
    scale = 0.35,
    shift = util.by_pixel(-96, 0),
  }
}

data:extend{
  {
    name = "ll-quantum-resonating",
    type = "recipe-category",
  },
  {
    name = "ll-quantum-resonator",
    type = "item",
    icon = "__LunarLandings__/graphics/icons/computer-core.png",
    icon_size = 64,
    subgroup = "production-machine",
    order = "i[quantum-resonator]",
    place_result = "ll-quantum-resonator",
    stack_size = 50
  },
  {
    name = "ll-quantum-resonator",
    type = "recipe",
    category = "crafting",
    energy_required = 20,
    ingredients =
    {
      {type="item", name="lab", amount=5},
      {type="item", name="concrete", amount=100},
      {type="item", name="ll-aluminium-plate", amount=100},
      {type="item", name="ll-quantum-processor", amount=20},
    },
    results = {{type="item", name="ll-quantum-resonator", amount=1}},
    enabled = false,
    main_product = "ll-quantum-resonator",
  },
  {
    name = "ll-quantum-resonator",
    type = "assembling-machine",
    icon = "__LunarLandings__/graphics/icons/computer-core.png",
    icon_size = 64,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {
      mining_time = 1,
      results = {{type="item", name="ll-quantum-resonator", amount=1}}
    },
    max_health = 300,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    --map_color = ei_data.colors.assembler,
    crafting_categories = {"ll-quantum-resonating"},
    crafting_speed = 1,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
    },
    energy_usage = "15MW",
    allowed_effects = {"consumption", "pollution", "speed"},
    module_slots = 3,
    graphics_set = {
      animation = {
        filename = "__LunarLandings__/graphics/entities/computer-core.png",
        size = {512,512},
        shift = {0, 0},
        scale = 0.35,
        line_length = 1,
        --lines_per_file = 2,
        frame_count = 1,
        -- animation_speed = 0.2,
      },
      working_visualisations = {
        {
          animation =
          {
            filename = "__LunarLandings__/graphics/entities/computer-core_animation.png",
            size = {512,512},
            shift = {0, 0},
            scale = 0.35,
            line_length = 6,
            lines_per_file = 6,
            frame_count = 36,
            animation_speed = 0.4,
            run_mode = "backward",
          }
        },
        {
          light = {
            type = "basic",
            intensity = 1,
            size = 15
          }
        }
      },
    },
    impact_category = "metal-large",
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound = {filename = "__base__/sound/nuclear-reactor-1.ogg", volume = 0.6},
      apparent_volume = 0.3,
    },
    ll_surface_conditions = {nauvis = false, luna = {plain = false, lowland = false, mountain = false, foundation = true}}
  }
}