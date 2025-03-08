--[[

___________   _______________________________________^__
 ___   ___ |||  ___   ___   ___    ___ ___  |   __  ,----\
|   | |   |||| |   | |   | |   |  |   |   | |  |  | |_____\
|___| |___|||| |___| |___| |___|  | O | O | |  |  |        \
           |||                    |___|___| |  |__|         )
___________|||______________________________|______________/
           |||                                        /--------
-----------'''---------------------------------------'

"nyoom" - the train

--]]


if not mods["elevated-rails"] then return end

local function moon_only_surface_conditions()
  return {{
    property = "gravity",
    min = 1.5,
    max = 1.5,
  }}
end

local moon_rails = data.raw["rail-planner"]["ll-moon-rail"].rails
table.insert(moon_rails, "ll-moon-rail-ramp")
table.insert(moon_rails, "ll-moon-elevated-straight-rail")
table.insert(moon_rails, "ll-moon-elevated-curved-rail-a")
table.insert(moon_rails, "ll-moon-elevated-curved-rail-b")
table.insert(moon_rails, "ll-moon-elevated-half-diagonal-rail")

data.raw["rail-planner"]["ll-moon-rail"].support = "ll-moon-rail-support"

data:extend {{
  type = "recipe",
  name = "ll-moon-rail-ramp",
  enabled = false,
  ingredients = {
    {type = "item", name = "ll-moon-rail", amount = 8},
    {type = "item", name = "plastic-bar",  amount = 10},
    {type = "item", name = "refined-concrete", amount = 100},
  },
  results = {{type = "item", name = "ll-moon-rail-ramp", amount = 1}},
  auto_recycle = true,
  allow_decomposition = true,
  allow_productivity = false,
}}

local moon_rail_ramp_item = table.deepcopy(data.raw["rail-planner"]["rail-ramp"])
moon_rail_ramp_item.name = "ll-moon-rail-ramp"
moon_rail_ramp_item.rails = moon_rails
moon_rail_ramp_item.localised_name = {"item-name.ll-moon-rail-ramp"}
moon_rail_ramp_item.icons = {
  {icon = moon_rail_ramp_item.icon, tint = {0.5, 0.5, 0.5, 1}, icon_size = 64},
}
moon_rail_ramp_item.icon = nil
moon_rail_ramp_item.icon_size = nil
moon_rail_ramp_item.place_result = "ll-moon-rail-ramp"
moon_rail_ramp_item.order = "a[rail]-ma[moon-rail-ramp]"
moon_rail_ramp_item.support = "ll-moon-rail-support"
data:extend {moon_rail_ramp_item}

data:extend {{
  type = "recipe",
  name = "ll-moon-rail-support",
  enabled = false,
  ingredients = {
    {type = "item", name = "plastic-bar",      amount = 10},
    {type = "item", name = "refined-concrete", amount = 20},
  },
  results = {{type = "item", name = "ll-moon-rail-support", amount = 1}},
  auto_recycle = true,
  allow_decomposition = true,
  allow_productivity = false,
}}

local moon_rail_support_item = table.deepcopy(data.raw["item"]["rail-support"])
moon_rail_support_item.name = "ll-moon-rail-support"
moon_rail_support_item.localised_name = {"item-name.ll-moon-rail-support"}
moon_rail_support_item.icons = {
  {icon = moon_rail_support_item.icon, tint = {0.5, 0.5, 0.5, 1}, icon_size = 64},
}
moon_rail_support_item.icon = nil
moon_rail_support_item.icon_size = nil
moon_rail_support_item.place_result = "ll-moon-rail-support"
moon_rail_support_item.order = "a[rail]-mb[moon-rail-support]"
data:extend {moon_rail_support_item}

local elevated_straight_rail = table.deepcopy(data.raw["elevated-straight-rail"]["elevated-straight-rail"])
elevated_straight_rail.name = "ll-moon-elevated-straight-rail"
--elevated_straight_rail.icon = "__space-exploration-graphics__/graphics/icons/elevated-sspace-rail.png"
--elevated_straight_rail.icon_size = 64
elevated_straight_rail.minable.result = "ll-moon-rail"
elevated_straight_rail.placeable_by.item = "ll-moon-rail"
elevated_straight_rail.factoriopedia_alternative = "ll-moon-straight-rail"
elevated_straight_rail.surface_conditions = moon_only_surface_conditions()
elevated_straight_rail.ll_surface_conditions = {nauvis = false, luna = {plain = true, lowland = true, mountain = true, foundation = true}}

local half_diagonal_rail = table.deepcopy(data.raw["elevated-half-diagonal-rail"]["elevated-half-diagonal-rail"])
half_diagonal_rail.name = "ll-moon-elevated-half-diagonal-rail"
--half_diagonal_rail.icon = "__space-exploration-graphics__/graphics/icons/elevated-space-rail.png"
--half_diagonal_rail.icon_size = 64
half_diagonal_rail.minable.result = "ll-moon-rail"
half_diagonal_rail.placeable_by.item = "ll-moon-rail"
half_diagonal_rail.factoriopedia_alternative = "ll-moon-half-diagonal-rail"
half_diagonal_rail.surface_conditions = moon_only_surface_conditions()
half_diagonal_rail.ll_surface_conditions = {nauvis = false, luna = {plain = true, lowland = true, mountain = true, foundation = true}}

local elevated_curved_rail_a = table.deepcopy(data.raw["elevated-curved-rail-a"]["elevated-curved-rail-a"])
elevated_curved_rail_a.name = "ll-moon-elevated-curved-rail-a"
--elevated_curved_rail_a.icon = "__space-exploration-graphics__/graphics/icons/elevated-space-rail.png"
--elevated_curved_rail_a.icon_size = 64
elevated_curved_rail_a.minable.result = "ll-moon-rail"
elevated_curved_rail_a.placeable_by.item = "ll-moon-rail"
elevated_curved_rail_a.factoriopedia_alternative = "ll-moon-curved-rail-a"
elevated_curved_rail_a.surface_conditions = moon_only_surface_conditions()
elevated_curved_rail_a.ll_surface_conditions = {nauvis = false, luna = {plain = true, lowland = true, mountain = true, foundation = true}}

local elevated_curved_rail_b = table.deepcopy(data.raw["elevated-curved-rail-b"]["elevated-curved-rail-b"])
elevated_curved_rail_b.name = "ll-moon-elevated-curved-rail-b"
--elevated_curved_rail_b.icon = "__space-exploration-graphics__/graphics/icons/elevated-space-rail.png"
--elevated_curved_rail_b.icon_size = 64
elevated_curved_rail_b.minable.result = "ll-moon-rail"
elevated_curved_rail_b.placeable_by.item = "ll-moon-rail"
elevated_curved_rail_b.factoriopedia_alternative = "ll-moon-curved-rail-b"
elevated_curved_rail_b.surface_conditions = moon_only_surface_conditions()
elevated_curved_rail_b.ll_surface_conditions = {nauvis = false, luna = {plain = true, lowland = true, mountain = true, foundation = true}}

local rail_ramp = table.deepcopy(data.raw["rail-ramp"]["rail-ramp"])
rail_ramp.name = "ll-moon-rail-ramp"
--rail_ramp.icon = "__space-exploration-graphics__/graphics/icons/elevated-space-rail-ramp.png"
--rail_ramp.icon_size = 64
rail_ramp.minable.result = "ll-moon-rail-ramp"
rail_ramp.support_range = rail_ramp.support_range * 2
rail_ramp.factoriopedia_alternative = "ll-moon-rail-ramp"
rail_ramp.surface_conditions = moon_only_surface_conditions()
rail_ramp.ll_surface_conditions = {nauvis = false, luna = {plain = true, lowland = true, mountain = false, foundation = true}}

local rail_support = table.deepcopy(data.raw["rail-support"]["rail-support"])
rail_support.name = "ll-moon-rail-support"
--rail_support.icon = "__space-exploration-graphics__/graphics/icons/elevated-space-rail-support.png"
--rail_support.icon_size = 64
rail_support.minable.result = "ll-moon-rail-support"
rail_support.factoriopedia_alternative = "ll-moon-rail-support"
rail_support.support_range = rail_support.support_range * 2
rail_support.collision_mask_allow_on_deep_oil_ocean = nil
rail_support.surface_conditions = moon_only_surface_conditions()
rail_support.ll_surface_conditions = {nauvis = false, luna = {plain = true, lowland = true, mountain = true, foundation = true}}

data:extend {rail_ramp, rail_support, elevated_straight_rail, half_diagonal_rail, elevated_curved_rail_a, elevated_curved_rail_b}

data.raw["elevated-straight-rail"]["elevated-straight-rail"].ll_surface_conditions = {nauvis = true, luna = false}
data.raw["elevated-half-diagonal-rail"]["elevated-half-diagonal-rail"].ll_surface_conditions = {nauvis = true, luna = false}
data.raw["elevated-curved-rail-a"]["elevated-curved-rail-a"].ll_surface_conditions = {nauvis = true, luna = false}
data.raw["elevated-curved-rail-b"]["elevated-curved-rail-b"].ll_surface_conditions = {nauvis = true, luna = false}
data.raw["rail-ramp"]["rail-ramp"].ll_surface_conditions = {nauvis = true, luna = false}
data.raw["rail-support"]["rail-support"].ll_surface_conditions = {nauvis = true, luna = false}
