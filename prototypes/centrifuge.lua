local centrifuge = data.raw["assembling-machine"]["centrifuge"]

centrifuge.fluid_boxes =
{
  {
    production_type = "input",
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = -1,
    pipe_connections = {{ type="input", position = {0, -2} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "output",
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = 1,
    pipe_connections = {{ type="output", position = {0, 2} }},
    secondary_draw_orders = { north = -1 }
  },
  off_when_no_fluid_recipe = true
}
