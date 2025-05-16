-- SE Space Trains adds the tech in data-updates...
x_util.remove_recipe_effect("tech-space-trains", "space-train-battery-charging-station")
x_util.remove_recipe_effect("tech-space-trains", "space-train-battery-pack")
x_util.remove_recipe_effect("tech-space-trains", "space-train-destroyed-battery-pack")
x_util.remove_recipe_effect("tech-space-trains", "space-train-battery-pack-refurbish")
x_util.remove_recipe_effect("tech-space-trains", "space-train-battery-pack-recharge")

data.raw["assembling-machine"]["space-train-battery-charging-station"] = nil
data.raw.item["space-train-battery-charging-station"] = nil
data.raw.item["space-train-battery-pack"] = nil
data.raw.item["space-train-destroyed-battery-pack"] = nil
data.raw.item["space-train-discharged-battery-pack"] = nil
data.raw.recipe["space-train-battery-pack-recharge"] = nil
data.raw.recipe["space-train-battery-pack-refurbish"] = nil
data.raw.recipe["space-train-battery-pack"] = nil
data.raw.recipe["space-train-battery-charging-station"] = nil

data.raw.recipe["space-train-battery-charging-station-recycling"] = nil
data.raw.recipe["space-train-battery-pack-recycling"] = nil
data.raw.recipe["space-train-destroyed-battery-pack-recycling"] = nil
data.raw.recipe["space-train-discharged-battery-pack-recycling"] = nil


-- Insert into position 1
local space_train_tech = data.raw["technology"]["tech-space-trains"]
table.insert(space_train_tech.effects, 1, {type = "unlock-recipe", recipe = "ll-moon-rail"})
-- Swap cargo and fluid wagon ordering
space_train_tech.effects[3], space_train_tech.effects[4] = space_train_tech.effects[4], space_train_tech.effects[3]
space_train_tech.icon = "__space-exploration-graphics__/graphics/technology/space-rail.png"
space_train_tech.icon_size = 128
space_train_tech.unit.count = 300

x_util.remove_prerequisite("tech-space-trains", "battery")
x_util.remove_prerequisite("tech-space-trains", "steel-processing")
if SPACE_AGE then
  x_util.remove_prerequisite("tech-space-trains", "electromagnetic-plant")
  x_util.remove_prerequisite("tech-space-trains", "holmium-processing")
  x_util.add_prerequisite("tech-space-trains", "processing-unit")
end

data.raw.recipe["space-locomotive"].ingredients = {
  {type="item", name="low-density-structure", amount=4},
  {type="item", name="processing-unit", amount=10},
  {type="item", name="electric-engine-unit", amount=20},
}
data.raw.recipe["space-cargo-wagon"].ingredients = {
  {type="item", name="low-density-structure", amount=4},
  {type="item", name="processing-unit", amount=5},
}
data.raw.recipe["space-fluid-wagon"].ingredients = {
  {type="item", name="low-density-structure", amount=4},
  {type="item", name="processing-unit", amount=5},
  {type="item", name="storage-tank", amount=1},
  {type="item", name="pipe", amount=8},
}

data.raw["item-with-entity-data"]["space-locomotive"].order = "c[rolling-stock]-e[space-locomotive]"
data.raw["item-with-entity-data"]["space-cargo-wagon"].order = "c[rolling-stock]-f[space-cargo-wagon]"
data.raw["item-with-entity-data"]["space-fluid-wagon"].order = "c[rolling-stock]-g[space-fluid-wagon]"

if mods["elevated-rails"] then
  table.insert(data.raw.technology["tech-space-trains"].effects, 2, {
    type = "unlock-recipe",
    recipe = "ll-moon-rail-support",
  })
  table.insert(data.raw.technology["tech-space-trains"].effects, 2, {
    type = "unlock-recipe",
    recipe = "ll-moon-rail-ramp",
  })
  x_util.add_prerequisite("tech-space-trains", "elevated-rail")
  x_util.remove_prerequisite("tech-space-trains", "production-science-pack")
end

if SPACE_AGE then
  data.raw["recipe"]["space-locomotive"].category = "crafting"
  data.raw["recipe"]["space-locomotive"].allow_productivity = false
  data.raw["recipe"]["space-cargo-wagon"].category = "crafting"
  data.raw["recipe"]["space-cargo-wagon"].allow_productivity = false
  data.raw["recipe"]["space-fluid-wagon"].category = "crafting"
  data.raw["recipe"]["space-fluid-wagon"].allow_productivity = false

  data.raw["technology"]["tech-space-trains"].unit = {
    count = 1000,
    ingredients = {
      { "automation-science-pack", 1 },
      { "logistic-science-pack",   1 },
      { "chemical-science-pack",   1 },
      { "production-science-pack", 1 }
    },
    time = 60
  }
end