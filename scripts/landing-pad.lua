---@type ScriptLib
local LandingPad = {}


local function build_gui(player, name)
  local anchor = {gui = defines.relative_gui_type.container_gui, position = defines.relative_gui_position.right, name = "ll-landing-pad"}

  return gui.add(player.gui.relative, {
    {
      type = "frame",
      --style = "sp_relative_stretchable_frame",
      name = "ll-landing-pad-relative-frame",
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
              name = "ll-landing-pad-name-entry",
              text = name,
              lose_focus_on_confirm = true, clear_and_focus_on_right_click = true,
              handler = {[defines.events.on_gui_confirmed] = LandingPad.dock_renamed},
            }
          }},
        }},
      }
    }
  })
end

function LandingPad.dock_renamed(player, element, landing_pad, landing_pad_data)
  local text = element.text
  if text then
    local old_name = landing_pad_data.name
    if old_name then
      LandingPad.name_removed(old_name, landing_pad.unit_number, landing_pad_data.surface_name)
    end
    landing_pad_data.name = text
    LandingPad.name_added(text, landing_pad.unit_number, landing_pad_data.surface_name)
  end
end

gui.add_handlers(LandingPad,
  function(event, handler)
    local player = game.get_player(event.player_index)
    local entity = player.opened
    if not entity or not entity.valid then return end
    local entity_data = global.landing_pads[entity.unit_number]
    handler(player, event.element, entity, entity_data)
  end
)

function LandingPad.name_added(name, unit_number, surface_name)
  local names = global.landing_pad_names[surface_name]
  if name ~= "Default" and names[name] and next(names[name]) then
    game.print({"ll-console-info.landing-pad-name-exists", name})
  end
  if names[name] then
    names[name][unit_number] = true
  else
    names[name] = {[unit_number] = true}
  end
end

function LandingPad.name_removed(name, unit_number, surface_name)
  local names = global.landing_pad_names[surface_name]
  if names[name] then
    names[name][unit_number] = nil
    if not next(names[name]) then
      names[name] = nil
    end
  end
end


local function update_gui(player, name)
  local text_field = player.gui.relative["ll-landing-pad-relative-frame"].children[2].children[1].children[1]
  text_field.text = name
end

local function on_gui_opened(event)
  local entity = event.entity
  if not entity or not entity.valid then return end
  if entity.name ~= "ll-landing-pad" then return end
  local player = game.get_player(event.player_index)

  --if player.gui.relative["ll-landing-pad-relative-frame"] then
  --  player.gui.relative["ll-landing-pad-relative-frame"].destroy()
  --end
  local entity_data = global.landing_pads[entity.unit_number]

  if not player.gui.relative["ll-landing-pad-relative-frame"] then
    global.landing_pad_guis[player.index] = build_gui(player, entity_data.name)
  else
    update_gui(player, entity_data.name)
  end
end


local function on_gui_closed(event)
  local player = game.get_player(event.player_index)
  local entity = event.entity
  if not entity or not entity.valid then return end
  if entity.name ~= "ll-landing-pad" then return end
  local entity_data = global.landing_pads[entity.unit_number]
  local landing_pad_gui = global.landing_pad_guis[player.index]
  local element = landing_pad_gui["ll-landing-pad-name-entry"]
  LandingPad.dock_renamed(nil, element, entity, entity_data)
  --[[if entity and (entity.type == "container" or entity.type == "logistic-container") then
    local relative_frame = player.gui.relative["sp-relative-frame"]
    if relative_frame then
      relative_frame.destroy()
    end
    global.landing_pad_guis[player.index] = nil
  end]]
end

local function on_built_entity(event)
  local entity = event.created_entity or event.entity
  if not entity.valid or entity.name ~= "ll-landing-pad" then return end
  global.landing_pads[entity.unit_number] = {
    entity = entity,
    name = "Default",
    surface_name = entity.surface.name
  }
  LandingPad.name_added("Default", entity.unit_number, entity.surface.name)
  script.register_on_entity_destroyed(entity)
end

local function on_entity_destroyed(event)
  local entity_data = global.landing_pads[event.unit_number]
  if not entity_data then return end

  LandingPad.name_removed(entity_data.name, event.unit_number, entity_data.surface_name)
  global.landing_pads[event.unit_number] = nil
end

LandingPad.events = {
  [defines.events.on_gui_opened] = on_gui_opened,
  [defines.events.on_gui_closed] = on_gui_closed,
  [defines.events.on_built_entity] = on_built_entity,
  [defines.events.on_robot_built_entity] = on_built_entity,
  [defines.events.script_raised_built] = on_built_entity,
  [defines.events.script_raised_revive] = on_built_entity,
  [defines.events.on_entity_destroyed] = on_entity_destroyed,
}

LandingPad.on_init = function ()
  global.landing_pads = {}
  global.landing_pad_names = {nauvis = {}, luna = {}}
  global.landing_pad_guis = {}
end

LandingPad.on_configuration_changed = function(changed_data)
  global.landing_pads = global.landing_pads or {}
  global.landing_pad_names = global.landing_pad_names or {nauvis = {}, luna = {}}
  global.landing_pad_guis = global.landing_pad_guis or {}
end

return LandingPad
