local rocket_part_recipe = data.raw.recipe["rocket-part"]
local rocket_part_item = data.raw.item["rocket-part"]
if SPACE_AGE then
  rocket_part_recipe = table.deepcopy(rocket_part_recipe)
  rocket_part_recipe.name = "ll-rocket-part-up"
  rocket_part_recipe.category = "rocket-building-nauvis-to-luna"
  rocket_part_recipe.results = {{type="item", name="ll-rocket-part-up", amount=1}}

  rocket_part_item = table.deepcopy(rocket_part_item)
  rocket_part_item.name = "ll-rocket-part-up"

  data:extend{rocket_part_recipe, rocket_part_item}
end

rocket_part_recipe.ingredients = {
  {type="item", name="rocket-control-unit", amount=10},
  {type="item", name="low-density-structure", amount=10},
  {type="item", name="rocket-fuel", amount=5},
}
rocket_part_recipe.allow_productivity = false

rocket_part_item.localised_name = {"item-name.ll-rocket-part-up"}
rocket_part_item.order = "o[rocket-part]-b"

data:extend{
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
    energy_required = 30,
    enabled = false,
    category = "circuit-crafting",
    ingredients =
    {
      {type="item", name="advanced-circuit", amount=1},
      {type="item", name="speed-module", amount=1},
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
    name = "ll-rocket-part-down",
    icon = "__base__/graphics/icons/rocket-part.png",
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "o[rocket-part]-c",
    hidden = true,
    stack_size = 5,
    weight = (1000/50)*kg
  },
  {
    type = "recipe",
    name = "ll-rocket-part-down",
    energy_required = 3,
    enabled = false,
    hide_from_player_crafting = true,
    category = "rocket-building",
    ingredients =
    {
      {type="item", name="ll-heat-shielding", amount=10},
      {type="item", name="low-density-structure", amount=10},
      {type="item", name="rocket-control-unit", amount=10},
      {type = "fluid", name = "steam", amount = 100, temperature = 500}
    },
    results = {{type="item", name="ll-rocket-part-down", amount=1}}
  },
  {
    type = "item",
    name = "ll-used-rocket-part",
    icon = "__base__/graphics/icons/rocket-part.png",
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "o[rocket-part]-e",
    stack_size = 1,
    weight = (1000/50)*kg
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
    energy_required = 60,
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
      {type = "item", name = "rocket-control-unit", amount_min = 5, amount_max = 8},
      {type = "item", name = "low-density-structure", amount_min = 5, amount_max = 8},
    },
    allow_productivity = true,
  },
  {
    type = "recipe-category",
    name = "rocket-building-luna"
  },
}

if SPACE_AGE then
  data:extend{
    {
      type = "recipe-category",
      name = "rocket-building-nauvis-to-luna"
    }
  }
end