local presets = data.raw["map-gen-presets"]["default"]

if mods["alien-biomes"] then
  presets["ll-earth-like"] = {
    order = "a",
    basic_settings = {
      autoplace_controls = {
        -- Nauvis climate
        hot = {size = 0.5},
        cold = {size = 0.5},
      },
      property_expression_names = {
        -- More Nauvis climate
        ["control-setting:moisture:bias"] = 0.05,
        ["control-setting:aux:bias"] = -0.35
      },
    },
  }
end