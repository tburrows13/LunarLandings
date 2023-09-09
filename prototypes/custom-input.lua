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
    icon =
    {
      filename = "__LunarLandings__/graphics/icons/moon.png",
      size = 32,
      flags = {"gui-icon"}
    },
    --[[small_icon = {
      filename = "__SpidertronEnhancements__/graphics/follow-shortcut-24.png",
      size = 24,
      flags = {"gui-icon"}
    },
    disabled_icon = {
      filename = "__SpidertronEnhancements__/graphics/follow-shortcut-white.png",
      size = 32,
      flags = {"gui-icon"}
    },
    disabled_small_icon =
    {
      filename = "__SpidertronEnhancements__/graphics/follow-shortcut-white-24.png",
      size = 24,
      flags = {"gui-icon"}
    }]]
  }
  
}