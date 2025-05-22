x_util.add_prerequisite("planet-discovery-aquilo", "ll-space-science-pack")
x_util.add_prerequisite("quantum-processor", "ll-quantum-science-pack")
x_util.add_unlock("space-platform-thruster", "ll-processing-unit-without-silicon")

x_util.add_effect("processing-unit-productivity", {
  type = "change-recipe-productivity",
  recipe = "ll-processing-unit-without-silicon",
  change = 0.1
})

data:extend{
  {
    type = "technology",
    name = "ll-luna-rocket-silo",
    icon = "__base__/graphics/technology/rocket-silo.png",
    icon_size = 256,
    essential = true,
    prerequisites = {"low-density-structure", "rocket-control-unit", "rocket-fuel", "electric-engine", "concrete"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-rocket-silo-up"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-rocket-part-nauvis",
      },
      {
        type = "unlock-recipe",
        recipe = "cargo-landing-pad"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-landing-pad"
      },
    },
    unit =
    {
      count = 500,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 60
    },
    order = "c-a"
  },
}