local default_controls = {
  frequency = "regular",
  size = "regular",
}

local decorative_controls = {
  frequency = 1,
  size = 1,
  richness = 1,
}

local default_resource_controls = {
  frequency = 1,
  size = 1,
  richness = 1,
}

local function on_init()
  local nauvis = game.get_surface("nauvis")
  local nauvis_map_gen_settings = nauvis.map_gen_settings
  if not nauvis_map_gen_settings.autoplace_controls then return end  -- We are in a simulation
  local moon_rock_controls = nauvis_map_gen_settings.autoplace_controls["ll-moon-rock"] or default_resource_controls
  local rich_moon_rock_controls = nauvis_map_gen_settings.autoplace_controls["ll-rich-moon-rock"] or default_resource_controls
  local ice_controls = nauvis_map_gen_settings.autoplace_controls["ll-ice"] or default_resource_controls
  local astrocrystals_controls = nauvis_map_gen_settings.autoplace_controls["ll-astrocrystals"] or default_resource_controls

  local luna = game.create_surface(
    "luna",
    {
      seed = nauvis_map_gen_settings.seed + 1,
      starting_area = "regular",
      water = "regular",
      cliff_settings = {
        name = "ll-luna-cliff",
        cliff_elevation_0 = 10,
        cliff_elevation_interval = 10,  -- frequency 40 divided by from 1/6 to 6
        richness = 4,  -- continuity from 1/6 to 6
      },
      default_enable_all_autoplace_controls = false,
      autoplace_controls = {
        ["ll-moon-rock"] = moon_rock_controls,
        ["ll-rich-moon-rock"] = rich_moon_rock_controls,
        ["ll-ice"] = ice_controls,
        ["ll-astrocrystals"] = astrocrystals_controls,
      },
      autoplace_settings = {
        decorative = { treat_missing_as_default = false, settings = {
          ["ll-moon-crater1-large"] = decorative_controls,
          ["ll-moon-crater1-large-rare"] = decorative_controls,
          ["ll-moon-crater2-medium"] = decorative_controls,
          ["ll-moon-crater3-huge"] = decorative_controls,
          ["ll-moon-crater4-small"] = decorative_controls,
          ["ll-moon-stone-decal-white"] = decorative_controls,
          ["ll-moon-sand-decal-white"] = decorative_controls,
          ["ll-moon-rock-medium"] = decorative_controls,
          ["ll-moon-rock-small"] = decorative_controls,
          ["ll-moon-rock-tiny"] = decorative_controls,
          ["ll-moon-sand-rock-medium"] = decorative_controls,
          ["ll-moon-sand-rock-small"] = decorative_controls,
        }},
        entity = { treat_missing_as_default = false, settings = {
          ["ll-moon-rock"] = moon_rock_controls,
          ["ll-rich-moon-rock"] = rich_moon_rock_controls,
          ["ll-ice"] = ice_controls,
          ["ll-astrocrystals"] = astrocrystals_controls,
          ["ll-moon-rock-huge"] = decorative_controls,
          ["ll-moon-rock-big"] = decorative_controls,
          ["ll-moon-sand-rock-big"] = decorative_controls,
        }},
        tile = { treat_missing_as_default = false, settings = {
          ["ll-luna-plain"] = default_controls,
          ["ll-luna-lowland"] = default_controls,
          ["ll-luna-mountain"] = default_controls,
        }},
      },
      property_expression_names = {
        elevation = "ll-luna-elevation",
      }
    }
  )
  -- Nauvis is 25000 ticks per day
  local ticks_per_day = 216000
  luna.daytime = (game.tick / ticks_per_day) % 1
  luna.ticks_per_day = ticks_per_day
  luna.solar_power_multiplier = 1.5
  luna.freeze_daytime = false
  luna.show_clouds = false

  log("LunarLandings: on_init() done")
end

local function on_configuration_changed()
  local luna = game.get_surface("luna")
  if luna then
    local ticks_per_day = 216000
    luna.daytime = (game.tick / ticks_per_day) % 1
    luna.ticks_per_day = ticks_per_day
    luna.solar_power_multiplier = 1.5
  end
end

local MoonSurface = {}

MoonSurface.on_init = on_init
MoonSurface.on_configuration_changed = on_configuration_changed
return MoonSurface
