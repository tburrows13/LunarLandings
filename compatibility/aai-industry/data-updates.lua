if not mods["aai-industry"] then return end

data.raw["assembling-machine"]["burner-assembling-machine"].surface_conditions = {nauvis = true, luna = {plain = false, lowland = false, mountain = false, foundation = true}}

local furnace = data.raw["assembling-machine"]["industrial-furnace"]
table.insert(furnace.crafting_categories, "ll-fluid-smelting")
table.insert(furnace.crafting_categories, "ll-electric-smelting")
