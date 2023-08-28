---@type ScriptLib
local RocketSilo = {}

local rocket_silos = {
  ["rocket-silo"] = true,
  ["ll-rocket-silo-down"] = true,
}

local function build_gui(player, silo)
  local silo_data = global.rocket_silos[silo.unit_number]

  local anchor = {gui = defines.relative_gui_type.rocket_silo_gui, position = defines.relative_gui_position.right}

  local landing_pad_names = {[1] = "Space", [2] = "Luna Surface"}
  if silo.surface.name == "luna" then
    landing_pad_names[2] = "Nauvis Surface"
  end
  local i = 1
  local dropdown_index = 1
  for name, _ in pairs(global.landing_pad_names) do
    table.insert(landing_pad_names, name)
    if name == silo_data.destination then
      dropdown_index = i + 2
    end
    i = i + 1
  end

  global.rocket_silo_guis[player.index] = gui.add(player.gui.relative, {
    {
      type = "frame",
      --style = "sp_relative_stretchable_frame",
      name = "ll-rocket-silo-relative-frame",
      direction = "vertical",
      anchor = anchor,
      children = {
        {type = "label", style = "frame_title", caption = {"gui-blueprint.settings"}, ignored_by_interaction = true},
        {type = "frame", direction = "vertical", style = "inside_shallow_frame_with_padding", children = {
          {
            type = "flow",
            direction = "vertical",
            style = "inset_frame_container_vertical_flow",
            children = {
              --{type = "label", caption = "My label"},
              {type = "flow", direction = "vertical", children = {
                {
                  type = "radiobutton", name = "ll-auto-launch-none", caption = "No auto-launch", state = silo_data.auto_launch == "none",
                  handler = {[defines.events.on_gui_checked_state_changed] = RocketSilo.auto_launch_changed},
                },
                {
                  type = "radiobutton", name = "ll-auto-launch-any", caption = "Auto-launch with any cargo", state = silo_data.auto_launch == "any",
                  handler = {[defines.events.on_gui_checked_state_changed] = RocketSilo.auto_launch_changed},
                },
                {
                  type = "radiobutton", name = "ll-auto-launch-full", caption = "Auto-launch when cargo full", state = silo_data.auto_launch == "full",
                  handler = {[defines.events.on_gui_checked_state_changed] = RocketSilo.auto_launch_changed},
                },
              }},
              {
                type = "drop-down", name = "ll-destination-dropdown", caption = "Destination",
                items = landing_pad_names, selected_index = dropdown_index,
                handler = {[defines.events.on_gui_selection_state_changed] = RocketSilo.destination_changed},
                visible = silo.name ~= "ll-rocket-silo-interstellar",
              }
            }
          }
        }}
      }
    }
  })
end

function RocketSilo.auto_launch_changed(player, element, silo, silo_data, silo_gui_data)
  if element.name == "ll-auto-launch-none" then
    silo_data.auto_launch = "none"
    silo_gui_data["ll-auto-launch-any"].state = false
    silo_gui_data["ll-auto-launch-full"].state = false
  elseif element.name == "ll-auto-launch-any" then
    silo_data.auto_launch = "any"
    silo_gui_data["ll-auto-launch-none"].state = false
    silo_gui_data["ll-auto-launch-full"].state = false
  elseif element.name == "ll-auto-launch-full" then
    silo_data.auto_launch = "full"
    silo_gui_data["ll-auto-launch-none"].state = false
    silo_gui_data["ll-auto-launch-any"].state = false
  end
end

function RocketSilo.destination_changed(player, element, silo, silo_data)
  silo_data.destination = element.get_item(element.selected_index)
  game.print("Changed destination to " .. silo_data.destination)
end


gui.add_handlers(RocketSilo,
  function(event, handler)
    local player = game.players[event.player_index]
    local silo = player.opened
    if not silo or not silo.valid then return end
    local silo_data = global.rocket_silos[silo.unit_number]
    local silo_gui_data = global.rocket_silo_guis[player.index]
    handler(player, event.element, silo, silo_data, silo_gui_data)
  end
)

local function update_gui(player, silo)
  local silo_data = global.rocket_silos[silo.unit_number]
  local gui_elements = global.rocket_silo_guis[player.index]
  gui_elements["ll-auto-launch-none"].state = silo_data.auto_launch == "none"
  gui_elements["ll-auto-launch-any"].state = silo_data.auto_launch == "any"
  gui_elements["ll-auto-launch-full"].state = silo_data.auto_launch == "full"
  gui_elements["ll-destination-dropdown"].visible = silo.name ~= "ll-rocket-silo-interstellar"
end

local function on_gui_opened(event)
  local entity = event.entity
  if not entity or not entity.valid then return end
  if entity.type ~= "rocket-silo" then return end

  local player = game.get_player(event.player_index)

  entity.auto_launch = false

  if player.gui.relative["ll-rocket-silo-relative-frame"] then
    player.gui.relative["ll-rocket-silo-relative-frame"].destroy()
  end

  if not player.gui.relative["ll-rocket-silo-relative-frame"] then
    build_gui(player, entity)
  else
    update_gui(player, entity)
  end
end

local function on_gui_closed(event)
  local entity = event.entity
  if not entity or not entity.valid then return end
  if entity.type ~= "rocket-silo" then return end

  entity.auto_launch = false
end

local function on_rocket_silo_built(event)
  local entity = event.created_entity or event.entity
  if entity.type ~= "rocket-silo" then return end

  if entity.name == "rocket-silo" and entity.surface.name == "luna" then
    local new_entity = entity.surface.create_entity{
      name = "ll-rocket-silo-down",
      position = entity.position,
      force = entity.force,
      create_build_effect_smoke = false,
    }
    entity.destroy()
    entity = new_entity
  elseif entity.name == "ll-rocket-silo-down" and entity.surface.name == "nauvis" then
    local new_entity = entity.surface.create_entity{
      name = "rocket-silo",
      position = entity.position,
      force = entity.force,
      create_build_effect_smoke = false,
    }
    entity.destroy()
    entity = new_entity
  end


  global.rocket_silos[entity.unit_number] = {
    entity = entity,
    auto_launch = "none",  -- "none", "any", "full"
    destination = "Space",
  }
end

local function on_tick()
  for unit_number, silo_data in pairs(global.rocket_silos) do
    local silo = silo_data.entity
    if not silo.valid then
      global.rocket_silos[unit_number] = nil
    else
      if silo.rocket_silo_status == defines.rocket_silo_status.rocket_ready then
        if silo_data.auto_launch == "any" then
          local inventory = silo.get_inventory(defines.inventory.rocket_silo_rocket)
          if not inventory.is_empty() then
            silo.launch_rocket()
          end
        elseif silo_data.auto_launch == "full" then
          local inventory = silo.get_inventory(defines.inventory.rocket_silo_rocket)
          if inventory.is_full() then
            silo.launch_rocket()
          end
        end
      end
    end
  end
end

local function on_rocket_launch_ordered(event)
  local silo = event.rocket_silo

  -- Remove interstellar satellite from rocket if it isn't an interstellar rocket
  if silo.name == "ll-rocket-silo-interstellar" then return end
  local inventory = event.rocket.get_inventory(defines.inventory.rocket)
  local rocket_stack = inventory[1]
  if not (rocket_stack and rocket_stack.valid_for_read) then return end

  if rocket_stack.name == "ll-interstellar-satellite" then
    rocket_stack.clear()
  end
end

local function spiral_next(input)
  local x = input.x
  local y = input.y
  local output = {x = x, y = y}

  if x > y and x >= -y then
    output.y = y + 1
  elseif -y >= -x and -y > x then
    output.x = x + 1
  elseif -x > y and -x > -y then
    output.y = y - 1
  elseif y >= -x and y > x then
    output.x = x - 1
  else
    output.x = x - 1
  end

  return output
end

local function spill_rocket(surface, inventory, rocket_parts)
  for i = 1, #inventory do
    local stack = inventory[i]
    if stack and stack.valid_for_read then
      surface.spill_item_stack({0, 0}, stack, false, nil, false)
    end
  end
  if rocket_parts and rocket_parts > 0 then
    surface.spill_item_stack({0, 0}, {name = "ll-used-rocket-part", count = rocket_parts}, false, nil, false)
  end

end

local function land_rocket(surface, inventory, landing_pad_name, rocket_parts)
  local landing_pads = global.landing_pad_names[landing_pad_name]
  if not landing_pads then
    spill_rocket(surface, inventory, rocket_parts)
    return
  end
  local landing_pad_unit_number, _ = next(landing_pads)
  local landing_pad = global.landing_pads[landing_pad_unit_number]
  if not (landing_pad and landing_pad.entity.valid) then
    spill_rocket(surface, inventory, rocket_parts)
    return
  end
  local pad_inventory = landing_pad.entity.get_inventory(defines.inventory.chest)
  for i = 1, #inventory do
    local stack = inventory[i]
    if stack and stack.valid_for_read then
      pad_inventory.insert(stack)
    end
  end
  if rocket_parts and rocket_parts > 0 then
    pad_inventory.insert{name = "ll-used-rocket-part", count = rocket_parts}
  end

end

local function on_rocket_launched(event)
  local silo = event.rocket_silo
  if silo.name == "rocket-silo" then
    local result_inventory = silo.get_inventory(defines.inventory.rocket_silo_result)
    result_inventory.insert{name = "ll-used-rocket-part", count = 10}
  elseif silo.name == "ll-rocket-silo-interstellar" then
    -- Win the game
    if game.finished or game.finished_but_continuing then return end
    game.set_game_state{
      game_finished = true,
      player_won = true,
      can_continue = true,
      victorious_force = rocket.force
    }
  end

  local inventory = event.rocket.get_inventory(defines.inventory.rocket)

  local silo_data = global.rocket_silos[silo.unit_number]
  if silo_data.destination == "Space" then
    if inventory.get_item_count("satellite") >= 1 then
      if silo.name == "rocket-silo" then
        game.print("Satellite launched!")
        local satellites_launched = (global.satellites_launched[silo.force.name] or 0) + 1
        global.satellites_launched[silo.force.name] = satellites_launched
        local position = global.satellite_cursors[silo.force.name] or {x = 0, y = 0}
        for i = 1, 27 do
          while silo.force.is_chunk_charted("luna", position) do
            position = spiral_next(position)
          end
          silo.force.chart("luna", {
            {
              x = position.x * 32,
              y = position.y * 32
            },
            {
              x = (position.x + 0.5) * 32,
              y = (position.y + 0.5) * 32,
            }
          })
          position = spiral_next(position)
        end
        global.satellite_cursors[silo.force.name] = position
      end
      return
    end
  elseif silo_data.destination == "Nauvis Surface" or silo_data.destination == "Luna Surface" then
    local rocket_surface = silo.surface.name
    local surface = game.get_surface(rocket_surface == "nauvis" and "luna" or "nauvis")
    spill_rocket(surface, inventory, silo.name == "ll-rocket-silo-down" and 2 or 0)
  else
    local rocket_surface = silo.surface.name  -- Todo improve
    local surface = game.get_surface(rocket_surface == "nauvis" and "luna" or "nauvis")
    land_rocket(surface, inventory, silo_data.destination, silo.name == "ll-rocket-silo-down" and 2 or 0)
  end
end


RocketSilo.events = {
  [defines.events.on_tick] = on_tick,
  [defines.events.on_gui_opened] = on_gui_opened,
  [defines.events.on_gui_closed] = on_gui_closed,
  [defines.events.on_built_entity] = on_rocket_silo_built,
  [defines.events.on_robot_built_entity] = on_rocket_silo_built,
  [defines.events.script_raised_built] = on_rocket_silo_built,
  [defines.events.script_raised_revive] = on_rocket_silo_built,
  [defines.events.on_rocket_launch_ordered] = on_rocket_launch_ordered,
  [defines.events.on_rocket_launched] = on_rocket_launched,
  --[defines.events.on_script_trigger_effect] = on_rocket_silo_created,
}

local function disable_rocket_victory()
  if remote.interfaces["silo_script"] and remote.interfaces["silo_script"]["set_no_victory"] then
    remote.call("silo_script", "set_no_victory", true)
  end
  if remote.interfaces["freeplay"] and remote.interfaces["freeplay"]["set_custom_intro_message"] then
    remote.call("freeplay", "set_custom_intro_message", {"freight-forwarding.msg-intro"})
  end
end

RocketSilo.on_init = function ()
  global.rocket_silos = {}
  global.rocket_silo_guis = {}
  global.satellites_launched = {}
  global.satellite_cursors = {}
  disable_rocket_victory()
end

RocketSilo.on_configuration_changed = function(changed_data)
  global.rocket_silos = global.rocket_silos or {}
  global.rocket_silo_guis = global.rocket_silo_guis or {}
  global.satellites_launched = global.satellites_launched or {}
  global.satellite_cursors = global.satellite_cursors or {}
  disable_rocket_victory()
end

return RocketSilo
