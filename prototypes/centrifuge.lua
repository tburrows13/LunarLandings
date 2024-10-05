local centrifuge = data.raw["assembling-machine"]["centrifuge"]

centrifuge.fluid_boxes =
{
  {
    production_type = "input",
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    pipe_connections = {{ flow_direction="input", direction = defines.direction.north, position = {0, -1} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "output",
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    pipe_connections = {{ flow_direction="output", direction = defines.direction.south, position = {0, 1} }},
    secondary_draw_orders = { north = -1 }
  },
}
centrifuge.fluid_boxes_off_when_no_fluid_recipe = true
