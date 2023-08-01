-- Unused

local corpse_blacklist = {
  ["companion"] = true,
  ["defender-unit"] = true,
  ["destroyer-unit"] = true,
  ["spider-baby"] = true,  -- Broodmother
}

for _, spidertron in pairs({"sp-spiderling", "spidertron"}) do
  data:extend{
    {
      type = "recipe",
      name = "ll-spider-capsule-" .. spidertron,
      --category = "crafting",
      enabled = true,
      energy_required = 5,
      ingredients =
      {
        {type="item", name=spidertron, amount=10},
        {type="item", name="construction-robot", amount=10},
        {type="item", name="personal-roboport"},
      },
      results=
      {
        {type="item", name="ll-silica", amount=5},
        {type="item", name="stone", amount=5},
      },
      icon = "__base__/graphics/icons/stone.png",
      icon_size = 64, icon_mipmaps = 4,
      subgroup = "raw-material",
      order = "a[oil-processing]-b[advanced-oil-processing]"
    },
  
  }
end