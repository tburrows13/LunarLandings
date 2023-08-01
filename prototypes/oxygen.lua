data:extend{
  {
    type = "fluid",
    name = "ll-oxygen",
    default_temperature = 15,
    max_temperature = 1000,
    heat_capacity = "0.2KJ",
    icon = "__LunarLandings__/graphics/fluids/oxygen.png",
    icon_size = 64, icon_mipmaps = 1,
    base_color = {r=0.5, g=0.5, b=0.5},
    flow_color = {r=1.0, g=1.0, b=1.0},
    order = "g[gas]-a[oxygen]",
    --gas_temperature = 15,
    auto_barrel = false
  },

}