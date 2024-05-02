local tests_failed = 0
local tests_passed = 0

-- tile, entity, should_collide
local tile_tests = {
  -- name, grass, water, luna-plain, luna-lowland, luna-mountain, luna-foundation
  {"character", false, true, false, false, false, false},
  --{"small-biter", false, false, true, true},
  --{"biter-spawner", false, true, true, true},
  {"car", false, true, false, false, false, false},
  {"pipe", false, true, false, true, false, false},
  {"pump", false, true, false, true, false, false},
  --{"iron-ore", false, true, true, true, true, true},
  --{"crude-oil", false, true, true, true, true, true},
  {"assembling-machine-1", false, true, true, true, true, false},
  {"steel-furnace", false, true, false, true, false, false},
  {"straight-rail", false, true, true, true, true, true},
  {"ll-telescope", true, true, true, true, false, true},
}

local entity_tests = {
  {"character", {"transport-belt"}, false},
  {"character", {"pump", "assembling-machine-1"}, true},
  {"car", {"transport-belt"}, false},
}

local function test_collision(mask1, mask2, name1, name2, should_collide)
  local collides = false
  for layer in pairs(mask1) do
    if mask2[layer] then
      collides = true
      break
    end
  end
  if should_collide and not collides then
    tests_failed = tests_failed + 1
    log("CollisionTest failed: " .. name1 .. " and " .. name2 .. " should collide. " .. serpent.line(mask1) .. " | " .. serpent.line(mask2))
  elseif not should_collide and collides then
    tests_failed = tests_failed + 1
    log("CollisionTest failed: " .. name1 .. " and " .. name2 .. " should not collide. " .. serpent.line(mask1) .. " | " .. serpent.line(mask2))
  else
    tests_passed = tests_passed + 1
  end
end

local function test_tile_collisions()
  local tiles = game.tile_prototypes
  local entities = game.entity_prototypes

  local grass_mask = tiles["grass-1"].collision_mask
  local water_mask = tiles["water"].collision_mask
  local luna_plain_mask = tiles["ll-luna-plain"].collision_mask
  local luna_lowland_mask = tiles["ll-luna-lowland"].collision_mask
  local luna_mountain_mask = tiles["ll-luna-mountain"].collision_mask
  local luna_foundation_mask = tiles["ll-lunar-foundation"].collision_mask

  for _, test_case in pairs(tile_tests) do
    local entity_name = test_case[1]
    local entity = entities[entity_name]
    if entity then
      local mask1 = entity.collision_mask
      test_collision(mask1, grass_mask, entity_name, "grass-1", test_case[2])
      test_collision(mask1, water_mask, entity_name, "water", test_case[3])
      test_collision(mask1, luna_plain_mask, entity_name, "ll-luna-plain", test_case[4])
      test_collision(mask1, luna_lowland_mask, entity_name, "ll-luna-lowland", test_case[5])
      test_collision(mask1, luna_mountain_mask, entity_name, "ll-luna-mountain", test_case[6])
      test_collision(mask1, luna_foundation_mask, entity_name, "ll-luna-foundation", test_case[7])
    end
  end
end

local function test_entity_collisions()
  local entities = game.entity_prototypes

  for _, test_case in pairs(entity_tests) do
    local entity_name = test_case[1]
    local entity1 = entities[entity_name]
    if entity1 then
      local mask1 = entity1.collision_mask
      for _, other_entity_name in pairs(test_case[2]) do
        local entity2 = entities[other_entity_name]
        if entity2 then
          local mask2 = entity2.collision_mask
          test_collision(mask1, mask2, entity_name, other_entity_name, test_case[3])
        end
      end
    end
  end
end

local function run_test()
  test_tile_collisions()
  test_entity_collisions()
  log("CollisionTest finished: " .. tests_passed .. " tests passed, " .. tests_failed .. " tests failed.")
end

---@type ScriptLib
local CollisionTest = {}

CollisionTest.on_init = run_test
CollisionTest.on_configuration_changed = run_test

return CollisionTest