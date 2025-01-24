data.raw.tool["space-science-pack"].stack_size = 200

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
    --rocket_launch_products = {{type="item", name="space-science-pack", amount=1000}},  -- Messes with 2.0 systems. Return items by script instead
    localised_description = {"", {"item-description.ll-interstellar-satellite"}, "\n\n[font=default-semibold][color=255, 230, 192]", {"description.rocket-launch-products"}, "[/color][/font]:\n", "[img=item.space-science-pack] [font=default-bold]1.0k ×[/font] ", {"item-name.space-science-pack"}},
  },
  {
    type = "recipe",
    name = "ll-interstellar-satellite",
    energy_required = 20,
    enabled = false,
    category = "crafting",
    ingredients =
    {
      --{type="item", name="satellite", amount=1},  -- TODO 2.0 add more to the recipe in lieu of satellite
      {type="item", name="low-density-structure", amount=50},
      {type="item", name="rocket-control-unit", amount=50},
      {type="item", name="nuclear-fuel", amount=10},
      {type="item", name="ll-quantum-processor", amount=100},
    },
    results = {{type="item", name="ll-interstellar-satellite", amount=1}},
    requester_paste_multiplier = 1
  },
}

