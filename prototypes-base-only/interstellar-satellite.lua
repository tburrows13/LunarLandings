data.raw.tool["space-science-pack"].stack_size = 200
data.raw.tool["space-science-pack"].localised_name = {"item-name.ll-interstellar-science-pack"}
data.raw.tool["space-science-pack"].localised_description = {"item-description.ll-interstellar-science-pack"}

data:extend{
  {
    type = "item",
    name = "ll-interstellar-satellite",
    icon = "__LunarLandings__/graphics/item/interstellar-satellite.png",
    icon_size = 64,
    pictures = {
      layers = {
        {
          size = 64,
          filename = "__LunarLandings__/graphics/item/interstellar-satellite.png",
          scale = 0.5,
        },
        {
          draw_as_light = true,
          flags = { "light" },
          size = 64,
          filename = "__LunarLandings__/graphics/item/interstellar-satellite-light.png",
          scale = 0.5,
        },
      },
    },
    subgroup = "space-related",
    order = "y[interstellar-satellite]",
    stack_size = 1,
    weight = 1 * tons,
    rocket_launch_products = {{type="item", name="space-science-pack", amount=1000}},
  },
  {
    type = "recipe",
    name = "ll-interstellar-satellite",
    energy_required = 20,
    enabled = false,
    category = "circuit-crafting",
    ingredients =
    {
      --{type="item", name="satellite", amount=1},  -- TODO 2.0 add more to the recipe in lieu of satellite
      {type="item", name="low-density-structure", amount=50},
      {type="item", name="rocket-control-unit", amount=50},
      {type="item", name="nuclear-fuel", amount=10},
      {type="item", name="ll-quantum-processor", amount=100},
      {type="item", name="ll-blank-data-card", amount=100},
      {type="item", name="ll-aluminium-plate", amount=50},
    },
    results = {{type="item", name="ll-interstellar-satellite", amount=1}},
    requester_paste_multiplier = 1
  },
}

