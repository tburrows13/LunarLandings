data.raw["locomotive"]["space-locomotive"].burner = {
  type = "burner",
  fuel_inventory_size = 1,
  burnt_inventory_size = 1,
  fuel_category = "nuclear",
}

data:extend{
  {
    type = "recipe",
    name = "ll-moon-rail",
    enabled = false,
    ingredients =
    {
      {"stone-brick", 1},
      {"iron-stick", 1},
      {"plastic-bar", 1},
    },
    result = "ll-moon-rail",
    result_count = 2
  },
  {
    type = "rail-planner",
    name = "ll-moon-rail",
    icon = "__space-exploration-graphics__/graphics/icons/space-rail.png",
    icon_size = 64, icon_mipmaps = 1,
    localised_name = {"item-name.ll-moon-rail"},
    subgroup = "train-transport",
    order = "a[train-system]-b[moon-rail]",
    place_result = "ll-straight-moon-rail",
    stack_size = 100,
    straight_rail = "ll-straight-moon-rail",
    curved_rail = "ll-curved-moon-rail"
  },
}

function literalize(str)
  return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")
end

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

local straight_rail = table.deepcopy(data.raw["straight-rail"]["straight-rail"])
straight_rail.name = "ll-straight-moon-rail"
straight_rail.icon = "__space-exploration-graphics__/graphics/icons/space-rail.png"
straight_rail.icon_size = 64
straight_rail.icon_mipmaps = 1
straight_rail.minable.result = "ll-moon-rail"
--straight_rail.placeable_by.item = "ll-moon-rail"
-- TODO check fast_replaceable_group, next_upgrade
--log(serpent.block(straight_rail.pictures))
replace_filenames(straight_rail.pictures, "__base__/graphics/entity/straight-rail/hr-", "__space-exploration-graphics__/graphics/entity/space-rail/hr/")
replace_filenames(straight_rail.pictures, "__base__/graphics/entity/rail-endings/hr-rail-endings-background.png",
  "__space-exploration-graphics__/graphics/entity/space-rail/hr/rail-endings-background.png")
replace_filenames(straight_rail.pictures, "__base__/graphics/entity/straight-rail/", "__space-exploration-graphics__/graphics/entity/space-rail/sr/")
replace_filenames(straight_rail.pictures, "__base__/graphics/entity/rail-endings/rail-endings-background.png",
  "__space-exploration-graphics__/graphics/entity/space-rail/sr/rail-endings-background.png")

local curved_rail = table.deepcopy(data.raw["curved-rail"]["curved-rail"])
curved_rail.name = "ll-curved-moon-rail"
curved_rail.icon = "__space-exploration-graphics__/graphics/icons/space-rail.png"
curved_rail.icon_size = 64
curved_rail.icon_mipmaps = 1
curved_rail.minable.result = "ll-moon-rail"
curved_rail.placeable_by.item = "ll-moon-rail"
replace_filenames(curved_rail.pictures, "__base__/graphics/entity/curved-rail/hr-", "__space-exploration-graphics__/graphics/entity/space-rail/hr/")
replace_filenames(curved_rail.pictures, "__base__/graphics/entity/rail-endings/hr-rail-endings-background.png",
  "__space-exploration-graphics__/graphics/entity/space-rail/hr/rail-endings-background.png")
  replace_filenames(curved_rail.pictures, "__base__/graphics/entity/curved-rail/", "__space-exploration-graphics__/graphics/entity/space-rail/sr/")
  replace_filenames(curved_rail.pictures, "__base__/graphics/entity/rail-endings/rail-endings-background.png",
  "__space-exploration-graphics__/graphics/entity/space-rail/sr/rail-endings-background.png")

data:extend{straight_rail, curved_rail}