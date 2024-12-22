data.raw["locomotive"]["space-locomotive"].energy_source = {
  type = "burner",
  fuel_inventory_size = 1,
  burnt_inventory_size = 1,
  fuel_categories = {"nuclear"},
}

data.raw["locomotive"]["space-locomotive"].ll_surface_conditions = {nauvis = false, luna = true}
data.raw["cargo-wagon"]["space-cargo-wagon"].ll_surface_conditions = {nauvis = false, luna = true}
data.raw["fluid-wagon"]["space-fluid-wagon"].ll_surface_conditions = {nauvis = false, luna = true}

data:extend{
  {
    type = "recipe",
    name = "ll-moon-rail",
    enabled = false,
    ingredients =
    {
      {type="item", name="stone-brick", amount=1},
      {type="item", name="iron-stick", amount=1},
      {type="item", name="plastic-bar", amount=1},
    },
    results = {{type="item", name="ll-moon-rail", amount=2}},
  },
  {
    type = "rail-planner",
    name = "ll-moon-rail",
    icon = "__space-exploration-graphics__/graphics/icons/space-rail.png",
    icon_size = 64,
    localised_name = {"item-name.ll-moon-rail"},
    subgroup = "train-transport",
    order = "a[rail]-m[moon-rail]",
    place_result = "ll-moon-straight-rail",
    stack_size = 100,
    rails = {
      "ll-moon-straight-rail",
      "ll-moon-curved-rail-a",
      "ll-moon-curved-rail-b",
      "ll-moon-half-diagonal-rail",
    }
  },
}

local function replace_filenames(table, old, new)
  for k, v in pairs(table) do
    if type(v) == "table" then
      replace_filenames(v, old, new)
    elseif type(v) == "string" and k == "filename" then
      local start = v:sub(1, #old)
      if start == old then
        table[k] = new .. v:sub(#old+1)
        log(table[k])
      end
    end
  end
end

local legacy_straight_rail = table.deepcopy(data.raw["legacy-straight-rail"]["legacy-straight-rail"])
legacy_straight_rail.name = "ll-legacy-straight-moon-rail"
legacy_straight_rail.icon = "__space-exploration-graphics__/graphics/icons/space-rail.png"
legacy_straight_rail.icon_size = 64
legacy_straight_rail.minable.result = "ll-moon-rail"
legacy_straight_rail.placeable_by.item = "ll-moon-rail"
legacy_straight_rail.map_color = {r = 255, g = 0, b = 0, a = 0}  -- Seems to be ignored, TODO check in 2.0
legacy_straight_rail.ll_surface_conditions = {nauvis = false, luna = {plain = true, lowland = true, mountain = false, foundation = true}}
--replace_filenames(straight_rail.pictures, "__base__/graphics/entity/straight-rail/hr-", "__space-exploration-graphics__/graphics/entity/space-rail/hr/")
--replace_filenames(straight_rail.pictures, "__base__/graphics/entity/rail-endings/hr-rail-endings-background.png",
--  "__space-exploration-graphics__/graphics/entity/space-rail/hr/rail-endings-background.png")
--replace_filenames(straight_rail.pictures, "__base__/graphics/entity/straight-rail/", "__space-exploration-graphics__/graphics/entity/space-rail/sr/")
--replace_filenames(straight_rail.pictures, "__base__/graphics/entity/rail-endings/rail-endings-background.png",
--  "__space-exploration-graphics__/graphics/entity/space-rail/sr/rail-endings-background.png")

local legacy_curved_rail = table.deepcopy(data.raw["legacy-curved-rail"]["legacy-curved-rail"])
legacy_curved_rail.name = "ll-legacy-curved-moon-rail"
legacy_curved_rail.icon = "__space-exploration-graphics__/graphics/icons/space-rail.png"
legacy_curved_rail.icon_size = 64
legacy_curved_rail.minable.result = "ll-moon-rail"
legacy_curved_rail.placeable_by.item = "ll-moon-rail"
legacy_curved_rail.map_color = {r = 0, g = 0, b = 0}
legacy_curved_rail.ll_surface_conditions = {nauvis = false, luna = {plain = true, lowland = true, mountain = false, foundation = true}}
--replace_filenames(curved_rail.pictures, "__base__/graphics/entity/curved-rail/hr-", "__space-exploration-graphics__/graphics/entity/space-rail/hr/")
--replace_filenames(curved_rail.pictures, "__base__/graphics/entity/rail-endings/hr-rail-endings-background.png",
--  "__space-exploration-graphics__/graphics/entity/space-rail/hr/rail-endings-background.png")
--replace_filenames(curved_rail.pictures, "__base__/graphics/entity/curved-rail/", "__space-exploration-graphics__/graphics/entity/space-rail/sr/")
--replace_filenames(curved_rail.pictures, "__base__/graphics/entity/rail-endings/rail-endings-background.png",
--"__space-exploration-graphics__/graphics/entity/space-rail/sr/rail-endings-background.png")

local straight_rail = table.deepcopy(data.raw["straight-rail"]["straight-rail"])
straight_rail.name = "ll-moon-straight-rail"
straight_rail.icon = "__space-exploration-graphics__/graphics/icons/space-rail.png"
straight_rail.icon_size = 64
straight_rail.minable.result = "ll-moon-rail"
straight_rail.placeable_by.item = "ll-moon-rail"
straight_rail.factoriopedia_alternative = "ll-moon-straight-rail"
straight_rail.ll_surface_conditions = {nauvis = false, luna = {plain = true, lowland = true, mountain = false, foundation = true}}

local half_diagonal_rail = table.deepcopy(data.raw["half-diagonal-rail"]["half-diagonal-rail"])
half_diagonal_rail.name = "ll-moon-half-diagonal-rail"
half_diagonal_rail.icon = "__space-exploration-graphics__/graphics/icons/space-rail.png"
half_diagonal_rail.icon_size = 64
half_diagonal_rail.minable.result = "ll-moon-rail"
half_diagonal_rail.placeable_by.item = "ll-moon-rail"
half_diagonal_rail.factoriopedia_alternative = "ll-moon-half-diagonal-rail"
half_diagonal_rail.ll_surface_conditions = {nauvis = false, luna = {plain = true, lowland = true, mountain = false, foundation = true}}

local curved_rail_a = table.deepcopy(data.raw["curved-rail-a"]["curved-rail-a"])
curved_rail_a.name = "ll-moon-curved-rail-a"
curved_rail_a.icon = "__space-exploration-graphics__/graphics/icons/space-rail.png"
curved_rail_a.icon_size = 64
curved_rail_a.minable.result = "ll-moon-rail"
curved_rail_a.placeable_by.item = "ll-moon-rail"
curved_rail_a.factoriopedia_alternative = "ll-moon-curved-rail-a"
curved_rail_a.ll_surface_conditions = {nauvis = false, luna = {plain = true, lowland = true, mountain = false, foundation = true}}

local curved_rail_b = table.deepcopy(data.raw["curved-rail-b"]["curved-rail-b"])
curved_rail_b.name = "ll-moon-curved-rail-b"
curved_rail_b.icon = "__space-exploration-graphics__/graphics/icons/space-rail.png"
curved_rail_b.icon_size = 64
curved_rail_b.minable.result = "ll-moon-rail"
curved_rail_b.placeable_by.item = "ll-moon-rail"
curved_rail_b.factoriopedia_alternative = "ll-moon-curved-rail-b"
curved_rail_b.ll_surface_conditions = {nauvis = false, luna = {plain = true, lowland = true, mountain = false, foundation = true}}

data:extend{legacy_straight_rail, legacy_curved_rail, straight_rail, half_diagonal_rail, curved_rail_a, curved_rail_b}