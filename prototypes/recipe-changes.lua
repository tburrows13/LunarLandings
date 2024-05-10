local bzutil = require("__LunarLandings__.bzutil")
local data_util = require("__LunarLandings__.data-util")

bzutil.replace_ingredient("rocket-control-unit", "processing-unit", "advanced-circuit")
data.raw.recipe["satellite"].ingredients =
{
  {"low-density-structure", 50},
  {"solar-panel", 50},
  {"accumulator", 50},
  {"radar", 5},
  {"advanced-circuit", 100},
  {"solid-fuel", 25}
}

bzutil.add_ingredient("processing-unit", "ll-silicon", 5)

bzutil.add_ingredient("production-science-pack", "ll-heat-shielding", 2)

bzutil.replace_ingredient("power-armor-mk2", "processing-unit", "ll-quantum-processor")

local nuclear_fuel = data.raw.recipe["nuclear-fuel"]
if nuclear_fuel then
  nuclear_fuel.crafting_machine_tint = nuclear_fuel.crafting_machine_tint or {}
  nuclear_fuel.crafting_machine_tint.primary    = { r = 0, g = 200, b = 0 }
  nuclear_fuel.crafting_machine_tint.secondary  = { r = 0, g = 200, b = 0 }
  nuclear_fuel.crafting_machine_tint.tertiary   = { r = 0, g = 200, b = 0 }
  nuclear_fuel.crafting_machine_tint.quaternary = { r = 0, g = 200, b = 0 }
end
