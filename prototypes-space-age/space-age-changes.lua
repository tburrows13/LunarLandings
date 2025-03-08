data.raw.item["ll-quantum-processor"].localised_name = {"item-name.ll-quantum-circuit"}
x_util.add_ingredient("quantum-processor", "ll-quantum-processor", 1)

table.insert(data.raw.lab.biolab.inputs, 7, "ll-space-science-pack")
table.insert(data.raw.lab.biolab.inputs, 8, "ll-quantum-science-pack")

data.raw.recipe["processing-unit"].icon = nil
data.raw.recipe["processing-unit"].icons = {
  {icon = "__base__/graphics/icons/processing-unit.png", icon_size = 64},
  {icon = "__LunarLandings__/graphics/icons/silicon.png", icon_size = 64, scale = 0.3, shift = {-6, -6}, draw_background = true},
}
x_util.set_ingredient("processing-unit", "electronic-circuit", 6)
data:extend{
  {
    type = "recipe",
    name = "ll-processing-unit-without-silicon",
    localised_name = {"item-name.processing-unit"},
    category = "crafting-with-fluid",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type = "item", name = "electronic-circuit", amount = 20},
      {type = "item", name = "advanced-circuit", amount = 2},
      {type = "fluid", name = "sulfuric-acid", amount = 5}
    },
    results = {{type="item", name="processing-unit", amount=1}},
    order = "b[circuits]-c[processing-unit]-a",
    allow_productivity = true
  },
}