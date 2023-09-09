-- Add heat to arc smelting recipes and make alternate recipes with heat for other smelting recipes
for _, recipe in pairs(data.raw.recipe) do
  if recipe.category == "ll-arc-smelting" and recipe.name:sub(-5, -1) ~= "-heat" then
    table.insert(recipe.results, {type = "fluid", name = "ll-heat", amount = recipe.energy_required, fluidbox_index = 2})
  elseif recipe.category == "smelting" or recipe.category == "ll-electric-smelting" and recipe.name:sub(-5, -1) ~= "-heat" then
    log(recipe.name)
    --log(serpent.block(recipe))
    local heat_recipe = table.deepcopy(recipe)
    heat_recipe.name = recipe.name .. "-heat"
    heat_recipe.category = "ll-arc-smelting"
    heat_recipe.localised_name = recipe.localised_name or {"?", {"item-name." .. recipe.name}, {"recipe-name." .. recipe.name}}
    heat_recipe.localised_description = recipe.localised_description or {"?", {"item-description." .. recipe.name}, {"?", {"recipe-description." .. recipe.name}, ""}}

    -- Remove normal/expensive
    if heat_recipe.normal then
      for key, value in pairs(heat_recipe.normal) do
        heat_recipe[key] = value
      end
      heat_recipe.normal = nil
      heat_recipe.expensive = nil
    end
    heat_recipe.enabled = true
    heat_recipe.hide_from_player_crafting = true

    if heat_recipe.result and not heat_recipe.results then
      heat_recipe.results = {{type = "item", name = heat_recipe.result, amount = heat_recipe.result_count or 1}}
      heat_recipe.result = nil
      heat_recipe.result_count = nil
    end
    if not heat_recipe.main_product and #heat_recipe.results == 1 then
      heat_recipe.main_product = heat_recipe.results[1].name or heat_recipe.results[1][1]
    end
    if heat_recipe.results then
      table.insert(heat_recipe.results, {type = "fluid", name = "ll-heat", amount = heat_recipe.energy_required or 0.5, fluidbox_index = 2})
      data:extend{heat_recipe}
      data_util.allow_productivity(heat_recipe.name)
    end
  end
end