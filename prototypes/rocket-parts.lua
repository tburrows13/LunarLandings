local rocket_part_recipe = table.deepcopy(data.raw.recipe["rocket-part"])
rocket_part_recipe.name = "ll-rocket-part-nauvis"
rocket_part_recipe.category = "rocket-building-nauvis-luna"
rocket_part_recipe.results = {{type="item", name="ll-rocket-part-nauvis", amount=1}}
rocket_part_recipe.ingredients = {
  {type="item", name="rocket-control-unit", amount=5},
  {type="item", name="low-density-structure", amount=5},
  {type="fluid", name="ll-rocket-fuel", amount=25},
}
if SPACE_AGE then
  rocket_part_recipe.ingredients[3] = {type="item", name="rocket-fuel", amount=2}
end
rocket_part_recipe.allow_productivity = false

local rocket_part_item = table.deepcopy(data.raw.item["rocket-part"])
rocket_part_item.name = "ll-rocket-part-nauvis"
rocket_part_item.icon = nil
rocket_part_item.icons = {
  {
    icon = "__base__/graphics/icons/rocket-part.png",
    icon_size = 64,
  },
  {
    icon = "__base__/graphics/icons/nauvis.png",
    icon_size = 64,
    scale = 0.3,
    shift = {6, 6},
    draw_background = true,
  }
}
rocket_part_item.localised_name = {"item-name.ll-rocket-part-nauvis"}
rocket_part_item.order = "o[rocket-part]-c"

data:extend{
  rocket_part_recipe,
  rocket_part_item,
  {
    type = "item",
    name = "rocket-control-unit",
    icon = "__LunarLandings__/graphics/icons/rocket-control-unit.png",
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "n[rocket-control-unit]",
    stack_size = 50,
    weight = 5*kg,
  },
  {
    type = "recipe",
    name = "rocket-control-unit",
    energy_required = 12,
    enabled = false,
    category = "crafting-with-fluid",
    additional_categories = {"circuit-crafting"},
    ingredients =
    {
      {type="item", name="advanced-circuit", amount=3},
      {type="item", name="electronic-circuit", amount=3},
      {type="fluid", name="sulfuric-acid", amount=3},
    },
    results = {{type="item", name="rocket-control-unit", amount=1}},
    allow_productivity = true,
  },
  {
    type = "item",
    name = "ll-heat-shielding",
    icon = "__space-exploration-graphics__/graphics/icons/heat-shielding.png",
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "o[rocket-part]-a",
    stack_size = 50,
    weight = 5*kg,
  },
  {
    type = "recipe",
    name = "ll-heat-shielding",
    category = "crafting",
    energy_required = 20,
    enabled = false,
    ingredients =
    {
      {type="item", name="steel-plate", amount=2},
      {type="item", name="stone-brick", amount=10},
      {type="item", name="plastic-bar", amount=2},
      {type="item", name="ll-silica", amount=5},
    },
    results = {{type="item", name="ll-heat-shielding", amount=1}},
    allow_productivity = true,
  },
  {
    type = "item",
    name = "ll-rocket-part-luna",
    icons = {
      {
        icon = "__base__/graphics/icons/rocket-part.png",
        icon_size = 64,
      },
      {
        icon = "__LunarLandings__/graphics/icons/luna.png",
        icon_size = 64,
        scale = 0.3,
        shift = {6, 6},
        draw_background = true,
      }
    },
    subgroup = "intermediate-product",
    order = "o[rocket-part]-d",
    hidden = true,
    stack_size = 5,
    weight = (1000/50)*kg
  },
  {
    type = "recipe",
    name = "ll-rocket-part-luna",
    energy_required = 3,
    enabled = false,
    hide_from_player_crafting = true,
    category = "rocket-building-nauvis-luna",
    ingredients =
    {
      {type="item", name="ll-heat-shielding", amount=5},
      {type="item", name="low-density-structure", amount=5},
      {type="item", name="rocket-control-unit", amount=5},
      {type = "fluid", name = "steam", amount = 200, temperature = 500}
    },
    results = {{type="item", name="ll-rocket-part-luna", amount=1}}
  },
  {
    type = "item",
    name = "ll-used-rocket-part",
    icon = "__base__/graphics/icons/rocket-part.png",
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "o[rocket-part]-e",
    stack_size = 10,
    weight = (1000/20)*kg
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
      }
    },
    energy_required = 30,
    enabled = false,
    subgroup = "intermediate-product",
    category = "crafting",
    order = "o[rocket-part]-b",
    allow_decomposition = false,
    ingredients =
    {
      {type="item", name="ll-used-rocket-part", amount=1},
      {type="item", name="steel-plate", amount=1},
      {type="item", name="copper-plate", amount=5}
    },
    results = {
      {type = "item", name = "rocket-control-unit", amount_min = 2, amount_max = 4},
      {type = "item", name = "low-density-structure", amount_min = 2, amount_max = 4},
    },
    allow_productivity = true,
  },
  {
    type = "recipe-category",
    name = "rocket-building-nauvis-luna"
  },
}
