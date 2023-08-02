local moon_rock = table.deepcopy(data.raw.resource["stone"])

moon_rock.name = "ll-moon-rock"
moon_rock.minable.result = "ll-moon-rock"

moon_rock.icon = "__LunarLandings__/graphics/icons/moon-rock.png"
moon_rock.stages.sheet.filename = "__LunarLandings__/graphics/moon-rock/moon-rock.png"
moon_rock.stages.sheet.hr_version.filename = "__LunarLandings__/graphics/moon-rock/hr-moon-rock.png"

moon_rock.map_color = {r=0.8, g=0.8, b=0.8}

moon_rock.selection_priority = 49

data:extend{
  moon_rock,
  {
    type = "item",
    name = "ll-moon-rock",
    icon = "__LunarLandings__/graphics/icons/moon-rock.png",
    icon_size = 64,
    icon_mipmaps = 4,
    pictures =
    {
      { size = 64, filename = "__LunarLandings__/graphics/icons/moon-rock.png",   scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/moon-rock-1.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/moon-rock-2.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__LunarLandings__/graphics/icons/moon-rock-3.png", scale = 0.25, mipmap_count = 4 }
    },
    subgroup = "raw-resource",
    order = "d[stone]",
    stack_size = 50
  },
  {
    type = "recipe",
    name = "ll-moon-rock-processing-with-oxygen-helium",
    category = "ll-electric-smelting",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type="item", name="ll-moon-rock", amount=10},
    },
    results=
    {
      {type="item", name="ll-silica", amount=5},
      {type="item", name="stone", amount=5},
      {type="fluid", name="ll-oxygen", amount=50, fluidbox_index = 1},
      {type="fluid", name="ll-helium-3", amount=50, fluidbox_index = 3},
    },
    icon = "__LunarLandings__/graphics/icons/moon-rock.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "a[oil-processing]-b[advanced-oil-processing]"
  },
  {
    type = "recipe",
    name = "ll-moon-rock-processing-with-helium",
    category = "ll-electric-smelting",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type="item", name="ll-moon-rock", amount=10},
    },
    results=
    {
      {type="item", name="ll-silica", amount=5},
      {type="item", name="stone", amount=5},
      {type="fluid", name="ll-helium-3", amount=50, fluidbox_index = 3},
    },
    icon = "__LunarLandings__/graphics/icons/moon-rock.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "a[oil-processing]-b[advanced-oil-processing]"
  },
  {
    type = "recipe",
    name = "ll-moon-rock-processing-with-oxygen",
    category = "ll-electric-smelting",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type="item", name="ll-moon-rock", amount=10},
    },
    results=
    {
      {type="item", name="ll-silica", amount=5},
      {type="item", name="stone", amount=5},
      {type="fluid", name="ll-oxygen", amount=50, fluidbox_index = 1},
    },
    icon = "__LunarLandings__/graphics/icons/moon-rock.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "a[oil-processing]-b[advanced-oil-processing]"
  },

  {
    type = "recipe",
    name = "ll-moon-rock-processing",
    category = "ll-electric-smelting",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type="item", name="ll-moon-rock", amount=10},
    },
    results=
    {
      {type="item", name="ll-silica", amount=5},
      {type="item", name="stone", amount=5},
    },
    icon = "__LunarLandings__/graphics/icons/moon-rock.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "a[oil-processing]-b[advanced-oil-processing]"
  },
}

data_util.allow_productivity("ll-moon-rock-processing-with-oxygen-helium")
data_util.allow_productivity("ll-moon-rock-processing-with-oxygen")
data_util.allow_productivity("ll-moon-rock-processing-with-helium")
data_util.allow_productivity("ll-moon-rock-processing")


-- Autoplace

local resource_autoplace = require("resource-autoplace")
resource_autoplace.initialize_patch_set("ll-moon-rock", false)
moon_rock.autoplace = resource_autoplace.resource_autoplace_settings
{
  name = "ll-moon-rock",
  order = "b",
  base_density = 4,
  has_starting_area_placement = nil,
  regular_rq_factor_multiplier = 1.0,
  starting_rq_factor_multiplier = 1.1,
}
