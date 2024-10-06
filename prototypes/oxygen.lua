data:extend{
  {
    type = "fluid",
    name = "ll-oxygen",
    subgroup = "fluid",
    default_temperature = 15,
    max_temperature = 1000,
    heat_capacity = "0.2kJ",
    icon = "__LunarLandings__/graphics/fluid/oxygen.png",
    icon_size = 64,
    base_color = {r = 200, g = 200, b = 200},
    flow_color = {r = 200, g = 200, b = 200},
    order = "i[gas]-a[oxygen]",
    --gas_temperature = 15,
    auto_barrel = false
  },

}