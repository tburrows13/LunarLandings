data:extend{
  {
    type = "collision-layer",
    name = "ll_luna_plain_tile",
  },
  {
    type = "collision-layer",
    name = "ll_luna_lowland_tile",
  },
  {
    type = "collision-layer",
    name = "ll_luna_mountain_tile",
  },
  {
    type = "collision-layer",
    name = "ll_luna_foundation_tile",
  },
  {
    type = "collision-layer",
    name = "ll_luna_tile",
  },
  {
    type = "collision-layer",
    name = "ll_nauvis_tile",
  },
}

data.raw.tile["ll-luna-plain"].collision_mask.layers["ll_luna_plain_tile"] = true
data.raw.tile["ll-luna-lowland"].collision_mask.layers["ll_luna_lowland_tile"] = true
data.raw.tile["ll-luna-mountain"].collision_mask.layers["ll_luna_mountain_tile"] = true
data.raw.tile["ll-lunar-foundation"].collision_mask.layers["ll_luna_foundation_tile"] = true

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

for _, tile in pairs(data.raw.tile) do
  if not luna_tiles[tile.name] and not whitelist_tiles[tile.name] then
    tile.collision_mask.layers["ll_nauvis_tile"] = true
  end
end

for _, tile in pairs(data.raw.tile) do
  if luna_tiles[tile.name] then
    tile.collision_mask.layers["ll_luna_tile"] = true
  end
end

--local types = {"accumulator", "beacon", "boiler", "burner-generator", "arithmetic-combinator", "decider-combinator", "constant-combinator", "container", "logistic-container", "infinity-container", "assembling-machine", "rocket-silo", "furnace", "electric-energy-interface", "electric-pole", "unit-spawner", "gate", "generator", "heat-interface", "heat-pipe", "inserter", "lab", "lamp", "land-mine", "linked-container", "market", "mining-drill", "offshore-pump", "pipe", "infinity-pipe", "pipe-to-ground", "power-switch", "programmable-speaker", "pump", "radar", "curved-rail", "straight-rail", "rail-chain-signal", "rail-signal", "reactor", "roboport", "simple-entity-with-owner", "simple-entity-with-force", "solar-panel", "storage-tank", "train-stop", "linked-belt", "loader-1x1", "loader", "splitter", "transport-belt", "underground-belt", "turret", "ammo-turret", "electric-turret", "fluid-turret", "car", "spider-vehicle", "spider-leg", "wall", "fish", "simple-entity", "tree", "locomotive", "cargo-wagon", "fluid-wagon", "artillery-wagon"}
local train_types = {["locomotive"] = true, ["cargo-wagon"] = true, ["fluid-wagon"] = true, ["artillery-wagon"] = true}

--[[
  surface_conditions examples:
  {nauvis = true, luna = false}
  {nauvis = false, luna = {plain = true, lowland = false, mountain = true, foundation = true}}

  Defaults:
  lab, radar, bots, roboports, certain trains: {nauvis = true, luna = false}
  straight-rail, curved-rail, rail-signal, rail-chain-signal, car, spider-vehicle, spider-leg, electric-pole, simple-entity: {nauvis = true, luna = {plain = true, lowland = true, mountain = true, foundation = true}}
  everything else: {nauvis = true, luna = {plain = true, lowland = false, mountain = true, foundation = true}}

  `luna = true` is the same as `luna = {plain = true, lowland = false, mountain = true, foundation = true}`
]]

local default_anywhere = {
  ["legacy-straight-rail"] = true,
  ["legacy-curved-rail"] = true,
  ["straight-rail"] = true,
  ["curved-rail-a"] = true,
  ["curved-rail-b"] = true,
  ["half-diagonal-rail"] = true,
  ["elevated-straight-rail"] = true,
  ["elevated-curved-rail-a"] = true,
  ["elevated-curved-rail-b"] = true,
  ["elevated-half-diagonal-rail"] = true,
  ["rail-ramp"] = true,
  ["rail-support"] = true,
  ["rail-signal"] = true,
  ["rail-chain-signal"] = true,
  ["car"] = true,
  ["spider-vehicle"] = true,
  ["spider-leg"] = true,
  ["electric-pole"] = true,
  ["simple-entity"] = true,
  ["cargo-pod"] = true,
  ["temporary-container"] = true,
  ["item-request-proxy"] = true,
}

local function ban_from_luna(prototype)
  if prototype.surface_conditions then return end
  prototype.surface_conditions = {{
    property = "ll-radiation",
    min = 0,
    max = 0,
  }}
end

local function restrict_to_luna(prototype)
  if prototype.surface_conditions then return end
  prototype.surface_conditions = {{
    property = "ll-radiation",
    min = 1,
  }}
end

local function get_default_surface_conditions(prototype)
  local type = prototype.type
  if type == "lab" or type == "radar" or train_types[type] then
    return {nauvis = true, luna = false}
  elseif type == "roboport" or type == "logistic-robot" or type == "construction-robot" then
    return {nauvis = true, luna = false}
  elseif default_anywhere[type] then
    return {nauvis = true, luna = {plain = true, lowland = true, mountain = true, foundation = true}}
  else
    return {nauvis = true, luna = {plain = true, lowland = false, mountain = true, foundation = true}}
  end
end

local function add_to_description(prototype, localised_string)
  if prototype.localised_description then
    prototype.localised_description = {"", prototype.localised_description, "\n", localised_string}
  else
    prototype.localised_description = {"", {"?", {"", {"entity-description." .. prototype.name}, "\n"}, ""}, localised_string}
  end
end

local function add_comma(restrictions_list)
  if #restrictions_list >= 2 then
    table.insert(restrictions_list, ", ")
  end
end

for prototype_type, _ in pairs(defines.prototypes.entity) do
  for name, prototype in pairs(data.raw[prototype_type] or {}) do
    if BASE_ONLY and prototype.surface_conditions then
      prototype.surface_conditions = nil
    end
    if prototype.hidden or not prototype.collision_box or prototype_type == "cliff" then
      goto continue
    end
    local surface_conditions = prototype.ll_surface_conditions
    prototype.ll_surface_conditions = nil
    if not surface_conditions then
      surface_conditions = get_default_surface_conditions(prototype)
    end

    -- Set collision masks
    if not train_types[prototype_type] then
      -- Train 'collision' is done at runtime
      --local mask = collision_mask_util.get_mask(prototype)
      local colliding_tile_layers = {}
      if surface_conditions.luna == false then
        if SPACE_AGE then
          ban_from_luna(prototype)
        else
          colliding_tile_layers.ll_luna_tile = true
        end
      elseif surface_conditions.luna == true then
        -- Set default
        surface_conditions.luna = {plain = true, lowland = false, mountain = true, foundation = true}
      end
      if surface_conditions.nauvis == false then
        if SPACE_AGE then
          restrict_to_luna(prototype)
        else
          colliding_tile_layers.ll_nauvis_tile = true
        end
      end
      if type(surface_conditions.luna) == "table" then
        local luna_conditions = surface_conditions.luna
        if not luna_conditions.plain then
          colliding_tile_layers.ll_luna_plain_tile = true
        end
        if not luna_conditions.lowland then
          colliding_tile_layers.ll_luna_lowland_tile = true
        end
        if not luna_conditions.mountain then
          colliding_tile_layers.ll_luna_mountain_tile = true
        end
        if not luna_conditions.foundation then
          colliding_tile_layers.ll_luna_foundation_tile = true
        end
      end

      if table_size(colliding_tile_layers) == 0 then goto continue end

      local tile_buildability_rules = prototype.tile_buildability_rules or {}
      table.insert(tile_buildability_rules, {
        area = prototype.collision_box,
        colliding_tiles = {layers = colliding_tile_layers},
        required_tiles = {layers = {ground_tile = true, water_tile = true}},
        remove_on_collision = true,
      })
      prototype.tile_buildability_rules = tile_buildability_rules
  end
    -- Add to descriptions
    -- First check mountain-only and foundation-only
    if type(surface_conditions.luna) == "table" then
      local luna_conditions = surface_conditions.luna
      if not surface_conditions.nauvis and luna_conditions.mountain and not luna_conditions.plain and not luna_conditions.lowland and not luna_conditions.foundation then
        add_to_description(prototype, {"ll-surface-conditions.must-be-placed-on", {"tile-name.ll-luna-mountain"}})
        goto continue
      end
      if not surface_conditions.nauvis and luna_conditions.foundation and not luna_conditions.plain and not luna_conditions.lowland and not luna_conditions.mountain then
        add_to_description(prototype, {"ll-surface-conditions.must-be-placed-on", {"tile-name.ll-lunar-foundation"}})
        goto continue
      end
    end

    local restrictions_list = {""}
    if surface_conditions.luna == false then
      add_comma(restrictions_list)
      table.insert(restrictions_list, {"space-location-name.luna"})
    end
    if surface_conditions.nauvis == false then
      add_comma(restrictions_list)
      table.insert(restrictions_list, {"space-location-name.nauvis"})
    end
    if type(surface_conditions.luna) == "table" then
      local luna_conditions = surface_conditions.luna
      if not luna_conditions.plain then
        add_comma(restrictions_list)
        table.insert(restrictions_list, {"tile-name.ll-luna-plain"})
        end
      if not luna_conditions.lowland then
        add_comma(restrictions_list)
        table.insert(restrictions_list, {"tile-name.ll-luna-lowland"})
        end
      if not luna_conditions.mountain then
        add_comma(restrictions_list)
        table.insert(restrictions_list, {"tile-name.ll-luna-mountain"})
        end
      if not luna_conditions.foundation then
        add_comma(restrictions_list)
        table.insert(restrictions_list, {"tile-name.ll-lunar-foundation"})
        end
      end
    if #restrictions_list > 1 then
      add_to_description(prototype, {"ll-surface-conditions.cannot-be-placed-on", restrictions_list})
    end

    ::continue::
  end
end

-- TODO respect surface_conditions, add to tooltip
for name, prototype in pairs(data.raw.item) do
  if name ~= "ll-lunar-foundation" and prototype.place_as_tile then
    prototype.place_as_tile.condition.layers["ll_luna_tile"] = true
  end
end

data.raw["item"]["ll-lunar-foundation"].place_as_tile.condition.layers = {
  ll_nauvis_tile = true,
  ll_luna_mountain_tile = true,
  ll_luna_lowland_tile = true,
  ll_luna_foundation_tile = true,
}
