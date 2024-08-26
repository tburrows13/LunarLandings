local ArcFurnace = {}

local function on_script_trigger_effect(event)
  if event.effect_id ~= "ll-arc-furnace-created" then return end

  local entity = event.target_entity
  local position = entity.position
  local storage_tank_s = entity.surface.create_entity{
    name = "ll-arc-furnace-storage-tank",
    position = {position.x + 1.5, position.y + 2},
    force = entity.force,
    create_build_effect_smoke = false,
    direction = defines.direction.north,
  }
  local storage_tank_w = entity.surface.create_entity{
    name = "ll-arc-furnace-storage-tank",
    position = {position.x - 2, position.y + 1.5},
    force = entity.force,
    create_build_effect_smoke = false,
    direction = defines.direction.east
  }
  local storage_tank_n = entity.surface.create_entity{
    name = "ll-arc-furnace-storage-tank",
    position = {position.x - 1.5, position.y - 2},
    force = entity.force,
    create_build_effect_smoke = false,
    direction = defines.direction.south
  }
  local storage_tank_e = entity.surface.create_entity{
    name = "ll-arc-furnace-storage-tank",
    position = {position.x + 2, position.y - 1.5},
    force = entity.force,
    create_build_effect_smoke = false,
    direction = defines.direction.west
  }


  local reactor = entity.surface.create_entity{
    name = "ll-arc-furnace-reactor",
    position = position,
    force = entity.force,
    create_build_effect_smoke = false,
  }
  global.arc_furnaces[entity.unit_number] = {
    entity = entity,
    reactor = reactor,
    storage_tank_s = storage_tank_s,
    storage_tank_w = storage_tank_w,
    storage_tank_n = storage_tank_n,
    storage_tank_e = storage_tank_e,
    position = position,
  }

  script.register_on_entity_destroyed(entity)
end

local function on_entity_destroyed(event)
  local furnace_data = global.arc_furnaces[event.unit_number]

  if furnace_data then
    if furnace_data.reactor.valid then
      furnace_data.reactor.destroy()
    end
    if furnace_data.storage_tank_s.valid then
      furnace_data.storage_tank_s.destroy()
    end
    if furnace_data.storage_tank_w.valid then
      furnace_data.storage_tank_w.destroy()
    end
    if furnace_data.storage_tank_n.valid then
      furnace_data.storage_tank_n.destroy()
    end
    if furnace_data.storage_tank_e.valid then
      furnace_data.storage_tank_e.destroy()
    end
  end
end

local function draw_heat_outputs(player, entity)
  local render_ids = {}
  for i = -2, 2, 2 do
    for j = -2, 2, 2 do
      if not (i == 0 and j == 0) then
        local id = rendering.draw_sprite{
          sprite="utility/heat_exchange_indication",
          target=entity,
          target_offset={i, j},
          surface=entity.surface,
          players={player},
        }
        table.insert(render_ids, id)
      end
    end
  end
  global.arc_furnace_heat_renders[player.index] = render_ids
end

local function delete_heat_outputs(player)
  local heat_render_ids = global.arc_furnace_heat_renders[player.index]
  if heat_render_ids then
    for _, render_id in pairs(heat_render_ids) do
      rendering.destroy(render_id)
    end
  end
end

local function on_selected_entity_changed(event)
  local player = game.get_player(event.player_index)
  delete_heat_outputs(player)
  if player.selected and player.selected.name == "ll-arc-furnace" then
    draw_heat_outputs(player, player.selected)
  end
end

ArcFurnace.events = {
  [defines.events.on_script_trigger_effect] = on_script_trigger_effect,
  [defines.events.on_entity_destroyed] = on_entity_destroyed,
  [defines.events.on_selected_entity_changed] = on_selected_entity_changed,
}

function ArcFurnace.on_init()
  global.arc_furnaces = {}
  global.arc_furnace_heat_renders = {}
end

function ArcFurnace.on_configuration_changed()
  global.arc_furnaces = global.arc_furnaces or {}
  global.arc_furnace_heat_renders = global.arc_furnace_heat_renders or {}
end

return ArcFurnace