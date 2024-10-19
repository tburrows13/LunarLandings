local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

data:extend({
  {
    type = "resource-category",
    name = "ll-core"
  },
  {
    type = "item",
    name = "ll-core-extractor",
    icon = "__LunarLandings__/graphics/icons/core-extractor.png",
    icon_size = 64,
    subgroup = "extraction-machine",
    order = "d[core-extractor]",
    place_result = "ll-core-extractor",
    stack_size = 10,
  },
  {
    type = "recipe",
    name = "ll-core-extractor",
    enabled = false,
    energy_required = 10,
    ingredients = {
      {type="item", name="steel-plate", amount=50},
      {type="item", name="stone-brick", amount=200},
      {type="item", name="iron-gear-wheel", amount=125},
    },
    results = {{type="item", name="ll-core-extractor", amount=1}}
  },
  {
    type = "mining-drill",
    name = "ll-core-extractor",
    icon = "__LunarLandings__/graphics/icons/core-extractor.png",
    icon_size = 64,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 3, result = "ll-core-extractor"},
    max_health = 1000,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    collision_box = {{-5.4, -5.4}, {5.4, 5.4}},
    selection_box = {{-5.5, -5.5}, {5.5, 5.5}},
    damaged_trigger_effect = hit_effects.entity(),
    --map_color = ei_data.colors.assembler,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = {},
    },
    allowed_effects = {"consumption", "pollution"},  -- Don't want to allow speed beacons
    module_slots = 2,
    mining_speed = 1,
    resource_categories = {"ll-core"},
    energy_usage = "3MW",
    resource_searching_radius = 0.49,
    vector_to_place_result = {0, -5.85},
    circuit_wire_connection_points = circuit_connector_definitions["electric-mining-drill"].points,
    circuit_connector_sprites = circuit_connector_definitions["electric-mining-drill"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance,
    input_fluid_box = {
      volume = 200,
      pipe_covers = pipecoverspictures(),
      pipe_picture = assembler3pipepictures(),  -- TODO does nothing
      pipe_connections =
      {
        { direction = defines.direction.west, position = {-5, 0} },
        { direction = defines.direction.east, position = {5, 0} },
        { direction = defines.direction.south, position = {0, 5} },
      },
      production_type = "input-output",
    },
    graphics_set = {
      circuit_connector_layer = "object",
      circuit_connector_secondary_draw_order = { north = 14, east = 30, south = 30, west = 30 },
      animation = {
        layers = {
          {
            filename = "__LunarLandings__/graphics/entities/core-extractor/core-extractor-shadow.png",
            priority = "high",
            width = 1400,
            height = 1400,
            frame_count = 1,
            repeat_count = 120,
            animation_speed = 0.5,
            --shift = {2 + 3/32, 1 + 22/32},
            draw_as_shadow = true,
            scale = 0.5,
          },
          {
            priority = "high",
            width = 704,
            height = 704,
            frame_count = 120,
            animation_speed = 0.5,
            --shift = {0, -8/32},
            scale = 0.5,
            stripes =
            {
              {
                filename = "__LunarLandings__/graphics/entities/core-extractor/core-extractor-animation-1.png",
                width_in_frames = 8,
                height_in_frames = 8,
              },
              {
                filename = "__LunarLandings__/graphics/entities/core-extractor/core-extractor-animation-2.png",
                width_in_frames = 8,
                height_in_frames = 8,
              },
            },
          },
        }
      },
      working_visualisations = {{
        fadeout = true,
        animation = {
          priority = "high",
          width = 704,
          height = 400,
          shift = util.by_pixel_hr(0, 92),
          frame_count = 120,
          animation_speed = 0.5,
          --shift = {0, -8/32},
          scale = 0.5,
          draw_as_light = true,
          blend_mode = "additive",
          stripes =
          {
            {
              filename = "__LunarLandings__/graphics/entities/core-extractor/core-extractor-animation-emission-1.png",
              width_in_frames = 8,
              height_in_frames = 8,
            },
            {
              filename = "__LunarLandings__/graphics/entities/core-extractor/core-extractor-animation-emission-2.png",
              width_in_frames = 8,
              height_in_frames = 8,
            },
          },
        },
      }},
      --always_draw_idle_animation = true,
      --[[idle_animation = {
        filename = "__LunarLandings__/graphics/entities/core-extractor.png",
        size = {512*2,512*2},
        shift = {0, 0},
        scale = 0.35,
        line_length = 1,
        --lines_per_file = 2,
        frame_count = 1,
        -- animation_speed = 0.2,
      },]]
      --[[working_visualisations = {
        {
          animation = {
            filename = "__LunarLandings__/graphics/entities/core-extractor-animation.png",
            size = {512*2,512*2},
            shift = {0, 0},
            scale = 0.35,
            line_length = 3,
            lines_per_file = 3,
            frame_count = 9,
            animation_speed = 0.5 * 0.4,
            run_mode = "backward",
          },
          light = {
            type = "basic",
            intensity = 1,
            size = 15
          }
        },
      },]]
    },
    working_sound =
    {
        sound = {filename = "__base__/sound/electric-mining-drill.ogg", volume = 0.8},
        apparent_volume = 0.1,
    },
    impact_category = "metal-large",
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
  },
})