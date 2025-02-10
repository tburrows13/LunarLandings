local Buckets = require "scripts.buckets"

---@type ScriptLib
local RocketSilo = {}

local rocket_silos = {
  ["rocket-silo"] = true,
  ["ll-rocket-silo-down"] = true,
}

NAUVIS_ROCKET_SILO_PARTS_REQUIRED = 20
LUNA_ROCKET_SILO_PARTS_REQUIRED = 5

local function get_other_surface_name(surface_name)
  return surface_name == "nauvis" and "luna" or "nauvis"
end

local function get_surface_destination_name(silo_surface_name)
  return silo_surface_name == "nauvis" and "Luna Surface" or "Nauvis Surface"
end

local function is_rocket_launching(entity)
  local status = entity.rocket_silo_status
  local status_lookup = {
    [defines.rocket_silo_status.launch_starting] = true,
    [defines.rocket_silo_status.engine_starting] = true,
    [defines.rocket_silo_status.arms_retract] = true,
    [defines.rocket_silo_status.rocket_flying] = true,
    [defines.rocket_silo_status.lights_blinking_close] = true,
    [defines.rocket_silo_status.doors_closing] = true,
    [defines.rocket_silo_status.launch_started] = true,
  }
  return status_lookup[status]
end

local function build_gui(player, silo)
  local silo_data = Buckets.get(storage.rocket_silos, silo.unit_number)

  local anchor = {gui = defines.relative_gui_type.rocket_silo_gui, position = defines.relative_gui_position.right}

  local landing_pad_names = {}
  local surfaces_unlocked = silo.force.technologies["ll-luna-exploration"].researched
  landing_pad_names[1] = get_surface_destination_name(silo.surface.name)
  local i = 1
  local dropdown_index = 1
  for name, _ in pairs(storage.landing_pad_names[get_other_surface_name(silo.surface.name)]) do
    table.insert(landing_pad_names, name)
    if name == silo_data.destination then
      dropdown_index = i + 1
    end
    i = i + 1
  end

  storage.rocket_silo_guis[player.index] = gui.add(player.gui.relative, {
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
              {type = "label", caption = {"gui-rocket-silo.parts-required", silo.prototype.rocket_parts_required}},
              {type = "label", caption = {"gui-rocket-silo.steam-requirement"}, visible = silo.name == "ll-rocket-silo-down"},
              {
                type = "flow", direction = "vertical",
                children = {
                  {
                    type = "label",
                    style = "heading_2_label",
                    caption = {"", {"gui-rocket-silo.auto-launch-title"}, " [img=info]"},
                    tooltip = {"gui-rocket-silo.auto-launch-tooltip"}
                  },
                  {
                    type = "radiobutton", name = "ll-auto-launch-none", caption = {"gui-rocket-silo.auto-launch-none"}, state = silo_data.auto_launch == "none",
                    handler = {[defines.events.on_gui_checked_state_changed] = RocketSilo.auto_launch_changed},
                  },
                  {
                    type = "radiobutton", name = "ll-auto-launch-any", caption = {"gui-rocket-silo.auto-launch-any"}, state = silo_data.auto_launch == "any",
                    handler = {[defines.events.on_gui_checked_state_changed] = RocketSilo.auto_launch_changed},
                  },
                  {
                    type = "radiobutton", name = "ll-auto-launch-full", caption = {"gui-rocket-silo.auto-launch-full"}, state = silo_data.auto_launch == "full",
                    handler = {[defines.events.on_gui_checked_state_changed] = RocketSilo.auto_launch_changed},
                  },
                }
              },
              {
                type = "flow", direction = "vertical", 
                visible = silo.name ~= "ll-rocket-silo-interstellar",
                children = {
                  {
                    type = "label",
                    style = "heading_2_label",
                    caption = {"", {"gui-rocket-silo.destination"}, " [img=info]"},
                    tooltip = {"gui-rocket-silo.destination-tooltip"}
                  },
                  {
                    type = "drop-down", name = "ll-destination-dropdown",
                    items = landing_pad_names,
                    selected_index = dropdown_index,
                    handler = {[defines.events.on_gui_selection_state_changed] = RocketSilo.destination_changed},
                    visible = silo.name ~= "ll-rocket-silo-interstellar",
                    enabled = not is_rocket_launching(silo),
                  }, 
                } 
              },
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
end


gui.add_handlers(RocketSilo,
  function(event, handler)
    local player = game.players[event.player_index]
    local silo = player.opened
    if not silo or not silo.valid then return end
    local silo_data = Buckets.get(storage.rocket_silos, silo.unit_number)
    local silo_gui_data = storage.rocket_silo_guis[player.index]
    handler(player, event.element, silo, silo_data, silo_gui_data)
  end
)

local function update_gui(player, silo)
  -- Currently out of date and unused
  local silo_data = Buckets.get(storage.rocket_silos, silo.unit_number)
  local gui_elements = storage.rocket_silo_guis[player.index]
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

  Buckets.add(storage.rocket_silos, entity.unit_number, {
    entity = entity,
    auto_launch = "none",  -- "none", "any", "full"
    destination = get_surface_destination_name(entity.surface.name),
  })
end

local function get_destination_landing_pad(landing_pad_name, landing_pad_surface_name)
  local landing_pads = storage.landing_pad_names[landing_pad_surface_name][landing_pad_name]
  if not landing_pads then return end

  local landing_pad_unit_number, _ = next(landing_pads)
  local landing_pad = storage.landing_pads[landing_pad_unit_number]
  if not (landing_pad and landing_pad.entity.valid) then
    return
  end
  return landing_pad.entity
end

local function launch_if_destination_has_space(silo_data, ready_stacks)
  local silo = silo_data.entity
  local destination_name = silo_data.destination
  if silo_data.destination == "Space" or silo_data.destination == "Nauvis Surface" or silo_data.destination == "Luna Surface" then
    silo.launch_rocket()
  else
    local destination = get_destination_landing_pad(destination_name, get_other_surface_name(silo.surface.name))
    if not destination then
      return  -- Destination landing pad doesn't exist, so don't autolaunch
    end
    if silo.surface.name == "luna" then
      -- Rockets from Luna deposit rocket parts too
      ready_stacks = ready_stacks + LUNA_ROCKET_SILO_PARTS_REQUIRED
    end
    local inventory = destination.get_inventory(defines.inventory.chest)
    if inventory.count_empty_stacks(false, false) >= ready_stacks then
      silo.launch_rocket()
    end
  end
end

local function on_tick(event)
  for unit_number, silo_data in pairs(Buckets.get_bucket(storage.rocket_silos, event.tick)) do
    local silo = silo_data.entity
    if not silo.valid then
      Buckets.remove(storage.rocket_silos, unit_number)
    else
      if silo.rocket_silo_status == defines.rocket_silo_status.rocket_ready then
        if silo_data.auto_launch == "any" then
          local inventory = silo.get_inventory(defines.inventory.rocket_silo_rocket)
          if not inventory.is_empty() then
            launch_if_destination_has_space(silo_data, #inventory - inventory.count_empty_stacks(true, true))
          end
        elseif silo_data.auto_launch == "full" then
          local inventory = silo.get_inventory(defines.inventory.rocket_silo_rocket)
          if inventory.is_full() then
            launch_if_destination_has_space(silo_data, #inventory)
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
  local inventory = event.rocket.cargo_pod.get_inventory(defines.inventory.cargo_unit)
  local removed = inventory.remove({name = "ll-interstellar-satellite", count = 100})
  if removed > 0 then
    game.print({"ll-console-info.interstellar-satellite-removed"})
  end

  for player_index, _ in pairs(game.players) do
    local gui_elements = storage.rocket_silo_guis[player_index]
    if gui_elements then
      gui_elements["ll-destination-dropdown"].enabled = false
    end
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
      surface.spill_item_stack{
        position = {0, 0},
        stack = stack,
        allow_belts = false,
      }
      game.print({"ll-console-info.rocket-contents-landed", "[gps=0,0," .. surface.name .. "]"})
    end
  end
  if rocket_parts and rocket_parts > 0 then
    surface.spill_item_stack{
      position = {0, 0},
      stack = {name = "ll-used-rocket-part", count = rocket_parts},
      allow_belts = false,
    }
  end
end


local function land_rocket(surface, inventory, landing_pad_name, rocket_parts)
  local landing_pad = get_destination_landing_pad(landing_pad_name, surface.name)
  if not landing_pad then
    spill_rocket(surface, inventory, rocket_parts)
    return
  end
  local pad_inventory = landing_pad.get_inventory(defines.inventory.chest)
  for i = 1, #inventory do
    local stack = inventory[i]
    if stack and stack.valid_for_read then
      local inserted = pad_inventory.insert(stack)
      if inserted < stack.count then
        surface.spill_item_stack{
          position = landing_pad.position,
          stack = {name = stack.name, count = stack.count - inserted},
          allow_belts = false,
        }
      end
    end
  end
  if rocket_parts and rocket_parts > 0 and landing_pad.force.technologies["ll-used-rocket-part-recycling"].researched then
    local inserted = pad_inventory.insert{name = "ll-used-rocket-part", count = rocket_parts}
    if inserted < rocket_parts then
      surface.spill_item_stack{
        position = landing_pad.position,
        stack = {name = "ll-used-rocket-part", count = rocket_parts - inserted},
        allow_belts = false,
      }
    end
  end
end

local function on_rocket_launched(event)
  local silo = event.rocket_silo
  if silo.name == "rocket-silo" then
    silo.force.technologies["ll-luna-exploration"].researched = true
    --if silo.force.technologies["ll-used-rocket-part-recycling"].researched then  -- TODO 2.0
    --  local result_inventory = silo.get_inventory(defines.inventory.rocket_silo_result)
    --  result_inventory.insert{name = "ll-used-rocket-part", count = NAUVIS_ROCKET_SILO_PARTS_REQUIRED}
    --end
  elseif silo.name == "ll-rocket-silo-interstellar" then
    local rocket = event.rocket
    if not (rocket and rocket.valid) then return end

    -- Win the game
    if game.finished or game.finished_but_continuing or storage.finished then return end
    storage.finished = true
    
    game.set_game_state{
      game_finished = true,
      player_won = true,
      can_continue = true,
    }

  end

  local inventory = event.rocket.cargo_pod.get_inventory(defines.inventory.cargo_unit)

  local silo_data = Buckets.get(storage.rocket_silos, silo.unit_number)
  if silo_data.destination == "Space" then
    if inventory.get_item_count("satellite") >= 1 then
      if silo.name == "rocket-silo" then
        local force_name = silo.force.name
        local satellites_launched = storage.satellites_launched[force_name] or 0
        if satellites_launched == 0 then
          if game.is_multiplayer() then
            game.print({"ll-console-info.first-satellite-launched"})
          else
            game.show_message_dialog{text = {"ll-console-info.first-satellite-launched"}}
          end
          if script.active_mods["UltimateResearchQueue"] or script.active_mods["UltimateResearchQueueFiltered"] then
            game.print({"ll-console-info.first-satellite-launched-urq-hint"})
          end
          game.print({"ll-console-info.new-destination-unlocked"})
          silo.force.technologies["ll-luna-exploration"].enabled = true
        end
        storage.satellites_launched[silo.force.name] = satellites_launched + 1
        if satellites_launched > 0 then
          local position = storage.satellite_cursors[silo.force.name] or {x = 0, y = 0}
          for i = 1, 300 do
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
            storage.satellite_cursors[silo.force.name] = position
          end
        end
      end
    end
  elseif silo_data.destination == "Nauvis Surface" or silo_data.destination == "Luna Surface" then
    local rocket_surface = silo.surface.name
    local surface = game.get_surface(get_other_surface_name(rocket_surface))
    spill_rocket(surface, inventory, silo.name == "ll-rocket-silo-down" and LUNA_ROCKET_SILO_PARTS_REQUIRED or 0)
  else
    local rocket_surface = silo.surface.name
    local surface = game.get_surface(get_other_surface_name(rocket_surface))
    land_rocket(surface, inventory, silo_data.destination, silo.name == "ll-rocket-silo-down" and LUNA_ROCKET_SILO_PARTS_REQUIRED or 0)
  end
  for player_index, _ in pairs(game.players) do
    local gui_elements = storage.rocket_silo_guis[player_index]
    if gui_elements then
      gui_elements["ll-destination-dropdown"].enabled = true
    end
  end
end

local function on_research_finished(event)
  if event.by_script then return end
  local technology = event.research
  if technology.name == "ll-luna-exploration" then
    if game.is_multiplayer() then
      game.print({"ll-console-info.luna-exploration-researched"})
    else
      game.show_message_dialog{text = {"ll-console-info.luna-exploration-researched"}}
    end
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
  [defines.events.on_research_finished] = on_research_finished,
  --[defines.events.on_script_trigger_effect] = on_rocket_silo_created,
}

local function disable_rocket_victory()
  for _, interface in pairs{"silo_script", "better-victory-screen"} do
    if remote.interfaces[interface] and remote.interfaces[interface]["set_no_victory"] then
      remote.call(interface, "set_no_victory", true)
    end
  end
  --if remote.interfaces["freeplay"] and remote.interfaces["freeplay"]["set_custom_intro_message"] then
  --  remote.call("freeplay", "set_custom_intro_message", {"freight-forwarding.msg-intro"})
  --end  // TODO
end

RocketSilo.on_init = function ()
  storage.rocket_silos = Buckets.new()
  storage.rocket_silo_guis = {}
  storage.satellite_cursors = {}
  disable_rocket_victory()

  for _, surface in pairs(game.surfaces) do
    for _, silo in pairs(surface.find_entities_filtered{type = "rocket-silo"}) do
      on_rocket_silo_built({created_entity = silo})
    end
  end
end

RocketSilo.on_configuration_changed = function(changed_data)
  storage.rocket_silos = storage.rocket_silos or {}
  storage.rocket_silo_guis = storage.rocket_silo_guis or {}
  storage.satellite_cursors = storage.satellite_cursors or {}
  disable_rocket_victory()
end

return RocketSilo
