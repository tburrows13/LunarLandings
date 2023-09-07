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
  {"rocket-fuel", 25}
}

bzutil.add_ingredient("processing-unit", "ll-silicon", 5)

bzutil.add_ingredient("production-science-pack", "ll-heat-shielding", 2)

bzutil.replace_ingredient("power-armor-mk2", "processing-unit", "ll-quantum-processor")