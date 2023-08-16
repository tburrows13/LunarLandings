local collision_mask_util = require "__core__.lualib.collision-mask-util"

local moon_rock_layer = collision_mask_util.get_first_unused_layer()
collision_mask_util.add_layer(data.raw.tile["ll-moon"].collision_mask, moon_rock_layer)

local moon_foundation_layer = collision_mask_util.get_first_unused_layer()
collision_mask_util.add_layer(data.raw.tile["ll-lunar-foundation"].collision_mask, moon_foundation_layer)

local luna_tiles = {
  ["ll-moon"] = true,
  ["ll-lunar-foundation"] = true,
}

local whitelist_tiles = {
  ["lab-dark-1"] = true,
  ["lab-dark-2"] = true,
  ["lab-white"] = true,
  ["tutorial-grid"] = true,
}

local nauvis_layer = collision_mask_util.get_first_unused_layer()
for _, tile in pairs(data.raw.tile) do
  if not luna_tiles[tile.name] and not whitelist_tiles[tile.name] then
    collision_mask_util.add_layer(tile.collision_mask, nauvis_layer)
  end
end

local luna_layer = collision_mask_util.get_first_unused_layer()
for _, tile in pairs(data.raw.tile) do
  if luna_tiles[tile.name] then
    collision_mask_util.add_layer(tile.collision_mask, luna_layer)
  end
end

-- TODO replace with prototype attribute based system

data.raw["straight-rail"]["straight-rail"].surface_conditions = {nauvis = true, luna = false}
data.raw["curved-rail"]["curved-rail"].surface_conditions = {nauvis = true, luna = false}
data.raw["assembling-machine"]["assembling-machine-1"].surface_conditions = {nauvis = false, luna = {rock = false, foundation = true}}
data.raw["assembling-machine"]["assembling-machine-2"].surface_conditions = {nauvis = false, luna = {rock = false, foundation = true}}
data.raw["assembling-machine"]["assembling-machine-3"].surface_conditions = {nauvis = false, luna = {rock = false, foundation = true}}

local types = {"accumulator", "beacon", "boiler", "burner-generator", "arithmetic-combinator", "decider-combinator", "constant-combinator", "container", "logistic-container", "infinity-container", "assembling-machine", "rocket-silo", "furnace", "electric-energy-interface", "electric-pole", "unit-spawner", "gate", "generator", "heat-interface", "heat-pipe", "inserter", "lab", "lamp", "land-mine", "linked-container", "market", "mining-drill", "offshore-pump", "pipe", "infinity-pipe", "pipe-to-ground", "power-switch", "programmable-speaker", "pump", "radar", "curved-rail", "straight-rail", "rail-chain-signal", "rail-signal", "reactor", "roboport", "simple-entity-with-owner", "simple-entity-with-force", "solar-panel", "storage-tank", "train-stop", "linked-belt", "loader-1x1", "loader", "splitter", "transport-belt", "underground-belt", "turret", "ammo-turret", "electric-turret", "fluid-turret", "unit", "car", "artillery-wagon", "cargo-wagon", "fluid-wagon", "locomotive", "spider-vehicle", "wall", "fish", "simple-entity", "tree"}

-- surface_conditions:
-- {nauvis = true, luna = false}
-- {nauvis = false, luna = {rock = false, foundation = true}}

local function get_default_surface_conditions(prototype)
  local type = prototype.type
  if type == "lab" or type == "radar" then
    return {nauvis = true, luna = false}
  elseif type == "logistic-container" and (prototype.logistic_mode == "active-provider" or prototype.logistic_mode == "requester" or prototype.logistic_mode == "buffer") then
    return {nauvis = true, luna = false}
  else
    return {nauvis = true, luna = true}
  end
end

local function add_to_description(prototype, localised_string)
  if prototype.localised_description then
    prototype.localised_description = {"", prototype.localised_description, "\n\n", localised_string}
  else
    prototype.localised_description = {"", {"?", {"", {"entity-description." .. prototype.name}, "\n\n"}, ""}, localised_string}
  end
end

for _, prototype_type in pairs(types) do
  for name, prototype in pairs(data.raw[prototype_type]) do
    local surface_conditions = prototype.surface_conditions
    if not surface_conditions then
      surface_conditions = get_default_surface_conditions(prototype)
    end
    local mask = collision_mask_util.get_mask(prototype)
    if surface_conditions.luna == false and surface_conditions.nauvis == true then
      collision_mask_util.add_layer(mask, luna_layer)
      add_to_description(prototype, "Cannot be placed on Luna")
    end
    if surface_conditions.luna == true and surface_conditions.nauvis == false then
      collision_mask_util.add_layer(mask, nauvis_layer)
      add_to_description(prototype, "Cannot be placed on Nauvis")
    end
    if type(surface_conditions.luna) == "table" then
      if surface_conditions.luna.rock == false then
        collision_mask_util.add_layer(mask, moon_rock_layer)
        add_to_description(prototype, "Cannot be placed on Moon Rock")
      end
      if surface_conditions.luna.foundation == false then
        collision_mask_util.add_layer(mask, moon_foundation_layer)
        add_to_description(prototype, "Cannot be placed on Moon Foundation")
      end
    end
    prototype.collision_mask = mask
    prototype.surface_conditions = nil
  end
end

data.raw["item"]["ll-lunar-foundation"].place_as_tile.condition = {
  nauvis_layer,
  moon_foundation_layer,
}
