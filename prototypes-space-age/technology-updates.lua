data:extend{
  {
    type = "technology",
    name = "ll-luna-rocket-silo",
    icon = "__base__/graphics/technology/rocket-silo.png",
    icon_size = 256,
    essential = true,
    prerequisites = {"low-density-structure", "rocket-control-unit", "electric-engine"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-rocket-silo-up"
      },
      -- TODO add rocket part, cargo landing pad?
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