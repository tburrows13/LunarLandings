local ei_pipe_big_insulated = {
  north = util.empty_sprite(),
  south = {
      layers = {
          {
            filename = "__LunarLandings__/graphics/pipe-covers/electricity_south_covers.png",
            width = 512,
            height = 512,
            shift = {0,-2.15},
            scale = 0.44/2,
          },
          {
            filename = "__LunarLandings__/graphics/pipe-covers/south_basic_covers.png",  -- south_basic_covers_insulated.png
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
    type = "recipe-category",
    name = "ll-arc-smelting"
  },
  {
    type = "recipe",
    name = "ll-arc-furnace",
    ingredients = {{"steel-plate", 10}, {"advanced-circuit", 5}, {"stone-brick", 10}},
    result = "ll-arc-furnace",
    energy_required = 5,
    enabled = true
  },
  {
    type = "item",
    name = "ll-arc-furnace",
    icon = "__LunarLandings__/graphics/icons/arc-furnace.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "smelting-machine",
    order = "d[arc-furnace]",
    place_result = "ll-arc-furnace",
    stack_size = 50
  },
  {
    name = "ll-arc-furnace",
    type = "assembling-machine",
    icon = "__LunarLandings__/graphics/icons/arc-furnace.png",
    icon_size = 64,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {
      mining_time = 0.5,
      result = "ll-arc-furnace"
    },
    max_health = 300,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    --map_color = ei_data.colors.assembler,
    crafting_categories = {"smelting", "ll-electric-smelting", "ll-arc-smelting"},
    crafting_speed = 3,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 1
    },
    energy_usage = "20MW",
    --result_inventory_size = 1,
    --source_inventory_size = 1,
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    module_specification = {
        module_slots = 4
    },
    fluid_boxes = {
      {
        base_area = 1,
        base_level = -1,
        height = 2,
        pipe_covers = pipecoverspictures(),
        pipe_picture = ei_pipe_big_insulated,
        pipe_connections = {
          {type = "input", position = {3, 0}},
        },
        production_type = "input",
      },
      {
        base_area = 1,
        base_level = 1,
        height = 2,
        pipe_covers = pipecoverspictures(),
        pipe_picture = ei_pipe_big_insulated,
        pipe_connections = {
          {type = "output", position = {-3, 0}},
        },
        production_type = "output",
      },
      off_when_no_fluid_recipe = true
    },
    animation = {
      filename = "__LunarLandings__/graphics/entities/arc-furnace.png",
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
          filename = "__LunarLandings__/graphics/entities/arc-furnace-animation.png",
          size = {512,512},
          shift = {0, 0},
          scale = 0.35,
          line_length = 4,
          lines_per_file = 4,
          frame_count = 16,
          animation_speed = 0.4 / 3,
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
    working_sound =
    {
      sound = {filename = "__base__/sound/electric-furnace.ogg", volume = 0.6},
      apparent_volume = 0.3,
    },
    surface_conditions = {nauvis = false, luna = true},
},

}