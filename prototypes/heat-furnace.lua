local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

data:extend{
  {
    type = "recipe",
    name = "ll-heat-furnace",
    enabled = false,
    ingredients = {{type="item", name="stone-brick", amount=20}, {type="item", name="heat-pipe", amount=4}},
    results = {{type="item", name="ll-heat-furnace", amount=1}},
  },
  {
    type = "item",
    name = "ll-heat-furnace",
    icon = "__LunarLandings__/graphics/icons/heat-furnace.png",
    icon_size = 64,
    subgroup = "smelting-machine",
    order = "d[heat-furnace]",
    place_result = "ll-heat-furnace",
    stack_size = 50
  },
  {
    type = "assembling-machine",
    name = "ll-heat-furnace",
    icon = "__LunarLandings__/graphics/icons/heat-furnace.png",
    icon_size = 64,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "ll-heat-furnace"},
    max_health = 200,
    corpse = "steel-furnace-remnants",
    dying_explosion = "steel-furnace-explosion",
    impact_category = "metal",
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/steel-furnace.ogg",
          volume = 0.46
        }
      },
      max_sounds_per_type = 4,
      audible_distance_modifier = 0.37,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    resistances =
    {
      {
        type = "fire",
        percent = 100
      },
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    crafting_categories = {"smelting", "ll-fluid-smelting"},
    result_inventory_size = 1,
    energy_usage = "200kW",
    crafting_speed = 2,
    source_inventory_size = 1,
    energy_source =
    {
      type = "heat",
      max_temperature = 1000,
      specific_heat = "1MJ",
      max_transfer = "2GW",
      min_working_temperature = 500,
      minimum_glow_temperature = 350,
      connections =
      {
        {
          position = {0, -1},
          direction = defines.direction.north
        },
        {
          position = {1, 0},
          direction = defines.direction.east
        },
        {
          position = {0, 1},
          direction = defines.direction.south
        },
        {
          position = {-1, 0},
          direction = defines.direction.west
        },
      },
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections = {{ flow_direction="input", direction = defines.direction.south, position = {-1, 1} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections = {{ flow_direction="output", direction = defines.direction.north, position = {1, -1} }},
        secondary_draw_orders = { north = -1 }
      },
    },
    fluid_boxes_off_when_no_fluid_recipe = true,
    graphics_set = {
      animation =
      {
        layers =
        {
          {
            filename = "__base__/graphics/entity/steel-furnace/steel-furnace.png",
            priority = "high",
            width = 171,
            height = 174,
            frame_count = 1,
            shift = util.by_pixel(-1.25, 2),
            scale = 0.5 * 1.5
          },
          {
            filename = "__base__/graphics/entity/steel-furnace/steel-furnace-shadow.png",
            priority = "high",
            width = 277,
            height = 85,
            frame_count = 1,
            draw_as_shadow = true,
            shift = util.by_pixel(39.25, 11.25),
            scale = 0.5 * 1.5
          }
        }
      },
      working_visualisations =
      {
        {
          draw_as_light = true,
          fadeout = true,
          effect = "flicker",
          animation =
          {
            filename = "__base__/graphics/entity/steel-furnace/steel-furnace-fire.png",
            priority = "high",
            line_length = 8,
            width = 57,
            height = 81,
            frame_count = 48,
            direction_count = 1,
            shift = util.by_pixel(-0.75, 5.75),
            scale = 0.5 * 1.5
          },
        },
        {
          fadeout = true,
          draw_as_light = true,
          effect = "flicker",
          animation =
          {
            filename = "__base__/graphics/entity/steel-furnace/steel-furnace-glow.png",
            priority = "high",
            width = 60,
            height = 43,
            frame_count = 1,
            shift = {0.03125, 0.640625},
            blend_mode = "additive",
            scale = 1.5,
          }
        },
        {
          fadeout = true,
          draw_as_light = true,
          effect = "flicker",
          animation =
          {
            filename = "__base__/graphics/entity/steel-furnace/steel-furnace-working.png",
            priority = "high",
            line_length = 1,
            width = 128,
            height = 150,
            frame_count = 1,
            direction_count = 1,
            shift = util.by_pixel(0, -5),
            blend_mode = "additive",
            scale = 0.5 * 1.5
          }
        },
        {
          draw_as_light = true,
          draw_as_sprite = false,
          fadeout = true,
          effect = "flicker",
          animation =
          {
            filename = "__base__/graphics/entity/steel-furnace/steel-furnace-ground-light.png",
            priority = "high",
            line_length = 1,
            draw_as_sprite = false,
            width = 152,
            height = 126,
            frame_count = 1,
            direction_count = 1,
            shift = util.by_pixel(1, 48),
            blend_mode = "additive",
            scale = 0.5 * 1.5
          },
        },
      },
    },
    fast_replaceable_group = "furnace",
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/steel-furnace/steel-furnace-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 24,
        shift = util.by_pixel(0, 45),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    }
  }
}