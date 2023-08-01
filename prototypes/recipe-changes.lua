local bzutil = require("__LunarLandings__.bzutil")
local data_util = require("__LunarLandings__.data-util")

bzutil.replace_ingredient("rocket-control-unit", "processing-unit", "advanced-circuit")
bzutil.replace_ingredient("rocket-silo", "processing-unit", "advanced-circuit")
bzutil.replace_ingredient("satellite", "processing-unit", "advanced-circuit")

bzutil.add_ingredient("processing-unit", "ll-silicon", 5)