local tint = {r = 0.7, g = 1, b = 0.7, a = 1}
local size = 3
local shift = {x=32/32, y= -10/32}



data:extend({
  -- items --
  {
    type = "item",
    name = "ll-rtg",
    icon = "__LunarLandings__/graphics/icons/rtg.png",
    icon_size = 64, icon_mipmaps = 1,
    order = "f[nuclear-energy]-1[rtg]",
    place_result = "ll-rtg",
    stack_size = 5,
    subgroup = "energy",
  },
  --[[{
    type = "item",
    name = "ll-rtg-depleted",
    icon = "__LunarLandings__/graphics/icons/rtg-depleted.png",
    icon_size = 32, icon_mipmaps = 1,
    order = "f[nuclear-energy]-2[depleted-rtg]",
    -- place_result = RTG,
    stack_size = 5,
    subgroup = "energy",
  },]]
  {
    type = "recipe",
    name = "ll-rtg",
    enabled = false,
    energy_required = 5,
    ingredients = {
      {"iron-plate", 20},
      {"electronic-circuit", 10},
      {"uranium-fuel-cell", 5}, -- 5x 8 GJ!
    },
    result = "ll-rtg",
  },
  --[[{
    type = "recipe",
    name = "ll-rtg-from-depleted",
    enabled = false,
    energy_required = 30,
    ingredients = {
      {"ll-rtg-depleted", 1},
      {"uranium-fuel-cell", 5}, -- 5x 8 GJ!
    },
    result = "ll-rtg",
  },]]
  {
    type = "electric-energy-interface",
    name = "ll-rtg",
    icon = "__LunarLandings__/graphics/icons/rtg.png",
    icon_size = 64, icon_mipmaps = 1,
    minable = {
      mining_time = 1,
      --results = {{"ll-rtg-depleted", 1}, {"used-up-uranium-fuel-cell", 5}}
    },
    flags = {
      "placeable-neutral",
      "player-creation",
      "not-repairable"
    },
    max_health = 600,
    collision_box = {{-size/2+0.23, -size/2+0.23},{size/2-0.23, size/2-0.23}},
    selection_box = {{-size/2, -size/2}, {size/2, size/2}},
    --enable_gui = false,
    energy_source = {
      type = "electric",
      buffer_capacity = "10kJ", -- 10 kJ per tick is (600 kJ/sec) or just 600 kW
      usage_priority = "primary-output",
      input_flow_limit = "0kW",
      output_flow_limit = "600kW",
    },
    energy_production = "600kW",
    energy_usage = "0kW",
    picture =
    {
      layers =
      {
        {
          filename = "__LunarLandings__/graphics/entities/rtg.png",
          priority = "extra-high",
          scale = 0.4,
          width = 241,
          height = 285,
          shift = {0, -0.1},
        },
        {
          filename = "__core__/graphics/light-small.png",
          priority = "extra-high",
          draw_as_light = true,
          width = 150,
          height = 150,
        },
        {
          filename = "__LunarLandings__/graphics/entities/rtg-shadow.png",
          priority = "extra-high",
          draw_as_shadow = true,
          scale = 0.4,
          width = 350,
          height = 193,
          shift = {0.8, 0.7},
        }
      }
    },
    corpse = "big-remnants",
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/electric-furnace.ogg",
        volume = 0.4
      },
      idle_sound =
      {
        filename = "__base__/sound/electric-furnace.ogg",
        volume = 0.3
      },
      max_sounds_per_type = 5
    },
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    },
    order = "z-f[nuclear-energy]-1[rtg]",
  },
})
