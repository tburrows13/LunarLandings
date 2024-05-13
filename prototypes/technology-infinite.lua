
local infinite_mining_productivity = data.raw.technology['mining-productivity-4']
infinite_mining_productivity.name = "mining-productivity-6"
infinite_mining_productivity.prerequisites = {"mining-productivity-5", "space-science-pack"}
infinite_mining_productivity.unit.count_formula = "2500*(L - 5)" -- "2500*(L - 3)"
data:extend{
  infinite_mining_productivity,
  {
    type = "technology",
    name = "mining-productivity-4",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_productivity("__base__/graphics/technology/mining-productivity.png"),
    effects =
    {
      {
        type = "mining-drill-productivity-bonus",
        modifier = 0.1
      }
    },
    prerequisites = {"mining-productivity-3"},
    unit =
    {
      count_formula = 1500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "c-k-f-e"
  },
  {
    type = "technology",
    name = "mining-productivity-5",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_productivity("__base__/graphics/technology/mining-productivity.png"),
    effects =
    {
      {
        type = "mining-drill-productivity-bonus",
        modifier = 0.1
      }
    },
    prerequisites = {"mining-productivity-4"},
    unit =
    {
      count_formula = 2000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
        {"ll-quantum-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "c-k-f-e"
  },
}