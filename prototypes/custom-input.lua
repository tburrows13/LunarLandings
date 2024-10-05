data:extend{
  {
    type = "custom-input",
    name = "ll-toggle-moon-view",
    key_sequence = "N",
    consuming = "none",
    include_selected_prototype = true,
    order = "a"
  },
  {
    type = "shortcut",
    name = "ll-toggle-moon-view",
    localised_name = {"controls.ll-toggle-moon-view"},
    action = "lua",
    associated_control_input = "ll-toggle-moon-view",
    toggleable = true,
    order = "d[lunar-landings]",
    icon = "__LunarLandings__/graphics/icons/moon.png",
    icon_size = 32,
    small_icon = "__LunarLandings__/graphics/icons/moon.png",
    small_icon_size = 32,
  }
}