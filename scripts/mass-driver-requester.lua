local Buckets = require "scripts.buckets"

---@type ScriptLib
local MassDriverRequester = {}


local function build_gui(player, name)
  local anchor = {gui = defines.relative_gui_type.container_gui, position = defines.relative_gui_position.right, name = "ll-mass-driver-requester"}

  return gui.add(player.gui.relative, {
    {
      type = "frame",
      --style = "sp_relative_stretchable_frame",
      name = "ll-mass-driver-requester-relative-frame",
      direction = "vertical",
      anchor = anchor,
      style_mods = {width = 300},
      children = {
        {type = "label", style = "frame_title", caption = {"description.name"}, ignored_by_interaction = true},
        {type = "flow", direction = "vertical", style = "inset_frame_container_vertical_flow", children = {
          {type = "frame", style = "inside_shallow_frame_with_padding", children = {
            {
              type = "textfield",
              style = "textbox",
              name = "ll-mass-driver-requester-name-entry",
              text = name,
              lose_focus_on_confirm = true, clear_and_focus_on_right_click = true,
              handler = {[defines.events.on_gui_confirmed] = MassDriverRequester.requester_renamed},
            }
          }},
        }},
      }
    }
  })
end

function MassDriverRequester.requester_renamed(player, element, mass_driver_requester, mass_driver_requester_data)
  local text = element.text
  if text then
    local old_name = mass_driver_requester_data.name
    if old_name then
      MassDriverRequester.name_removed(old_name, mass_driver_requester.unit_number)
    end
    mass_driver_requester_data.name = text
    MassDriverRequester.name_added(text, mass_driver_requester.unit_number)
  end
end

gui.add_handlers(MassDriverRequester,
  function(event, handler)
    local player = game.get_player(event.player_index)
    local entity = player.opened
    if not entity or not entity.valid then return end
    local entity_data = storage.mass_driver_requesters[entity.unit_number]
    handler(player, event.element, entity, entity_data)
  end
)

function MassDriverRequester.name_added(name, unit_number)
  names = storage.mass_driver_requester_names
  if name ~= "Default" and names[name] and next(names[name]) then
    game.print({"ll-console-info.mass-driver-requester-name-exists", name})
  end
  if names[name] then
    names[name][unit_number] = true
  else
    names[name] = {[unit_number] = true}
  end
end

function MassDriverRequester.name_removed(name, unit_number)
  names = storage.mass_driver_requester_names
  if names[name] then
    names[name][unit_number] = nil
    if not next(names[name]) then
      names[name] = nil
    end
  end
end


local function update_gui(player, name)
  local text_field = player.gui.relative["ll-mass-driver-requester-relative-frame"].children[2].children[1].children[1]
  text_field.text = name
end

local function on_gui_opened(event)
  local entity = event.entity
  if not entity or not entity.valid then return end
  if entity.name ~= "ll-mass-driver-requester" then return end
  local player = game.get_player(event.player_index)
  
  local inventory = entity.get_inventory(defines.inventory.chest)
  inventory.sort_and_merge()

  if player.gui.relative["ll-mass-driver-requester-relative-frame"] then
    player.gui.relative["ll-mass-driver-requester-relative-frame"].destroy()
  end
  local entity_data = storage.mass_driver_requesters[entity.unit_number]

  if not player.gui.relative["ll-mass-driver-requester-relative-frame"] then
    storage.mass_driver_requester_guis[player.index] = build_gui(player, entity_data.name)
  else
    update_gui(player, entity_data.name)
  end
end

local function on_gui_closed(event)
  local player = game.get_player(event.player_index)
  local entity = event.entity
  if not entity or not entity.valid then return end
  if entity.name ~= "ll-mass-driver-requester" then return end
  local entity_data = storage.mass_driver_requesters[entity.unit_number]
  local mass_driver_requester_gui = storage.mass_driver_requester_guis[player.index]
  local element = mass_driver_requester_gui["ll-mass-driver-requester-name-entry"]
  MassDriverRequester.requester_renamed(nil, element, entity, entity_data)
  --[[if entity and (entity.type == "container" or entity.type == "logistic-container") then
    local relative_frame = player.gui.relative["sp-relative-frame"]
    if relative_frame then
      relative_frame.destroy()
    end
    storage.mass_driver_requester_guis[player.index] = nil
  end]]
end

local function on_script_trigger_effect(event)
  if event.effect_id ~= "ll-mass-driver-requester-created" then return end

  local entity = event.target_entity
  entity.force = "ll-mass-driver"
  storage.mass_driver_requesters[entity.unit_number] = {
    entity = entity,
    name = "Default",
  }
  MassDriverRequester.name_added("Default", entity.unit_number)
  script.register_on_object_destroyed(entity)
end

local function on_object_destroyed(event)
  local entity_data = storage.mass_driver_requesters[event.useful_id]
  if not entity_data then return end

  MassDriverRequester.name_removed(entity_data.name, event.useful_id)
  storage.mass_driver_requesters[event.useful_id] = nil
end

--- returns the first logistic section of the entity
--- both mass drivers and mass driver requesters should have a single logistic section
function get_logistic_section(entity)
  local sections = entity.get_logistic_sections()
  local sections_count = sections.sections_count
  
  if sections_count == 0 then
    sections.add_section()
  elseif sections_count >= 2 then
    for i = sections.sections_count, 2, -1 do
      sections.remove_section(i)
    end
  end

  return sections.get_section(1)
end

local function check_requester_slots(entity)
  local requester_logistic_section = get_logistic_section(entity)
  local slots_cleared = false
  for i = 1, requester_logistic_section.filters_count do
    local slot = requester_logistic_section.get_slot(i)
    if slot and slot.value and not is_allowed(slot.value.name) then
      game.print {"ll-console-info.mass-driver-limitation", slot.value.name, slot.value.quality, entity.gps_tag}
      requester_logistic_section.clear_slot(i)
      -- If request slot is set by circuit network, then clearing it has no effect.
      if not requester_logistic_section.get_slot(i) then
        slots_cleared = true
      end
    end
  end
  return slots_cleared
end

local on_tick = function(event)
  for _, player in pairs(game.players) do
    local entity = player.opened
    if entity and entity.object_name == "LuaEntity" then
      if entity.name == "ll-mass-driver-requester" then
        if check_requester_slots(entity) then
          player.create_local_flying_text{
            text = {"ll-console-info.mass-driver-limitation"},
            create_at_cursor = true,
          }
        end
      end
    end
  end
end

local function on_entity_settings_pasted(event)
  local source, destination = event.source, event.destination

  local source_data = Buckets.get(storage.mass_drivers, source.unit_number) or storage.mass_driver_requesters[source.unit_number]
  if not source_data then return end
  local destination_data = Buckets.get(storage.mass_drivers, destination.unit_number) or storage.mass_driver_requesters[destination.unit_number]
  if not destination_data then return end

  local name = source_data.destination or source_data.name
  if destination.name == "ll-mass-driver" then
    destination_data.destination = name
  elseif destination.name == "ll-mass-driver-requester" and name ~= "None" then
    if source.name == "ll-mass-driver-requester" then
      -- copying names between two requesters causes duplicate names and is likely not what the user intended to do.
      return
    end
    local player = game.get_player(event.player_index)
    MassDriverRequester.requester_renamed(player, {text = name}, destination, destination_data)
  else
    error()
  end
end

MassDriverRequester.events = {
  [defines.events.on_tick] = on_tick,
  [defines.events.on_gui_opened] = on_gui_opened,
  [defines.events.on_gui_closed] = on_gui_closed,
  [defines.events.on_script_trigger_effect] = on_script_trigger_effect,
  [defines.events.on_object_destroyed] = on_object_destroyed,
  [defines.events.on_entity_settings_pasted] = on_entity_settings_pasted,
}

function MassDriverRequester.on_init()
  storage.mass_driver_requesters = storage.mass_driver_requesters or {}
  storage.mass_driver_requester_names = storage.mass_driver_requester_names or {}
  storage.mass_driver_requester_guis = storage.mass_driver_requester_guis or {}

  local force = game.create_force("ll-mass-driver")
  force.set_friend("player", true)
  force.set_cease_fire("player", true)
  local player_force = game.forces["player"]
  player_force.set_friend("ll-mass-driver", true)
  player_force.set_cease_fire("ll-mass-driver", true)
end

function MassDriverRequester.on_configuration_changed()
  storage.mass_driver_requesters = storage.mass_driver_requesters or {}
  storage.mass_driver_requester_names = storage.mass_driver_requester_names or {}
  storage.mass_driver_requester_guis = storage.mass_driver_requester_guis or {}

  if not game.forces["ll-mass-driver"] then
    MassDriverRequester.on_init()
  end
end

return MassDriverRequester