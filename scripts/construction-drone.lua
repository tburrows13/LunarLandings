
---@type ScriptLib
local ConstructionDrone = {}

local function on_construction_drone_created(event)
  if event.effect_id ~= "ll-construction-drone-created" then return end

  -- Remove bot, dispatch custom drone, mark target as 'managed'
  local bot = event.target_entity
  local target_ghost

  local drone = bot.surface.create_entity{
    name = "ll-construction-drone",
    force = bot.force,
    position = bot.position,
  }

  target_ghost.force = "Under construction"
end

ConstructionDrone.events = {
  [defines.events.on_script_trigger_effect] = on_construction_drone_created
}

function ConstructionDrone.on_init()
  game.create_force("Under construction")
  storage.construction_jobs = {}
end

return ConstructionDrone