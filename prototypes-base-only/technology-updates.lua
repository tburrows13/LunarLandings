data.raw.technology["rocket-silo"].unit.count = 500
x_util.remove_prerequisite("rocket-silo", "speed-module-3")
x_util.remove_prerequisite("rocket-silo", "productivity-module-3")
x_util.remove_prerequisite("rocket-silo", "utility-science-pack")
x_util.remove_prerequisite("rocket-silo", "electric-energy-accumulators")
x_util.add_prerequisite("rocket-silo", "low-density-structure")
x_util.add_prerequisite("rocket-silo", "rocket-control-unit")
x_util.add_prerequisite("rocket-silo", "electric-engine")
x_util.remove_research_ingredient("rocket-silo", "utility-science-pack")
x_util.remove_research_ingredient("rocket-silo", "production-science-pack")
x_util.remove_recipe_effect("rocket-silo", "satellite")
x_util.add_unlock("rocket-silo", "ll-landing-pad")

data.raw.technology["space-science-pack"].research_trigger = {
  type = "send-item-to-orbit",
  item = "ll-interstellar-satellite"
}
x_util.remove_prerequisite("space-science-pack", "rocket-silo")
x_util.add_prerequisite("space-science-pack", "ll-interstellar-rocket-silo")
x_util.remove_recipe_effect("space-science-pack", "satellite")

data:extend{
  {
    type = "technology",
    name = "ll-interstellar-rocket-silo",
    icon = "__space-exploration-graphics__/graphics/technology/probe-rocket.png",
    icon_size = 128,
    essential = true,
    prerequisites = {"ll-quantum-science-pack"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-rocket-silo-interstellar"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-rocket-part-interstellar"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-interstellar-satellite"
      },
    },
    unit =
    {
      count = 3000,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1}
      },
      time = 60
    },
    order = "c-a"
  },
}