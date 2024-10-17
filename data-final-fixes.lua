--require "__LunarLandings__.prototypes.surface-conditions"
require "__LunarLandings__.prototypes.heat-recipes"

for type, _ in pairs(defines.prototypes.item) do
  for _, item in pairs(data.raw[type] or {}) do
    item.send_to_orbit_mode = "manual"
  end
end

-- Set tile layer because Alien Biomes overwrites it in data-final-fixes
data.raw.tile["ll-luna-plain"].layer = 10
data.raw.tile["ll-luna-lowland"].layer = 9
data.raw.tile["ll-luna-mountain"].layer = 11

--[[
data.raw.tile["ll-luna-plain"].pollution_absorption_per_second = 1
data.raw.tile["ll-luna-lowland"].pollution_absorption_per_second = 1
data.raw.tile["ll-luna-mountain"].pollution_absorption_per_second = 1
data.raw.tile["ll-lunar-foundation"].pollution_absorption_per_second = 1
]]

do return end  -- TODO 2.0
for _, tech in pairs(data.raw.technology) do
  if tech.unit then
    local ingredients = tech.unit.ingredients
    if x_util.contains_research_ingredient(tech.name, "space-science-pack") then
      if not x_util.contains_research_ingredient(tech.name, "ll-space-science-pack") then
        table.insert(ingredients, {"ll-space-science-pack", 1})
      end
      if not x_util.contains_research_ingredient(tech.name, "ll-quantum-science-pack") then
        table.insert(ingredients, {"ll-quantum-science-pack", 1})
      end

    else
      -- Add to all techs descending from key techs
      if (x_util.is_descendant_of(tech.name, "ll-space-science-pack"))
        --and util.contains_research_ingredient(tech.name, "logistic-science-pack")
        and not x_util.contains_research_ingredient(tech.name, "ll-space-science-pack") then
        table.insert(ingredients, {"ll-space-science-pack", 1})
      end
      if (x_util.is_descendant_of(tech.name, "ll-quantum-science-pack"))
        --and util.contains_research_ingredient(tech.name, "logistic-science-pack")
        and not x_util.contains_research_ingredient(tech.name, "ll-quantum-science-pack") then
        table.insert(ingredients, {"ll-quantum-science-pack", 1})
      end
    end
  end
end