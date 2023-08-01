-- SE Space Trains adds the tech in data-updates...
bzutil.remove_recipe_effect("tech-space-trains", "space-train-battery-charging-station")
bzutil.remove_recipe_effect("tech-space-trains", "space-train-battery-pack")
bzutil.remove_recipe_effect("tech-space-trains", "space-train-destroyed-battery-pack")
bzutil.remove_recipe_effect("tech-space-trains", "space-train-battery-pack-refurbish")
bzutil.remove_recipe_effect("tech-space-trains", "space-train-battery-pack-recharge")

data_util.remove_prerequisite("tech-space-trains", "battery")
data_util.remove_prerequisite("tech-space-trains", "steel-processing")
