data:extend{
  {
    type = "radar",
    name = "ll-hidden-radar",
    icon = "__base__/graphics/icons/radar.png",
    icon_size = 64,
    max_health = 250,
    collision_mask = {layers={}},
    energy_per_sector = "10MJ",
    max_distance_of_sector_revealed = 0,
    max_distance_of_nearby_sector_revealed = 1,
    energy_per_nearby_scan = "1000kJ",
    energy_source =
    {
      type = "void",
    },
    energy_usage = "300kW",
    rotation_speed = 0.01,
  },

}