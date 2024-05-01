local noise = require "noise"
local tne = noise.to_noise_expression

local function switch_filenames(pictures)
  --[[
    Replace
    __base__/graphics/decorative/rock-small/rock-small-01.png
    __alien-biomes__/graphics/decorative/rock/base/rock-small/rock-small-01.png
  ]]
  for _, variation in pairs(pictures) do
    variation.filename = "__alien-biomes__/graphics/decorative/rock/base/" .. variation.filename:sub(30)
    variation.hr_version.filename = "__alien-biomes__/graphics/decorative/rock/base/" .. variation.hr_version.filename:sub(30)
  end
end

local current_bucket = 0  -- Persists across all make_buckets calls
local function make_buckets(frequencies)
  local buckets = {}
  for name, frequency in pairs(frequencies) do
    buckets[name] = {current_bucket, current_bucket + frequency}
    current_bucket = current_bucket + frequency
  end
  return buckets
end

local elevation = noise.var("elevation")
local function moon_probability_expression(bucket, increase_in_lowland)
  return noise.define_noise_function( function(x, y, tile, map)
    local selection = noise.random(100)
    local elevation_multiplier = 1
    if increase_in_lowland then
      elevation_multiplier = noise.if_else_chain(
        noise.less_than(elevation, -0.5), 20,
        1
      )
    end

    local selection_min, selection_max = tne(bucket[1]) * elevation_multiplier, tne(bucket[2]) * elevation_multiplier
    local probability = noise.if_else_chain(
      noise.less_or_equal(selection_min, selection), noise.if_else_chain(
        noise.less_than(selection, selection_max), 1,
        0
      ),
      0
    )
    return probability
  end)
end

-- Percentage of tiles that should have this decorative
local craters = {
  ["crater3-huge"] = 0.0005,
  ["crater1-large"] = 0.06,
  ["crater1-large-rare"] = 0.0005,
  ["crater2-medium"] = 0.3,
  ["crater4-small"] = 1.2,
}
local crater_buckets = make_buckets(craters)
for name, bucket in pairs(crater_buckets) do
  local decorative = table.deepcopy(data.raw["optimized-decorative"][name])
  decorative.name = "ll-moon-" .. name

  decorative.autoplace = {
    name = name,
    order = "b",
    tile_restriction = {"ll-luna-plain", "ll-luna-lowland"},
    default_enabled = false,
    probability_expression = moon_probability_expression(bucket, false),
  },
  --decorative.autoplace.tile_restriction = {"ll-luna-plain"}
  data:extend{decorative}
end

local decorative_rocks = {
  ["rock-medium"] = 0.1,
  ["sand-rock-medium"] = 0.06,
  ["sand-rock-small"] = 0.4,
  ["rock-small"] = 0.7,
  ["rock-tiny"] = 1,
}
local decorative_rock_buckets = make_buckets(decorative_rocks)
for name, bucket in pairs(decorative_rock_buckets) do
  local rock = table.deepcopy(data.raw["optimized-decorative"][name])
  rock.name = "ll-moon-" .. name
  rock.autoplace = {
    name = name,
    order = "b",
    tile_restriction = {"ll-luna-plain", "ll-luna-lowland"},
    default_enabled = false,
    probability_expression = moon_probability_expression(bucket, true),
  },
  --rock.autoplace.tile_restriction = {"ll-luna-plain", "ll-luna-lowland"}
  switch_filenames(rock.pictures)
  data:extend{rock}
end


local entity_rocks = {
  ["rock-huge"] = 0.03,
  ["rock-big"] = 0.01,
  ["sand-rock-big"] = 0.05,
}
local entity_rock_buckets = make_buckets(entity_rocks)
for name, bucket in pairs(entity_rock_buckets) do
  local rock = table.deepcopy(data.raw["simple-entity"][name])
  rock.name = "ll-moon-" .. name
  rock.map_color={r=45, g=45, b=45}
  if rock.minable.result then
    rock.minable.result = "ll-moon-rock"
  else
    rock.minable.results[1].name = "ll-moon-rock"
    rock.minable.results[2] = nil  -- Remove coal from rock-huge
  end
  rock.loot[1].item = "ll-moon-rock"
  rock.autoplace = {
    name = name,
    order = "b",
    tile_restriction = {"ll-luna-plain", "ll-luna-lowland"},
    default_enabled = false,
    probability_expression = moon_probability_expression(bucket, true),
  },
  --rock.autoplace.tile_restriction = {"ll-luna-plain", "ll-luna-lowland"}
  switch_filenames(rock.pictures)
  -- TODO surface_conditions
  data:extend{rock}
end
