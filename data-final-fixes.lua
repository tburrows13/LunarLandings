require "__LunarLandings__.prototypes.surface-conditions"
require "__LunarLandings__.prototypes.heat-recipes"

local collision_mask_util = require "__core__.lualib.collision-mask-util"

-- Set tile layer because Alien Biomes overwrites it in data-final-fixes
data.raw.tile["ll-moon"].layer = 10


for _, tech in pairs(data.raw.technology) do
  if tech.unit then
    local ingredients = tech.unit.ingredients
    if data_util.contains_research_ingredient(tech.name, "space-science-pack") then
      if not data_util.contains_research_ingredient(tech.name, "ll-space-science-pack") then
        table.insert(ingredients, {"ll-space-science-pack", 1})
      end
      if not data_util.contains_research_ingredient(tech.name, "ll-quantum-science-pack") then
        table.insert(ingredients, {"ll-quantum-science-pack", 1})
      end

    else
      -- Add to all techs descending from key techs
      if (data_util.is_descendant_of(tech.name, "ll-space-science-pack"))
        --and util.contains_research_ingredient(tech.name, "logistic-science-pack")
        and not data_util.contains_research_ingredient(tech.name, "ll-space-science-pack") then
        table.insert(ingredients, {"ll-space-science-pack", 1})
      end
      if (data_util.is_descendant_of(tech.name, "ll-quantum-science-pack"))
        --and util.contains_research_ingredient(tech.name, "logistic-science-pack")
        and not data_util.contains_research_ingredient(tech.name, "ll-quantum-science-pack") then
        table.insert(ingredients, {"ll-quantum-science-pack", 1})
      end
    end
  end
end