local heat_recipes = {}

-- Add heat to arc smelting recipes and make alternate recipes with heat for other smelting recipes
for name, recipe in pairs(data.raw.recipe) do
  if recipe.category == "ll-arc-smelting" and name:sub(-5, -1) ~= "-heat" then
    table.insert(recipe.results, {type = "fluid", name = "ll-heat", amount = recipe.energy_required, fluidbox_index = 2})
    table.insert(heat_recipes, name)
  elseif recipe.category == "smelting" or recipe.category == "ll-fluid-smelting" or recipe.category == "ll-electric-smelting" and recipe.name:sub(-5, -1) ~= "-heat" then
    local heat_recipe = table.deepcopy(recipe)
    heat_recipe.name = name .. "-heat"
    heat_recipe.category = "ll-arc-smelting"
    heat_recipe.localised_name = recipe.localised_name or {"?", {"item-name." .. name}, {"recipe-name." .. name}}
    heat_recipe.localised_description = recipe.localised_description or {"?", {"item-description." .. name}, {"?", {"recipe-description." .. name}, ""}}

    heat_recipe.enabled = true
    heat_recipe.hide_from_player_crafting = true
    heat_recipe.hidden_in_factoriopedia = true

    -- Doesn't account for fluids
    -- TODO 2.0 order should be doable now
    --heat_recipe.order = tostring(recipe.order or data.raw["item"][heat_recipe.result or heat_recipe.results[1][1]].order) .. "-heat"

    if not heat_recipe.main_product and #heat_recipe.results == 1 then
      heat_recipe.main_product = heat_recipe.results[1].name
    end
    if heat_recipe.results then
      -- Every second, arc furnace consumes 10MJ, of which 9MJ needs to be output in heat
      -- 1 heat = 1MJ
      -- Arc furnace has crafting speed 3 and base productity +50%
      -- So each second, needs to output 9 heat / 3 / 1.5 = 2
      table.insert(heat_recipe.results, {type = "fluid", name = "ll-heat", amount = 2*(heat_recipe.energy_required or 0.5), fluidbox_index = 2})
      data:extend{heat_recipe}
    end

    heat_recipe.allow_efficiency = false
    table.insert(heat_recipes, heat_recipe.name)
  end
end
local efficiency_modules = {"efficiency-module", "efficiency-module-2", "efficiency-module-3"}
for _, module_name in pairs(efficiency_modules) do
  data.raw.module[module_name].limitation_message_key = "efficiency-module-not-usable-on-heat-recipes"
end
