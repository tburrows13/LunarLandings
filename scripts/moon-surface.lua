local function on_init()
  --local default_map_gen_settings = table.deepcopy(game.default_map_gen_settings)
  tile_settings = {
    ["ll-moon"] = {
      frequency = "regular",
      size = "regular",
    }
  }
  local crater_names = {
    "crater3-huge", "crater1-large-rare", "crater1-large", "crater2-medium", "crater4-small"
  }
  local nauvis = game.get_surface("nauvis")
  local nauvis_map_gen_settings = nauvis.map_gen_settings
  local moon_rock_controls = nauvis_map_gen_settings.autoplace_controls["ll-moon-rock"]
  local rich_moon_rock_controls = nauvis_map_gen_settings.autoplace_controls["ll-rich-moon-rock"]
  local ice_controls = nauvis_map_gen_settings.autoplace_controls["ll-ice"]
  local astrocrystals_controls = nauvis_map_gen_settings.autoplace_controls["ll-astrocrystals"]

  local luna = game.create_surface(
    "luna",
    {
      seed = nauvis_map_gen_settings.seed + 1,
      starting_area = "none",
      water = "none",
      cliff_settings = { cliff_elevation_0 = 1024 },
      default_enable_all_autoplace_controls = false,
      autoplace_controls = {
        ["ll-moon-rock"] = moon_rock_controls,
        ["ll-rich-moon-rock"] = rich_moon_rock_controls,
        ["ll-ice"] = ice_controls,
        ["ll-astrocrystals"] = astrocrystals_controls,
      },
      autoplace_settings = {
        decorative = { treat_missing_as_default = false },
        entity = { treat_missing_as_default = false, settings = {
          ["ll-moon-rock"] = moon_rock_controls,
          ["ll-rich-moon-rock"] = rich_moon_rock_controls,
          ["ll-ice"] = ice_controls,
          --[[["crater3-huge"] = moon_rock_controls,
          ["crater1-large-rare"] = moon_rock_controls,
          ["crater1-large"] = moon_rock_controls,
          ["crater2-medium"] = moon_rock_controls,
          ["crater4-small"] = moon_rock_controls,]]
        }},
        tile = { treat_missing_as_default = false, settings = tile_settings },
      },
      property_expression_names = {
        elevation = "ll-luna-elevation",
      }
    }
  )
  -- Nauvis is 25000 ticks per day
  local ticks_per_day = 100000
  luna.daytime = (game.tick / ticks_per_day) % 1
  luna.ticks_per_day = ticks_per_day
  luna.solar_power_multiplier = 2
  luna.freeze_daytime = false
  luna.show_clouds = false

  log("LunarLandings: on_init() done")
end

local MoonSurface = {}

MoonSurface.on_init = on_init
return MoonSurface
