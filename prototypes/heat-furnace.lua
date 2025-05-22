local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")


animation_speed = 0.5
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
    --result_inventory_size = 1,
    energy_usage = "200kW",
    crafting_speed = 2,
    --source_inventory_size = 1,
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
            draw_as_shadow = true,
            filename = "__LunarLandings__/graphics/entities/heat-furnace/convector-shadow.png",
            priority = "high",
            width = 600,
            height = 500,
            frame_count = 1,
            line_length = 1,
            repeat_count = 80,
            animation_speed = animation_speed,
            shift = util.by_pixel_hr(0, -8),
            scale = 0.5 * 0.57,
          },
          {
            priority = "high",
            width = 360,
            height = 350,
            frame_count = 80,
            shift = util.by_pixel_hr(0, -8),
            animation_speed = animation_speed,
            scale = 0.5 * 0.57,
            stripes =
            {
              {
                filename = "__LunarLandings__/graphics/entities/heat-furnace/convector-animation-1.png",
                width_in_frames = 8,
                height_in_frames = 8,
              },
              {
                filename = "__LunarLandings__/graphics/entities/heat-furnace/convector-animation-2.png",
                width_in_frames = 8,
                height_in_frames = 8,
              },
            },
          },
        },
      },
      working_visualisations = {{
        fadeout = true,
        secondary_draw_order = 1,
        animation = {
          layers = {
            {
              size = {360, 350},
              shift = util.by_pixel_hr(0, -8),
              scale = 0.5 * 0.57,
              frame_count = 80,
              draw_as_glow = true,
              blend_mode = "additive",
              animation_speed = animation_speed,
              stripes =
              {
                {
                  filename = "__LunarLandings__/graphics/entities/heat-furnace/convector-animation-emission-1.png",
                  width_in_frames = 8,
                  height_in_frames = 8,
                },
                {
                  filename = "__LunarLandings__/graphics/entities/heat-furnace/convector-animation-emission-2.png",
                  width_in_frames = 8,
                  height_in_frames = 8,
                },
              },
            },
          },
        },
      }},
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