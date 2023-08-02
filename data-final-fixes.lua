local collision_mask_util = require "__core__.lualib.collision-mask-util"

-- Set tile layer because Alien Biomes overwrites it in data-final-fixes
data.raw.tile["ll-moon"].layer = 10

local moon_rock_layer = collision_mask_util.get_first_unused_layer()
collision_mask_util.add_layer(data.raw.tile["ll-moon"].collision_mask, moon_rock_layer)

local moon_foundation_layer = collision_mask_util.get_first_unused_layer()
collision_mask_util.add_layer(data.raw.tile["ll-lunar-foundation"].collision_mask, moon_foundation_layer)

local moon_tiles = {
  ["ll-moon"] = true,
  ["ll-lunar-foundation"] = true,
}

local nauvis_layer = collision_mask_util.get_first_unused_layer()
for _, tile in pairs(data.raw.tile) do
  if not moon_tiles[tile.name] then
    collision_mask_util.add_layer(tile.collision_mask, nauvis_layer)
  end
end

-- TODO replace with prototype attribute based system

for name, prototype in pairs(data.raw["assembling-machine"]) do
  if name ~= "ll-telescope" and name ~= "electric-furnace" then
    local mask = collision_mask_util.get_mask(prototype)
    collision_mask_util.add_layer(mask, moon_rock_layer)
    prototype.collision_mask = mask
  end
end

local not_on_nauvis = {
  ["ll-low-grav-assembling-machine"] = true,
  --["ll-core-extractor"] = true,
  ["ll-telescope"] = true,
  ["ll-oxygen-diffuser"] = true,
  ["ll-rocket-silo-interstellar"] = true,
  ["ll-moon-rock"] = true,
  ["ll-ice"] = true,
}

for _, type in pairs{"beacon", "mining-drill", "assembling-machine", "rocket-silo", "resource"} do
  for name, prototype in pairs(data.raw[type]) do
    if not_on_nauvis[name] then
      local mask = collision_mask_util.get_mask(prototype)
      collision_mask_util.add_layer(mask, nauvis_layer)
      prototype.collision_mask = mask
    end
  end
end

local not_on_luna = {
  ["straight-rail"] = true,
  ["curved-rail"] = true,
}

for _, type in pairs{"straight-rail", "curved-rail"} do
  for name, prototype in pairs(data.raw[type]) do
    if not_on_luna[name] then
      local mask = collision_mask_util.get_mask(prototype)
      collision_mask_util.add_layer(mask, moon_rock_layer)
      collision_mask_util.add_layer(mask, moon_foundation_layer)
      prototype.collision_mask = mask
    end
  end
end

local types_not_on_luna = {
  "radar",
}

for _, type in pairs(types_not_on_luna) do
  for name, prototype in pairs(data.raw[type]) do
    local mask = collision_mask_util.get_mask(prototype)
    collision_mask_util.add_layer(mask, moon_rock_layer)
    collision_mask_util.add_layer(mask, moon_foundation_layer)
    prototype.collision_mask = mask
  end
end

-- Ban logistic requester chests
for _, prototype in pairs(data.raw["logistic-container"]) do
  if prototype.logistic_mode ~= "passive-provider" or prototype.logistic_mode ~= "storage" then
    local mask = collision_mask_util.get_mask(prototype)
    collision_mask_util.add_layer(mask, moon_rock_layer)
    collision_mask_util.add_layer(mask, moon_foundation_layer)
    prototype.collision_mask = mask
  end
end

data.raw["item"]["ll-lunar-foundation"].place_as_tile.condition = {
  nauvis_layer,
  moon_foundation_layer,
}