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
			{"steel-plate", 75},
			{"stone-brick", 100},
			{"iron-gear-wheel", 200},
		},
		results = {{type="item", name="ll-core-extractor", amount=1}}
	},
  {
    type = "mining-drill",
    name = "ll-core-extractor",
    crafting_categories = {"ei_bio-chamber", "ei_excavator"},
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
		  emissions_per_minute = 0
		},
    --allowed_effects = {"speed", "consumption", "pollution", "productivity"},
    --module_specification = {module_slots = 2},
    mining_speed = 1,
    resource_categories = {"ll-core"},
    energy_usage = "3MW",
    resource_searching_radius = 0.49,
		vector_to_place_result = {0, -5.85},
    circuit_wire_connection_points = circuit_connector_definitions["electric-mining-drill"].points,
		circuit_connector_sprites = circuit_connector_definitions["electric-mining-drill"].sprites,
		circuit_wire_max_distance = default_circuit_wire_max_distance,
    input_fluid_box = {   
      base_area = 1,
      base_level = -1,
      height = 2,
      pipe_covers = pipecoverspictures(),
      --pipe_picture = ei_pipe_big_round, TODO
      pipe_connections =
      {
        { position = {-6, 0} },
        { position = {6, 0} },
        { position = {0, 6} }
      },
      production_type = "input-output",
    },
    graphics_set = {
      circuit_connector_layer = "object",
		  circuit_connector_secondary_draw_order = { north = 14, east = 30, south = 30, west = 30 },
      always_draw_idle_animation = true,
		  idle_animation = {
        filename = "__LunarLandings__/graphics/entities/core-extractor.png",
        size = {512*2,512*2},
        shift = {0, 0},
        scale = 0.35,
        line_length = 1,
        --lines_per_file = 2,
        frame_count = 1,
        -- animation_speed = 0.2,
      },
      working_visualisations = {
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
      },
    },
    working_sound =
    {
        sound = {filename = "__base__/sound/electric-mining-drill.ogg", volume = 0.8},
        apparent_volume = 0.1,
    },
    vehicle_impact_sound = sounds.generic_impact,
		open_sound = sounds.machine_open,
		close_sound = sounds.machine_close,
  },
})