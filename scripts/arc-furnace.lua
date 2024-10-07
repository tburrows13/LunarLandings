local ArcFurnace = {}

local function on_script_trigger_effect(event)
  if event.effect_id ~= "ll-arc-furnace-created" then return end

  local entity = event.target_entity
  local position = entity.position

  local reactor = entity.surface.create_entity{
    name = "ll-arc-furnace-reactor",
    position = position,
    force = entity.force,
    create_build_effect_smoke = false,
  }
  storage.arc_furnaces[entity.unit_number] = {
    entity = entity,
    reactor = reactor,
    position = position,
  }

  entity.fluidbox.add_linked_connection(1, reactor, 1)

  script.register_on_object_destroyed(entity)
end

local function on_object_destroyed(event)
  local furnace_data = storage.arc_furnaces[event.unit_number]

  if furnace_data then
    if furnace_data.reactor.valid then
      furnace_data.reactor.destroy()
    end
  end
end

local function draw_heat_outputs(player, entity)
  local render_objects = {}
  for i = -2, 2, 2 do
    for j = -2, 2, 2 do
      if not (i == 0 and j == 0) then
        local render_object = rendering.draw_sprite{
          sprite="utility/heat_exchange_indication",
          target={entity=entity, offset={i, j}},
          surface=entity.surface,
          players={player},
        }
        table.insert(render_objects, render_object)
      end
    end
  end
  storage.arc_furnace_heat_renders[player.index] = render_objects
end

local function delete_heat_outputs(player)
  local heat_render_objects = storage.arc_furnace_heat_renders[player.index]
  if heat_render_objects then
    for _, render_object in pairs(heat_render_objects) do
      render_object.destroy()
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

local function build_caption(temperature)
  return {"", {"description.temperature"}, ": ", string.format("%.2f", temperature), " ", {"si-unit-degree-celsius"}}
end

local function build_gui(player, furnace, reactor)
  local anchor = {gui = defines.relative_gui_type.assembling_machine_gui, position = defines.relative_gui_position.right}

  storage.arc_furnace_guis[player.index] = gui.add(player.gui.relative, {
    {
      type = "frame",
      --style = "sp_relative_stretchable_frame",
      name = "ll-arc-furnace-relative-frame",
      direction = "vertical",
      anchor = anchor,
      children = {
        {type = "label", style = "frame_title", caption = {"gui-arc-furnace.information"}, ignored_by_interaction = true},
        {type = "frame", direction = "vertical", style = "inside_shallow_frame_with_padding", children = {
          {
            type = "flow",
            direction = "vertical",
            style = "inset_frame_container_vertical_flow",
            children = {
              {
                type = "progressbar",
                name = "ll-arc-furnace-progressbar",
                style = "heat_progressbar",
                value = reactor.temperature / 1000,
                caption = build_caption(reactor.temperature)
              },
              {type = "label", caption = {"gui-arc-furnace.temperature-overload"}},
            }
          }
        }}
      }
    }
  })
end

local function update_gui(player, reactor)
  local gui_elements = storage.arc_furnace_guis[player.index]
  gui_elements["ll-arc-furnace-progressbar"].value = reactor.temperature / 1000
  gui_elements["ll-arc-furnace-progressbar"].caption = build_caption(reactor.temperature)
end

local function on_gui_opened(event)
  local entity = event.entity
  if not entity or not entity.valid then return end
  if entity.type ~= "assembling-machine" then return end

  local player = game.get_player(event.player_index)

  if player.gui.relative["ll-arc-furnace-relative-frame"] then
    player.gui.relative["ll-arc-furnace-relative-frame"].destroy()
  end
  local furnace_data = storage.arc_furnaces[player.opened.unit_number]
  if furnace_data then
    build_gui(player, furnace_data.entity, furnace_data.reactor)
  end
end

local function on_tick()
  for _, player in pairs(game.connected_players) do
    if player.opened and player.opened_gui_type == defines.gui_type.entity and player.opened.name == "ll-arc-furnace" then
      local furnace_data = storage.arc_furnaces[player.opened.unit_number]
      update_gui(player, furnace_data.reactor)
    end
  end
end

ArcFurnace.events = {
  [defines.events.on_script_trigger_effect] = on_script_trigger_effect,
  [defines.events.on_object_destroyed] = on_object_destroyed,
  [defines.events.on_selected_entity_changed] = on_selected_entity_changed,
  [defines.events.on_gui_opened] = on_gui_opened,
  [defines.events.on_tick] = on_tick,
}

function ArcFurnace.on_init()
  storage.arc_furnaces = {}
  storage.arc_furnace_heat_renders = {}
  storage.arc_furnace_guis = {}
end

function ArcFurnace.on_configuration_changed()
  storage.arc_furnaces = storage.arc_furnaces or {}
  storage.arc_furnace_heat_renders = storage.arc_furnace_heat_renders or {}
  storage.arc_furnace_guis = storage.arc_furnace_guis or {}
end

return ArcFurnace