-- TODO tech orders

bzutil.add_unlock("advanced-material-processing-2", "ll-boil-water")

bzutil.add_unlock("nuclear-power", "ll-rtg")
--bzutil.add_unlock("nuclear-power", "ll-rtg-from-depleted")

data_util.remove_prerequisite("rocket-control-unit", "utility-science-pack")
data_util.remove_research_ingredient("rocket-control-unit", "utility-science-pack")

data_util.remove_prerequisite("advanced-electronics-2", "chemical-science-pack")
data_util.add_prerequisite("advanced-electronics-2", "ll-luna-automation")
data_util.add_prerequisite("advanced-electronics-2", "ll-moon-rock-processing")

data_util.remove_prerequisite("rocket-silo", "speed-module-3")
data_util.remove_prerequisite("rocket-silo", "productivity-module-3")
data_util.add_prerequisite("rocket-silo", "low-density-structure")
data_util.remove_research_ingredient("rocket-silo", "utility-science-pack")
data_util.remove_research_ingredient("rocket-silo", "production-science-pack")
bzutil.add_unlock("rocket-silo", "satellite")
bzutil.add_unlock("rocket-silo", "ll-used-rocket-part-recycling")

data_util.add_prerequisite("production-science-pack", "ll-heat-shielding")

data_util.add_prerequisite("power-armor-mk2", "ll-quantum-computing")
data_util.add_research_ingredient("power-armor-mk2", "production-science-pack")
data_util.add_research_ingredient("power-armor-mk2", "ll-space-science-pack")

data_util.add_prerequisite("spidertron", "ll-space-science-pack")

data_util.remove_prerequisite("space-science-pack", "rocket-silo")
data_util.add_prerequisite("space-science-pack", "ll-interstellar-rocket-silo")
bzutil.remove_recipe_effect("space-science-pack", "satellite")
bzutil.add_unlock("space-science-pack", "ll-interstellar-satellite")
-- bzutil.add_unlock("space-science-pack", "ll-interstellar-satellite")  -- TODO

data:extend{
  {
    type = "technology",
    name = "ll-luna-exploration",
    icon = "__LunarLandings__/graphics/technology/moon.png",  -- TODO change?
    icon_size = 256, icon_mipmaps = 1,
    effects =
    {
      --[[{
        type = "unlock-recipe",
        recipe = "ll-moon-rock-processing"  -- TODO 'starter pack'
      },]]
      {
        type = "unlock-recipe",
        recipe = "ll-landing-pad"
      },
    },
    prerequisites = {"rocket-silo"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "c-o-a"
  },
  {
    type = "technology",
    name = "ll-moon-rock-processing",
    icon = "__LunarLandings__/graphics/technology/silicon-processing.png",
    icon_size = 256, icon_mipmaps = 4,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-moon-rock-processing"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-moon-rock-processing-with-oxygen"
      },
      --[[{
        type = "unlock-recipe",
        recipe = "ll-moon-rock-processing-with-helium"
      },]]
      --[[{
        type = "unlock-recipe",
        recipe = "ll-moon-rock-processing-with-oxygen-helium"
      },]]
      {
        type = "unlock-recipe",
        recipe = "ll-silicon"
      },
    },
    prerequisites = {"ll-luna-exploration", "advanced-material-processing-2"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "c-o-a"
  },
  {
    type = "technology",
    name = "ll-heat-shielding",
    icon = "__space-exploration-graphics__/graphics/technology/heat-shielding.png",
    icon_size = 128, icon_mipmaps = 1,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-heat-shielding"
      },
    },
    prerequisites = {"ll-moon-rock-processing"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "c-o-a"
  },
  {
    type = "technology",
    name = "ll-luna-automation",
    icon = "__space-exploration-graphics__/graphics/technology/space-manufactory.png",
    icon_size = 128, icon_mipmaps = 1,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-low-grav-assembling-machine"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-oxygen-diffuser"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-lunar-foundation"
      }
    },
    prerequisites = {"ll-luna-exploration"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "c-o-a"
  },
  {
    type = "technology",
    name = "ll-ice-extraction",
    icon = "__space-exploration-graphics__/graphics/icons/water-ice.png",
    icon_size = 64, icon_mipmaps = 1,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-core-extractor"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-melt-ice"
      },
    },
    prerequisites = {"ll-luna-exploration"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "c-o-a"
  },
  {
    type = "technology",
    name = "ll-arc-furnace",
    icon = "__LunarLandings__/graphics/technology/arc-furnace.png",
    icon_size = 256, icon_mipmaps = 1,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-arc-furnace"
      },
    },
    prerequisites = {"production-science-pack", "nuclear-power"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
      },
      time = 30
    },
    order = "c-o-a"
  },
  {
    type = "technology",
    name = "ll-rich-moon-rock-processing",
    icon = "__LunarLandings__/graphics/icons/aluminium-plate.png",
    icon_size = 128, icon_mipmaps = 1,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-rich-moon-rock-processing"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-alumina"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-aluminium-plate"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-red-mud-recovery"
      },
    },
    prerequisites = {"ll-arc-furnace"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
      },
      time = 30
    },
    order = "c-o-a"
  },

  {
    type = "technology",
    name = "ll-space-data-collection",
    icon = "__space-exploration-graphics__/graphics/technology/telescope.png",
    icon_size = 128, icon_mipmaps = 1,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-telescope"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-blank-data-card"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-data-card"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-data-card-reformatting"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-broken-data-card-recycling"
      },

    },
    --prerequisites = {"utility-science-pack", "production-science-pack"},
    prerequisites = {"advanced-electronics-2"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        --{"production-science-pack", 1},
        --{"utility-science-pack", 1},
      },
      time = 30
    },
    order = "c-o-a"
  },
  {
    type = "technology",
    name = "ll-space-science-pack",
    icon = "__LunarLandings__/graphics/technology/space-science-pack.png",
    icon_size = 256, icon_mipmaps = 1,
    prerequisites = {"ll-space-data-collection", "ll-rich-moon-rock-processing"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-space-science-pack"
      }
    },
    unit =
    {
      count = 75,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
      },
      time = 5
    },
    order = "c-a"
  },
  {
    type = "technology",
    name = "ll-low-density-structure-aluminium",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__base__/graphics/technology/low-density-structure.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-low-density-structure-aluminium"
      }
    },
    prerequisites = {"ll-space-science-pack"},
    unit =
    {
      count = 600,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"ll-space-science-pack", 1},
      },
      time = 60
    },
    order = "k-a"
  },
  {
    type = "technology",
    name = "ll-quantum-resource-processing",
    icon = "__LunarLandings__/graphics/technology/neodym-refining.png",
    icon_size = 128, icon_mipmaps = 1,
    prerequisites = {"ll-space-science-pack"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-astrocrystal-processing"
      }
    },
    unit =
    {
      count = 75,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        --{"utility-science-pack", 1},
      },
      time = 5
    },
    order = "c-a"
  },
  {
    type = "technology",
    name = "ll-quantum-computing",
    icon = "__LunarLandings__/graphics/icons/quantum-processor.png",
    icon_size = 64, icon_mipmaps = 1,
    prerequisites = {"ll-quantum-resource-processing"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-quantum-processor"
      },
    },
    unit =
    {
      count = 75,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        --{"utility-science-pack", 1},
      },
      time = 5
    },
    order = "c-a"
  },
  {
    type = "technology",
    name = "ll-quantum-resonation",
    icon = "__LunarLandings__/graphics/technology/computer-core.png",
    icon_size = 256, icon_mipmaps = 1,
    prerequisites = {"ll-quantum-computing", "utility-science-pack"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-quantum-resonator"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-superposition-up-down"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-superposition-right-left"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-polarisation-up"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-polarisation-right"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-polarisation-left"
      },
      {
        type = "unlock-recipe",
        recipe = "ll-polarisation-down"
      },

    },
    unit =
    {
      count = 75,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
      },
      time = 5
    },
    order = "c-a"
  },
  {
    type = "technology",
    name = "ll-quantum-data-collection",
    icon = "__space-exploration-graphics__/graphics/technology/telescope.png",
    icon_size = 128, icon_mipmaps = 1,
    prerequisites = {"ll-quantum-resonation"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-quantum-data-card"
      },
    },
    unit =
    {
      count = 75,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
      },
      time = 5
    },
    order = "c-a"
  },
  {
    type = "technology",
    name = "ll-quantum-science-pack",
    icon = "__LunarLandings__/graphics/technology/quantum-science-pack.png",
    icon_size = 256, icon_mipmaps = 4,
    prerequisites = {"ll-quantum-data-collection"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-quantum-science-pack"
      },
    },
    unit =
    {
      count = 75,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
      },
      time = 5
    },
    order = "c-a"
  },
  {
    type = "technology",
    name = "ll-quantum-module",
    icon = "__LunarLandings__/graphics/technology/quantum-module.png",
    icon_size = 256, icon_mipmaps = 4,
    prerequisites = {"ll-quantum-science-pack"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-quantum-module"
      },
    },
    unit =
    {
      count = 75,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
      },
      time = 5
    },
    order = "c-a"
  },
  {
    type = "technology",
    name = "ll-interstellar-rocket-silo",
    icon = "__space-exploration-graphics__/graphics/technology/probe-rocket.png",
    icon_size = 128, icon_mipmaps = 1,
    prerequisites = {"ll-quantum-science-pack"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ll-rocket-silo-interstellar"
      },
    },
    unit =
    {
      count = 75,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1}
      },
      time = 5
    },
    order = "c-a"
  },
}