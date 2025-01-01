-- 1 vanilla rocket fuel = 10 LL liquid rocket fuel

local rocket_fuel_recipe = data.raw.recipe["rocket-fuel"]
rocket_fuel_recipe.results = {
  {type="fluid", name="ll-rocket-fuel", amount=10}
}
rocket_fuel_recipe.subgroup = "fluid-recipes"

-- Replace all rocket-fuel with ll-rocket-fuel (fluid)
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

data.raw["item"]["rocket-fuel"].flags = {"hide-from-fuel-tooltip"}
data.raw["item"]["rocket-fuel"].hidden = true

data:extend{
  {
    type = "fluid",
    name = "ll-rocket-fuel",
    subgroup = "fluid",
    default_temperature = 25,
    heat_capacity = "0.1kJ",
    base_color = {r = 255, g = 191, b = 0},
    flow_color = {r = 255, g = 191, b = 0},
    icon = "__space-exploration-graphics__/graphics/icons/fluid/liquid-rocket-fuel.png",
    icon_size = 64,
    order = "f[rocket-fuel]"
  },
}