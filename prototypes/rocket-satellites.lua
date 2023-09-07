data.raw.item["satellite"].rocket_launch_product = nil

-- Interstellar satellite
data:extend{
  {
    type = "item",
    name = "ll-interstellar-satellite",
    icon = "__LunarLandings__/graphics/item/interstellar-satellite.png",
    icon_size = 64, icon_mipmaps = 4,
    pictures = {
      layers = {
        {
          size = 64,
          filename = "__LunarLandings__/graphics/item/interstellar-satellite.png",
          scale = 0.25,
          mipmap_count = 4,
        },
        {
          draw_as_light = true,
          flags = { "light" },
          size = 64,
          filename = "__LunarLandings__/graphics/item/interstellar-satellite-light.png",
          scale = 0.25,
          mipmap_count = 4,
        },
      },
    },
    subgroup = "space-related",
    order = "q[interstellar-satellite]",
    stack_size = 1,
    rocket_launch_product = {"space-science-pack", 1000}
  },
  {
    type = "recipe",
    name = "ll-interstellar-satellite",
    energy_required = 20,
    enabled = false,
    category = "crafting",
    ingredients =
    {
      {"satellite", 1},
      {"low-density-structure", 50},
      {"rocket-control-unit", 50},
      {"nuclear-fuel", 10},
      {"ll-quantum-processor", 100},
    },
    result = "ll-interstellar-satellite",
    requester_paste_multiplier = 1
  },

}

