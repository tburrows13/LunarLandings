local effects = require("__core__/lualib/surface-render-parameter-effects")

local planet_map_gen = {}

planet_map_gen.luna = function()
  return
  {
    property_expression_names =
    {
      elevation = "luna_elevation",
      temperature = "temperature_basic",
      moisture = "moisture_basic",
      aux = "aux_basic",
      cliffiness = "cliffiness_luna",
      cliff_elevation = "cliff_elevation_luna",
    },
    cliff_settings =
    {
      name = "ll-luna-cliff",
      cliff_elevation_0 = 80,
      cliff_elevation_interval = 40,  -- Inversely proportional to "frequency"
      cliff_smoothing = 0, -- This is critical for correct cliff placement around mountains.
      richness = 0.95,  -- "continuity"
    },
    autoplace_controls = {
      ["ll-moon-rock"] = {},
      ["ll-rich-moon-rock"] = {},
      ["ll-ice"] = {},
      ["ll-astrocrystals"] = {},
    },
    autoplace_settings = {
      tile = {
        settings = {
          ["ll-luna-plain"] = {},
          ["ll-luna-lowland"] = {},
          ["ll-luna-mountain"] = {},
        }
      },
      decorative = {
        settings = {
          ["ll-moon-crater1-large"] = {},
          ["ll-moon-crater1-large-rare"] = {},
          ["ll-moon-crater2-medium"] = {},
          ["ll-moon-crater3-huge"] = {},
          ["ll-moon-crater4-small"] = {},
          ["ll-moon-stone-decal-white"] = {},
          ["ll-moon-sand-decal-white"] = {},
          ["ll-moon-medium-rock"] = {},
          ["ll-moon-small-rock"] = {},
          ["ll-moon-tiny-rock"] = {},
          ["ll-moon-medium-sand-rock"] = {},
          ["ll-moon-small-sand-rock"] = {},
        }
      },
      entity = {
        settings = {
          ["ll-moon-rock"] = {},
          ["ll-rich-moon-rock"] = {},
          ["ll-ice"] = {},
          ["ll-astrocrystals"] = {},
          ["ll-moon-huge-rock"] = {},
          ["ll-moon-big-rock"] = {},
          ["ll-moon-big-sand-rock"] = {},
        }
      },
    },
  }
end

local function persistent_ambient_sounds()
  local persistent_ambient_sounds = {
    base_ambience = {filename = "__LunarLandings__/sound/luna-ambience.ogg", volume = 0.2}
  }

  if mods["space-age"] then
    persistent_ambient_sounds.semi_persistent = {
      {
        sound = {variations = sound_variations("__space-age__/sound/world/semi-persistent/distant-rumble", 3, 0.5)},
        delay_mean_seconds = 10,
        delay_variance_seconds = 5
      },
      {
        sound = {variations = sound_variations("__space-age__/sound/world/semi-persistent/cold-wind-gust", 5, 0.3)},
        delay_mean_seconds = 15,
        delay_variance_seconds = 9
      }
    }
  end

  return persistent_ambient_sounds
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
    subgroup = BASE_ONLY and "space-related" or "planets",
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
    surface_render_parameters = {},
    persistent_ambient_sounds = persistent_ambient_sounds(),
  }
})

if BASE_ONLY then
  local nauvis = data.raw.planet.nauvis
  nauvis.subgroup = "space-related"
  nauvis.localised_description = {"", {"space-location-description.nauvis"}, "\n\n", {"space-location-description.nauvis-append"}}
end
