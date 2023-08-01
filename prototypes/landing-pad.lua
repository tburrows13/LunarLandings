local sounds = require("__base__.prototypes.entity.sounds")
local hit_effects = require ("__base__.prototypes.entity.hit-effects")

local circuit_connections = {
	circuit_connector_sprites = {
		blue_led_light_offset = {
			1.203125,
			0.828125
		},
		connector_main = {
			filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04a-base-sequence.png",
			height = 50,
			priority = "low",
			scale = 0.5,
			shift = {
				1.046875,
				0.609375
			},
			width = 52,
			x = 156,
			y = 150
		},
		led_blue = {
			filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04e-blue-LED-on-sequence.png",
			height = 60,
			priority = "low",
			scale = 0.5,
			shift = {
				1.046875,
				0.578125
			},
			width = 60,
			x = 180,
			y = 180
		},
		led_blue_off = {
			filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04f-blue-LED-off-sequence.png",
			height = 44,
			priority = "low",
			scale = 0.5,
			shift = {
				1.046875,
				0.578125
			},
			width = 46,
			x = 138,
			y = 132
		},
		led_green = {
			filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04h-green-LED-sequence.png",
			height = 46,
			priority = "low",
			scale = 0.5,
			shift = {
				1.046875,
				0.578125
			},
			width = 48,
			x = 144,
			y = 138
		},
		led_light = {
			intensity = 0.8,
			size = 0.9
		},
		led_red = {
			filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04i-red-LED-sequence.png",
			height = 46,
			priority = "low",
			scale = 0.5,
			shift = {
				1.046875,
				0.578125
			},
			width = 48,
			x = 144,
			y = 138
		},
		red_green_led_light_offset = {
			1.203125,
			0.71875
		},
		wire_pins = {
			filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04c-wire-sequence.png",
			height = 58,
			priority = "low",
			scale = 0.5,
			shift = {
				1.046875,
				0.578125
			},
			width = 62,
			x = 186,
			y = 174
		},
		wire_pins_shadow = {
			draw_as_shadow = true,
			filename = "__base__/graphics/entity/circuit-connector/hr-ccm-universal-04d-wire-shadow-sequence.png",
			height = 54,
			priority = "low",
			scale = 0.5,
			shift = {
				1.203125,
				0.703125
			},
			width = 70,
			x = 210,
			y = 162
		}
	},
	circuit_wire_connection_point = {
		shadow = {
			green = {
				1.5,
				0.71875
			},
			red = {
				1.65625,
				0.703125
			}
		},
		wire = {
			green = {
				1.40625,
				0.6875
			},
			red = {
				1.34375,
				0.46875
			}
		}
	},
	circuit_wire_max_distance = 9
}

data:extend{
  {
    type = "item",
    name = "ll-landing-pad",
    icon = "__LunarLandings__/graphics/landing-pad.png",
    icon_size = 64,
    stack_size = 50,
    place_result = "ll-landing-pad",
		order = "n[landing-pad]",
    subgroup = "space-related",
  },
  {
    type = "recipe",
    name = "ll-landing-pad",
    ingredients = {
      {"steel-chest", 4},
			{"rocket-control-unit", 1},
    },
    energy_required = 4,
    result = "ll-landing-pad",
    enabled = false
  },
  {
    type = "container",
    name = "ll-landing-pad",
    icon = "__LunarLandings__/graphics/landing-pad.png",
    icon_size = 64,
    inventory_size = 40,
    inventory_type = "with_filters_and_bar",
    enable_inventory_bar = false,
    scale_info_icons = false,
    picture = {
      layers = {
        {
					filename = "__base__/graphics/entity/artillery-turret/hr-artillery-turret-base.png",
					height = 199,
					width = 207,
					priority = "high",
					scale = 1,
					hr_version = {
            filename = "__base__/graphics/entity/artillery-turret/hr-artillery-turret-base.png",
            height = 199,
            width = 207,
            priority = "high",
            scale = 1,
          },
        },
        {
          draw_as_shadow = true,
					filename = "__base__/graphics/entity/artillery-turret/hr-artillery-turret-base-shadow.png",
					height = 149,
					width = 277,
          shift = {0.5625 * 2, 0.5 * 2},
					priority = "high",
					scale = 1,
					hr_version = {
            draw_as_shadow = true,
            filename = "__base__/graphics/entity/artillery-turret/hr-artillery-turret-base-shadow.png",
            height = 149,
            width = 277,
						shift = {0.5625 * 2, 0.5 * 2},
						priority = "high",
            scale = 1,
          },
        },
      }
    },
    circuit_connector_sprites = circuit_connections.circuit_connector_sprites,
    circuit_wire_connection_point = circuit_connections.circuit_wire_connection_point,
    circuit_wire_max_distance = circuit_connections.circuit_wire_max_distance,
    max_health = 600,
    minable = {mining_time = 1, result = "ll-landing-pad"},
    placeable_by = {item = "ll-landing-pad", count = 1},
    corpse = "artillery-turret-remnants",
    dying_explosion = "assembling-machine-3-explosion",  -- artillery-turret-explosion is too tall
    damaged_trigger_effect = hit_effects.entity(),
    vehicle_impact_sound = sounds.generic_impact,
    close_sound = {
      filename = "__base__/sound/metallic-chest-close.ogg",
      volume = 0.6
    },
    open_sound = {
      filename = "__base__/sound/metallic-chest-open.ogg",
      volume = 0.6
    },
    collision_box = {{-2.7, -2.7}, {2.7, 2.7}},
    selection_box = {{-3, -3}, {3, 3}},
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    se_allow_in_space = true,
  }
}