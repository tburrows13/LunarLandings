local function switch_filenames(pictures)
  --[[
    Replace
    __base__/graphics/decorative/small-rock/small-rock-01.png
    __alien-biomes__/graphics/decorative/small-rock/small-rock-01.png
  ]]
  for _, variation in pairs(pictures) do
    if mods["alien-biomes-graphics"] == "0.7.0" then
      variation.filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/" .. variation.filename:sub(30)
      variation.filename = string.gsub(variation.filename, "tiny%-rock", "rock-tiny")
      variation.filename = string.gsub(variation.filename, "small%-rock", "rock-small")
      variation.filename = string.gsub(variation.filename, "medium%-rock", "rock-medium")
      variation.filename = string.gsub(variation.filename, "big%-rock", "rock-big")
      variation.filename = string.gsub(variation.filename, "huge%-rock", "rock-huge")
      variation.filename = string.gsub(variation.filename, "big%-sand%-rock", "sand-rock-big")
      variation.filename = string.gsub(variation.filename, "medium%-sand%-rock", "sand-rock-medium")
      variation.filename = string.gsub(variation.filename, "small%-sand%-rock", "sand-rock-small")
    else
      variation.filename = "__alien-biomes-graphics__/graphics/decorative/" .. variation.filename:sub(30)
      variation.filename = string.gsub(variation.filename, "big%-sand%-rock", "sand-big-rock")
      variation.filename = string.gsub(variation.filename, "medium%-sand%-rock", "sand-medium-rock")
      variation.filename = string.gsub(variation.filename, "small%-sand%-rock", "sand-small-rock")
    end
  end
end

data:extend{
  {
    type = "item-subgroup",
    name = "ll-luna",
    group = "environment",
    order = "-a"
  },
}

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
    local next_lowland_bucket = current_lowland_bucket + frequency[2]
    lowland_buckets[name] = {current_lowland_bucket, next_lowland_bucket}
    current_lowland_bucket = next_lowland_bucket
    if next_lowland_bucket > 100 then
      log(serpent.block(lowland_buckets))
      error("Lowland bucket exceeds 100")
    end
  end
  return buckets, lowland_buckets
end


local function moon_rock_autoplace(bucket, lowland_bucket)
  return {
    tile_restriction = {"ll-luna-plain", "ll-luna-lowland"},
    default_enabled = false,
    probability_expression = "(random_probability > selection_min) * (random_probability < selection_max)",
    local_expressions = {
      random_probability = "random(100, lowland_bucket_low * 100003)",
      selection_min = "(elevation < -0.5) * lowland_bucket_low + (elevation >= -0.5) * bucket_low",
      selection_max = "(elevation < -0.5) * lowland_bucket_high + (elevation >= -0.5) * bucket_high",
      lowland_bucket_low = lowland_bucket[1],
      lowland_bucket_high = lowland_bucket[2],
      bucket_low = bucket[1],
      bucket_high = bucket[2],
    }
  }
end

-- Percentage of tiles that should have this decorative
-- First number is on plain, second number is on lowland
local craters = {
  ["crater3-huge"] = {0.0005, 0.0005},
  ["crater1-large"] = {0.06, 0.06},
  ["crater1-large-rare"] = {0.0005, 0.0005},
  ["crater2-medium"] = {0.3, 0.3},
  ["crater4-small"] = {1.2, 1.2},
  ["stone-decal-white"] = {0.02, 0.01},
  ["sand-decal-white"] = {0.005, 0.002},
}
local crater_buckets, lowland_crater_buckets = make_buckets(craters)
for name, bucket in pairs(crater_buckets) do
  local decorative = data.raw["optimized-decorative"]["ll-moon-" .. name]
  decorative.autoplace = moon_rock_autoplace(bucket, lowland_crater_buckets[name])
end

local decorative_rocks = {
  ["medium-rock"] = {0.1, 2},
  ["medium-sand-rock"] = {0.06, 0.6},
  ["small-sand-rock"] = {0.4, 4},
  ["small-rock"] = {0.7, 7},
  ["tiny-rock"] = {1, 5},
}
local decorative_rock_buckets, lowland_decorative_rock_buckets = make_buckets(decorative_rocks)
for name, bucket in pairs(decorative_rock_buckets) do
  local rock = table.deepcopy(data.raw["optimized-decorative"][name])
  rock.name = "ll-moon-" .. name
  rock.subgroup = "ll-luna"
  rock.order = "x-b"
  rock.autoplace = moon_rock_autoplace(bucket, lowland_decorative_rock_buckets[name])
  switch_filenames(rock.pictures)
  data:extend{rock}
end

local entity_rock_results = {  -- Between how many moon rocks gained when mined
  ["ll-moon-huge-rock"] = {6, 12},
  ["ll-moon-big-rock"] = {3, 7},
  ["ll-moon-big-sand-rock"] = {3, 7},
}
local entity_rocks = {
  ["huge-rock"] = {0.03, 2},
  ["big-rock"] = {0.01, 4},
  ["big-sand-rock"] = {0.05, 2},
}
local entity_rock_buckets, lowland_entity_rock_buckets = make_buckets(entity_rocks)
log(serpent.block(lowland_entity_rock_buckets))
for name, bucket in pairs(entity_rock_buckets) do
  local rock = table.deepcopy(data.raw["simple-entity"][name])
  rock.name = "ll-moon-" .. name
  rock.subgroup = "ll-luna"
  rock.order = "x-c"
  rock.map_color={r=45, g=45, b=45}
  rock.minable.result = nil
  rock.minable.count = nil
  rock.minable.results = {{type = "item", name = "ll-moon-rock", amount_min = entity_rock_results[rock.name][1], amount_max = entity_rock_results[rock.name][2]}}
  rock.loot = nil
  rock.autoplace = moon_rock_autoplace(bucket, lowland_entity_rock_buckets[name])
  rock.ll_surface_conditions = {nauvis = false, luna = {plain = true, lowland = true, mountain = true, foundation = true}}
  switch_filenames(rock.pictures)
  data:extend{rock}
end
