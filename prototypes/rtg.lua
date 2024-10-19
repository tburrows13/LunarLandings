local tint = {r = 0.7, g = 1, b = 0.7, a = 1}
local size = 3
local shift = {x=32/32, y= -10/32}



data:extend({
  -- items --
  {
    type = "item",
    name = "ll-rtg",
    icon = "__LunarLandings__/graphics/icons/rtg.png",
    icon_size = 64,
    order = "f[nuclear-energy]-1[rtg]",
    place_result = "ll-rtg",
    stack_size = 10,
    subgroup = "energy",
  },
  --[[{
    type = "item",
    name = "ll-rtg-depleted",
    icon = "__LunarLandings__/graphics/icons/rtg-depleted.png",
    icon_size = 32,
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
      {type="item", name="iron-plate", amount=20},
      {type="item", name="electronic-circuit", amount=10},
      {type="item", name="uranium-fuel-cell", amount=5}, -- 5x 8 GJ!
    },
    results = {{type="item", name="ll-rtg", amount=1}},
  },
  --[[{
    type = "recipe",
    name = "ll-rtg-from-depleted",
    enabled = false,
    energy_required = 30,
    ingredients = {
      {type="item", name="ll-rtg-depleted", amount=1},
      {type="item", name="uranium-fuel-cell", amount=5}, -- 5x 8 GJ!
    },
    results = {{type="item", name="ll-rtg", amount=1}},
  },]]
  {
    type = "electric-energy-interface",
    name = "ll-rtg",
    icon = "__LunarLandings__/graphics/icons/rtg.png",
    icon_size = 64,
    minable = {
      mining_time = 1,
      results = {{type="item", name="depleted-uranium-fuel-cell", amount=5}}
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
      render_no_power_icon = false,
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
    impact_category = "metal",
    order = "z-f[nuclear-energy]-1[rtg]",
  },
})
