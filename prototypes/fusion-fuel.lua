-- Modify PFR, space trains, to use fusion fuel

data.raw["generator-equipment"]["fusion-reactor-equipment"].burner = {
  type = "burner",
  fuel_inventory_size = 3,
  fuel_category = "ll-fusion",
}

-- Trains no longer use batteries
data.raw["locomotive"]["space-locomotive"].burner = {
  type = "burner",
  fuel_inventory_size = 3,
  fuel_category = "ll-fusion",
}

data:extend{
  {
    type = "fuel-category",
    name = "ll-fusion"
  },
  {
    type = "fluid",
    name = "ll-helium-3",
    default_temperature = 15,
    max_temperature = 1000,
    heat_capacity = "0.2KJ",
    icon = "__LunarLandings__/graphics/fluids/helium-3.png",
    icon_size = 64,
    base_color = {r = 173, g = 216, b = 230},
    flow_color = {r = 173, g = 216, b = 230},
    order = "g[gas]-b[helium-3]",
    --gas_temperature = 15,
    auto_barrel = false
  },
  {
    type = "item",
    name = "ll-fusion-fuel",
    icon = "__LunarLandings__/graphics/icons/fusion-fuel.png",
    icon_size = 64,
    pictures =
    {
      layers =
      {
        {
          size = 64,
          filename = "__LunarLandings__/graphics/icons/fusion-fuel.png",
          scale = 0.25,
          mipmap_count = 4
        },
        {
          draw_as_light = true,
          flags = {"light"},
          size = 64,
          filename = "__base__/graphics/icons/nuclear-fuel-light.png",
          scale = 0.25,
          mipmap_count = 4
        }
      }
    },
    fuel_category = "ll-fusion",
    fuel_value = "3GJ",
    fuel_acceleration_multiplier = 2.5,
    fuel_top_speed_multiplier = 1.15,
    -- fuel_glow_color = {r = 0.1, g = 1, b = 0.1},
    subgroup = "intermediate-product",
    order = "r[fusion-fuel]",
    stack_size = 1
  },
  {
    type = "recipe",
    name = "ll-fusion-fuel",
    energy_required = 90,
    enabled = true,
    category = "centrifuging",
    subgroup = "intermediate-product",
    ingredients = {
      {type = "fluid", name = "ll-helium-3", amount = 1000},
      {type="item", name="steel-plate", amount=1},
    },
    main_product = "ll-fusion-fuel",
    results = {
      {type="item", name="ll-fusion-fuel", amount=1},
      {type = "fluid", name = "ll-helium-3", amount = 900},
    }
  },
}

x_util.allow_productivity("ll-fusion-fuel")  -- TODO check vanilla nuclear fuel