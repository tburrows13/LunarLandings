-- 1 vanilla rocket fuel = 10 LL liquid rocket fuel

local rocket_fuel_recipe = data.raw.recipe["rocket-fuel"]
rocket_fuel_recipe.result = nil
rocket_fuel_recipe.results = {
  {type="fluid", name="ll-rocket-fuel", amount=10}
}
rocket_fuel_recipe.subgroup = "fluid-recipes"

-- Replace all rocket-fuel with ll-rocket-fuel (fluid)
-- Doesn't handle normal/expensive, etc
for _, recipe in pairs(data.raw.recipe) do
  if recipe.ingredients then
    for i, ingredient in pairs(recipe.ingredients) do
      if ingredient.name == "rocket-fuel" or ingredient[1] == "rocket-fuel" then
        recipe.ingredients[i] = {type = "fluid", name = "ll-rocket-fuel", amount = (ingredient.amount or ingredient[2]) * 10}
        if recipe.category == "crafting" then
          recipe.category = "crafting-with-fluid"
        end
      end
    end
  end
end

data.raw["item"]["rocket-fuel"].flags = {"hidden", "hide-from-fuel-tooltip"}

data.raw.recipe["rocket-part"].ingredients = {
  {"rocket-control-unit", 10},
  {"low-density-structure", 10},
  {type = "fluid", name = "ll-rocket-fuel", amount = 30},
}

data.raw["item"]["rocket-control-unit"].stack_size = 20
data.raw["item"]["low-density-structure"].stack_size = 20

data.raw["item"]["rocket-part"].order = "o[rocket-part]-b"

data:extend{
  {
    type = "fluid",
    name = "ll-rocket-fuel",
    default_temperature = 25,
    heat_capacity = "0.1KJ",
    base_color = {r = 255, g = 191, b = 0},
    flow_color = {r = 255, g = 191, b = 0},
    icon = "__space-exploration-graphics__/graphics/icons/fluid/liquid-rocket-fuel.png",
    icon_size = 64,
    order = "f[rocket-fuel]"
  },
  {
    type = "item",
    name = "ll-heat-shielding",
    icon = "__space-exploration-graphics__/graphics/icons/heat-shielding.png",
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "o[rocket-part]-a",
    stack_size = 20,
  },
  {
    type = "recipe",
    name = "ll-heat-shielding",
    category = "crafting",
    energy_required = 20,
    enabled = false,
    ingredients =
    {
      {"steel-plate", 2},
      {"stone-brick", 10},
      {"plastic-bar", 2},
      {"ll-silica", 5},
    },
    result = "ll-heat-shielding"
  },
  {
    type = "item",
    name = "rocket-part-down",
    localised_name = {"item-name.rocket-part-down"},
    icon = "__base__/graphics/icons/rocket-part.png",
    icon_size = 64,
    flags = {"hidden"},
    subgroup = "intermediate-product",
    order = "o[rocket-part]-c",
    stack_size = 5
  },
  {
    type = "recipe",
    name = "rocket-part-down",
    energy_required = 3,
    enabled = false,
    hidden = true,
    category = "rocket-building-luna",
    ingredients =
    {
      {"ll-heat-shielding", 10},
      {"low-density-structure", 10},
      {"rocket-control-unit", 10},
      {type = "fluid", name = "steam", amount = 100, temperature = 500}
    },
    result = "rocket-part-down"
  },
  {
    type = "item",
    name = "rocket-part-interstellar",
    localised_name = {"item-name.rocket-part-interstellar"},
    icon = "__base__/graphics/icons/rocket-part.png",
    icon_size = 64,
    flags = {"hidden"},
    subgroup = "intermediate-product",
    order = "o[rocket-part]-d",
    stack_size = 5
  },
  {
    type = "recipe",
    name = "rocket-part-interstellar",
    energy_required = 3,
    enabled = false,
    hidden = true,
    category = "rocket-building-interstellar",
    ingredients =
    {
      {"ll-heat-shielding", 10},
      {"low-density-structure", 10},
      {"rocket-control-unit", 10},
      {"ll-quantum-processor", 1},
      {"nuclear-fuel", 1},
    },
    result = "rocket-part-interstellar"
  },
  {
    type = "item",
    name = "ll-used-rocket-part",
    icon = "__base__/graphics/icons/rocket-part.png",
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "o[rocket-part]-e",
    stack_size = 1
  },
  {
    type = "recipe",
    name = "ll-used-rocket-part-recycling",
    icons = {
      {
        icon = "__base__/graphics/icons/rocket-part.png",
        icon_size = 64,
      },
      {
        icon = "__LunarLandings__/graphics/icons/recycle.png",
        icon_size = 64,
        scale = 0.3,
        shift = {-8, 8},
      }
    },
    energy_required = 60,
    enabled = false,
    subgroup = "intermediate-product",
    category = "crafting",
    order = "o[rocket-part]-b",
    allow_decomposition = false,
    ingredients =
    {
      {"ll-used-rocket-part", 1},
      {"steel-plate", 1},
      {"copper-plate", 5}
    },
    results = {
      {type = "item", name = "rocket-control-unit", amount_min = 5, amount_max = 10},
      {type = "item", name = "low-density-structure", amount_min = 5, amount_max = 10},
    }
  },
}

x_util.allow_productivity("ll-heat-shielding")
