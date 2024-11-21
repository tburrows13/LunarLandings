local effects = require("__core__/lualib/surface-render-parameter-effects")

local planet_map_gen = {}

planet_map_gen.luna = function()
  return
  {
    terrain_segmentation = 1,
    water = 1,
    property_expression_names =
    { -- Warning: anything set here overrides any selections made in the map setup screen so the options do nothing.
      --cliff_elevation = "cliff_elevation_nauvis",
      --cliffiness = "cliffiness_nauvis",
      --elevation = "elevation_island"
      elevation = "ll-luna-elevation",
    },
    cliff_settings =
    {
      name = "cliff",
      cliff_smoothing = 0
    },
    autoplace_controls = {
      ["ll-moon-rock"] = {},
      ["ll-rich-moon-rock"] = {},
      ["ll-ice"] = {},
      ["ll-astrocrystals"] = {},
    },
    autoplace_settings = {
      decorative = { treat_missing_as_default = false, settings = {
        --[[["ll-moon-crater1-large"] = {}},
        ["ll-moon-crater1-large-rare"] = {},
        ["ll-moon-crater2-medium"] = {},
        ["ll-moon-crater3-huge"] = {},
        ["ll-moon-crater4-small"] = {},
        ["ll-moon-stone-decal-white"] = {},
        ["ll-moon-sand-decal-white"] = {},
        ["ll-moon-rock-medium"] = {},
        ["ll-moon-rock-small"] = {},
        ["ll-moon-rock-tiny"] = {},
        ["ll-moon-sand-rock-medium"] = {},
        ["ll-moon-sand-rock-small"] = {},]]
      }},
      entity = { treat_missing_as_default = false, settings = {
        ["ll-moon-rock"] = {},
        ["ll-rich-moon-rock"] = {},
        ["ll-ice"] = {},
        ["ll-astrocrystals"] = {},
        --[[["ll-moon-rock-huge"] = {},
        ["ll-moon-rock-big"] = {},
        ["ll-moon-sand-rock-big"] = {},]]
      }},
      tile = { treat_missing_as_default = false, settings = {
        ["ll-luna-plain"] = {},
        ["ll-luna-lowland"] = {},
        ["ll-luna-mountain"] = {},
      }},
    },
  }
end


data:extend(
{
  {
    type = "surface-property",
    name = "ll-atmospheric-oxygen",
    default_value = 100
  },
  {
    type = "planet",
    name = "luna",
    icon = "__LunarLandings__/graphics/icons/luna.png",
    starmap_icon = "__LunarLandings__/graphics/icons/luna-large.png",
    starmap_icon_size = 500,
    gravity_pull = 10,
    distance = 15,
    orientation = 0.275+0.015,
    magnitude = 0.7,
    draw_orbit = false,
    order = "a[nauvis]-b[luna]",
    --subgroup = "planets",
    map_gen_settings = planet_map_gen.luna(),
    pollutant_type = nil,
    solar_power_in_space = 300,
    planet_procession_set =
    {
      arrival = {"default-b"},
      departure = {"default-rocket-a"}
    },
    surface_properties =
    {
      ["day-night-cycle"] = 60 * minute,
      pressure = 100,
      gravity = 1.5,
      ["ll-atmospheric-oxygen"] = 0,
      ["solar-power"] = 125,
    },
    surface_render_parameters =
    {
      clouds = effects.default_clouds_effect_properties()
    },
    persistent_ambient_sounds =
    {
      base_ambience = { filename = "__base__/sound/world/world_base_wind.ogg", volume = 0.3 },
      wind = { filename = "__base__/sound/wind/wind.ogg", volume = 0.8 },
      crossfade =
      {
        order = { "wind", "base_ambience" },
        curve_type = "cosine",
        from = { control = 0.35, volume_percentage = 0.0 },
        to = { control = 2, volume_percentage = 100.0 }
      }
    }
  }
})
