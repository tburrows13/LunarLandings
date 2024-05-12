-- SE Space Trains adds the tech in data-updates...
bzutil.remove_recipe_effect("tech-space-trains", "space-train-battery-charging-station")
bzutil.remove_recipe_effect("tech-space-trains", "space-train-battery-pack")
bzutil.remove_recipe_effect("tech-space-trains", "space-train-destroyed-battery-pack")
bzutil.remove_recipe_effect("tech-space-trains", "space-train-battery-pack-refurbish")
bzutil.remove_recipe_effect("tech-space-trains", "space-train-battery-pack-recharge")

-- Insert into position 1
local space_train_tech = data.raw["technology"]["tech-space-trains"]
table.insert(space_train_tech.effects, 1, {type = "unlock-recipe", recipe = "ll-moon-rail"})
-- Swap cargo and fluid wagon ordering
space_train_tech.effects[3], space_train_tech.effects[4] = space_train_tech.effects[4], space_train_tech.effects[3]
space_train_tech.icon = "__space-exploration-graphics__/graphics/technology/space-rail.png"
space_train_tech.icon_size = 128
space_train_tech.icon_mipmaps = 1

data_util.remove_prerequisite("tech-space-trains", "battery")
data_util.remove_prerequisite("tech-space-trains", "steel-processing")

local space_train_refurbish = data.raw.recipe["space-train-battery-pack-refurbish"]
if space_train_refurbish then
  space_train_refurbish.crafting_machine_tint = space_train_refurbish.crafting_machine_tint or {}
  space_train_refurbish.crafting_machine_tint.primary    = { r = 174, g = 139, b = 12 }
  space_train_refurbish.crafting_machine_tint.secondary  = { r = 174, g = 139, b = 12 }
  space_train_refurbish.crafting_machine_tint.tertiary   = { r = 174, g = 139, b = 12 }
  space_train_refurbish.crafting_machine_tint.quaternary = { r = 174, g = 139, b = 12 }
end


data.raw.recipe["recipe-space-locomotive"].ingredients = {
  {"low-density-structure", 4},
  {"processing-unit", 10},
  {"electric-engine-unit", 20},
}
data.raw.recipe["recipe-space-cargo-wagon"].ingredients = {
  {"low-density-structure", 4},
  {"processing-unit", 5},
}
data.raw.recipe["recipe-space-fluid-wagon"].ingredients = {
  {"low-density-structure", 4},
  {"processing-unit", 5},
  {"storage-tank", 1},
  {"pipe", 8},
}
