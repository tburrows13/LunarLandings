local collision_mask_util = require "__core__.lualib.collision-mask-util"

local luna_plain_layer = collision_mask_util.get_first_unused_layer()
log("Created layer luna_plain_layer: " .. luna_plain_layer)
collision_mask_util.add_layer(data.raw.tile["ll-luna-plain"].collision_mask, luna_plain_layer)

local luna_lowland_layer = collision_mask_util.get_first_unused_layer()
log("Created layer luna_lowland_layer: " .. luna_lowland_layer)
collision_mask_util.add_layer(data.raw.tile["ll-luna-lowland"].collision_mask, luna_lowland_layer)

local luna_mountain_layer = collision_mask_util.get_first_unused_layer()
log("Created layer luna_mountain_layer: " .. luna_mountain_layer)
collision_mask_util.add_layer(data.raw.tile["ll-luna-mountain"].collision_mask, luna_mountain_layer)

local luna_foundation_layer = collision_mask_util.get_first_unused_layer()
log("Created layer luna_foundation_layer: " .. luna_foundation_layer
)
collision_mask_util.add_layer(data.raw.tile["ll-lunar-foundation"].collision_mask, luna_foundation_layer)

local luna_tiles = {
  ["ll-luna-plain"] = true,
  ["ll-luna-lowland"] = true,
  ["ll-luna-mountain"] = true,
  ["ll-lunar-foundation"] = true,
}

local whitelist_tiles = {
  ["lab-dark-1"] = true,
  ["lab-dark-2"] = true,
  ["lab-white"] = true,
  ["tutorial-grid"] = true,
}

local nauvis_layer = collision_mask_util.get_first_unused_layer()
log("Created layer nauvis_layer: " .. nauvis_layer)
for _, tile in pairs(data.raw.tile) do
  if not luna_tiles[tile.name] and not whitelist_tiles[tile.name] then
    collision_mask_util.add_layer(tile.collision_mask, nauvis_layer)
  end
end

local luna_layer = collision_mask_util.get_first_unused_layer()
log("Created layer luna_layer: " .. luna_layer)
for _, tile in pairs(data.raw.tile) do
  if luna_tiles[tile.name] then
    collision_mask_util.add_layer(tile.collision_mask, luna_layer)
  end
end

local types = {"accumulator", "beacon", "boiler", "burner-generator", "arithmetic-combinator", "decider-combinator", "constant-combinator", "container", "logistic-container", "infinity-container", "assembling-machine", "rocket-silo", "furnace", "electric-energy-interface", "electric-pole", "unit-spawner", "gate", "generator", "heat-interface", "heat-pipe", "inserter", "lab", "lamp", "land-mine", "linked-container", "market", "mining-drill", "offshore-pump", "pipe", "infinity-pipe", "pipe-to-ground", "power-switch", "programmable-speaker", "pump", "radar", "curved-rail", "straight-rail", "rail-chain-signal", "rail-signal", "reactor", "roboport", "simple-entity-with-owner", "simple-entity-with-force", "solar-panel", "storage-tank", "train-stop", "linked-belt", "loader-1x1", "loader", "splitter", "transport-belt", "underground-belt", "turret", "ammo-turret", "electric-turret", "fluid-turret", "unit", "car", "artillery-wagon", "cargo-wagon", "fluid-wagon", "locomotive", "spider-vehicle", "spider-leg", "wall", "fish", "simple-entity", "tree"}

--[[
  surface_conditions examples:
  {nauvis = true, luna = false}
  {nauvis = false, luna = {plain = true, lowland = false, mountain = true, foundation = true}}

  Defaults:
  lab, radar: {nauvis = true, luna = false}
  logistic-container (active-provider, requester, buffer): {nauvis = true, luna = false}
  straight-rail, curved-rail, rail-signal, rail-chain-signal, car, spider-vehicle, spider-leg, electric-pole, simple-entity: {nauvis = true, luna = {plain = true, lowland = true, mountain = true, foundation = true}}
  everything else: {nauvis = true, luna = {plain = true, lowland = false, mountain = true, foundation = true}}

  `luna = true` is the same as `luna = {plain = true, lowland = false, mountain = true, foundation = true}`
]]

local function get_default_surface_conditions(prototype)
  local type = prototype.type
  if type == "lab" or type == "radar" then
    return {nauvis = true, luna = false}
  elseif type == "logistic-container" and (prototype.logistic_mode == "active-provider" or prototype.logistic_mode == "requester" or prototype.logistic_mode == "buffer") then
    return {nauvis = true, luna = false}
  elseif type == "straight-rail" or type == "curved-rail" or type == "rail-signal" or type == "rail-chain-signal" or type == "car" or type == "spider-vehicle" or type == "spider-leg" or type == "electric-pole" or type == "simple-entity" then
    return {nauvis = true, luna = {plain = true, lowland = true, mountain = true, foundation = true}}
  else
    return {nauvis = true, luna = {plain = true, lowland = false, mountain = true, foundation = true}}
  end
end

local function add_to_description(prototype, localised_string)
  if prototype.localised_description then
    prototype.localised_description = {"", prototype.localised_description, "\n\n", localised_string}
  else
    prototype.localised_description = {"", {"?", {"", {"entity-description." .. prototype.name}, "\n\n"}, ""}, localised_string}
  end
end

local function add_comma(restrictions_list)
  if #restrictions_list >= 2 then
    table.insert(restrictions_list, ", ")
  end
end

for _, prototype_type in pairs(types) do
  for name, prototype in pairs(data.raw[prototype_type]) do
    local surface_conditions = prototype.surface_conditions
    prototype.surface_conditions = nil
    if not surface_conditions then
      surface_conditions = get_default_surface_conditions(prototype)
    end

  
    -- Set collision masks
    local mask = collision_mask_util.get_mask(prototype)
    if surface_conditions.luna == false then
      collision_mask_util.add_layer(mask, luna_layer)
    elseif surface_conditions.luna == true then
      -- Set default
      surface_conditions.lua = {plain = true, lowland = false, mountain = true, foundation = true}
    end
    if surface_conditions.nauvis == false then
      collision_mask_util.add_layer(mask, nauvis_layer)
    end
    if type(surface_conditions.luna) == "table" then
      local luna_conditions = surface_conditions.luna
      if not luna_conditions.plain then
        collision_mask_util.add_layer(mask, luna_plain_layer)
      end
      if not luna_conditions.lowland then
        collision_mask_util.add_layer(mask, luna_lowland_layer)
      end
      if not luna_conditions.mountain then
        collision_mask_util.add_layer(mask, luna_mountain_layer)
      end
      if not luna_conditions.foundation then
        collision_mask_util.add_layer(mask, luna_foundation_layer)
      end
    end
    prototype.collision_mask = mask


    -- Add to descriptions
    -- First check mountain-only and foundation-only
    if type(surface_conditions.luna) == "table" then
      local luna_conditions = surface_conditions.luna
      if not surface_conditions.nauvis and luna_conditions.mountain and not luna_conditions.plain and not luna_conditions.lowland and not luna_conditions.foundation then
        add_to_description(prototype, "Can only be placed on Luna mountains")
        goto continue
      end
      if not surface_conditions.nauvis and luna_conditions.foundation and not luna_conditions.plain and not luna_conditions.lowland and not luna_conditions.mountain then
        add_to_description(prototype, "Can only be placed on Luna foundations")
        goto continue
      end
    end

    local restrictions_list = {""}
    if surface_conditions.luna == false then
      add_comma(restrictions_list)
      table.insert(restrictions_list, "Luna")
    end
    if surface_conditions.nauvis == false then
      add_comma(restrictions_list)
      table.insert(restrictions_list, "Nauvis")
    end
    if type(surface_conditions.luna) == "table" then
      local luna_conditions = surface_conditions.luna
      if not luna_conditions.plain then
        add_comma(restrictions_list)
        table.insert(restrictions_list, "Luna plains")
        end
      if not luna_conditions.lowland then
        add_comma(restrictions_list)
        table.insert(restrictions_list, "Luna lowlands")
        end
      if not luna_conditions.mountain then
        add_comma(restrictions_list)
        table.insert(restrictions_list, "Luna mountains")
        end
      if not luna_conditions.foundation then
        add_comma(restrictions_list)
        table.insert(restrictions_list, "Luna foundations")
        end
      if #restrictions_list > 1 then
        add_to_description(prototype, {"ll-surface-conditions.cannot-be-placed-on", restrictions_list})
      end
    end

    ::continue::
  end
end

data.raw["item"]["ll-lunar-foundation"].place_as_tile.condition = {
  nauvis_layer,
  luna_mountain_layer,
  luna_foundation_layer,
}

for _, type in pairs({"artillery-wagon", "cargo-wagon", "fluid-wagon", "locomotive", "car"}) do
  for _, prototype in pairs(data.raw[type]) do
    if not prototype.selection_priority or prototype.selection_priority == 50 then
      prototype.selection_priority = 51
    end
  end
end

-- Now that vehicles have selection_priority = 51, bump up all spidertrons to 52
for _, type in pairs({"spider-vehicle"}) do
  for _, prototype in pairs(data.raw[type]) do
    if prototype.selection_priority and prototype.selection_priority == 51 then
      prototype.selection_priority = 52
    end
  end
end
