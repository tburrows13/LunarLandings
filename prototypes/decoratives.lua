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
local current_lowland_bucket = 0
local function make_buckets(frequencies)
  local buckets = {}
  for name, frequency in pairs(frequencies) do
    buckets[name] = {current_bucket, current_bucket + frequency[1]}
    current_bucket = current_bucket + frequency[1]
  end
  local lowland_buckets = {}
  for name, frequency in pairs(frequencies) do
    lowland_buckets[name] = {current_lowland_bucket, current_lowland_bucket + frequency[2]}
    current_lowland_bucket = current_lowland_bucket + frequency[2]
  end
  return buckets, lowland_buckets
end

local elevation = noise.var("elevation")
local function moon_probability_expression(bucket, lowland_bucket)
  return noise.define_noise_function( function(x, y, tile, map)
    local selection = noise.random(100)
    selection_min = noise.if_else_chain(
      noise.less_than(elevation, -0.5), lowland_bucket[1],
      bucket[1]
    )
    selection_max = noise.if_else_chain(
      noise.less_than(elevation, -0.5), lowland_bucket[2],
      bucket[2]
    )
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
-- First number is on plain, second number is on lowland
local craters = {
  ["crater3-huge"] = {0.0005, 0.0005},
  ["crater1-large"] = {0.06, 0.06},
  ["crater1-large-rare"] = {0.0005, 0.0005},
  ["crater2-medium"] = {0.3, 0.3},
  ["crater4-small"] = {1.2, 1.2},
}
local crater_buckets, lowland_crater_buckets = make_buckets(craters)
for name, bucket in pairs(crater_buckets) do
  local decorative = table.deepcopy(data.raw["optimized-decorative"][name])
  decorative.name = "ll-moon-" .. name

  decorative.autoplace = {
    name = name,
    order = "b",
    tile_restriction = {"ll-luna-plain", "ll-luna-lowland"},
    default_enabled = false,
    probability_expression = moon_probability_expression(bucket, lowland_crater_buckets[name]),
  },
  --decorative.autoplace.tile_restriction = {"ll-luna-plain"}
  data:extend{decorative}
end

local decorative_rocks = {
  ["rock-medium"] = {0.1, 2},
  ["sand-rock-medium"] = {0.06, 0.6},
  ["sand-rock-small"] = {0.4, 4},
  ["rock-small"] = {0.7, 7},
  ["rock-tiny"] = {1, 5},
}
local decorative_rock_buckets, lowland_decorative_rock_buckets = make_buckets(decorative_rocks)
for name, bucket in pairs(decorative_rock_buckets) do
  local rock = table.deepcopy(data.raw["optimized-decorative"][name])
  rock.name = "ll-moon-" .. name
  rock.autoplace = {
    name = name,
    order = "b",
    tile_restriction = {"ll-luna-plain", "ll-luna-lowland"},
    default_enabled = false,
    probability_expression = moon_probability_expression(bucket, lowland_decorative_rock_buckets[name]),
  },
  --rock.autoplace.tile_restriction = {"ll-luna-plain", "ll-luna-lowland"}
  switch_filenames(rock.pictures)
  data:extend{rock}
end

local entity_rocks = {
  ["rock-huge"] = {0.03, 2},
  ["rock-big"] = {0.01, 4},
  ["sand-rock-big"] = {0.05, 2},
}
local entity_rock_buckets, lowland_entity_rock_buckets = make_buckets(entity_rocks)
log(serpent.block(lowland_entity_rock_buckets))
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
    probability_expression = moon_probability_expression(bucket, lowland_entity_rock_buckets[name]),
  },
  --rock.autoplace.tile_restriction = {"ll-luna-plain", "ll-luna-lowland"}
  switch_filenames(rock.pictures)
  -- TODO surface_conditions
  data:extend{rock}
end
