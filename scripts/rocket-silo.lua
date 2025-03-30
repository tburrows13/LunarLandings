local Buckets = require "scripts.buckets"

---@alias AutoLaunch "none" | "full" | "circuit"

---@class RocketSiloData
---@field entity LuaEntity
---@field auto_launch AutoLaunch
---@field destination SurfaceName

local RocketSilo = {}

local NAUVIS_ROCKET_SILO = SPACE_AGE and "ll-rocket-silo-up" or "rocket-silo"

NAUVIS_ROCKET_SILO_PARTS_REQUIRED = 20
LUNA_ROCKET_SILO_PARTS_REQUIRED = 5

local function get_other_surface_name(surface_name)
  return surface_name == "nauvis" and "luna" or "nauvis"
end

local function get_surface_destination_name(silo_surface_name)
  return silo_surface_name == "nauvis" and "Luna Surface" or "Nauvis Surface"
end

local function build_gui(player, silo)
  local silo_data = Buckets.get(storage.rocket_silos, silo.unit_number)

  local anchor = {
    gui = defines.relative_gui_type.rocket_silo_gui,
    names = {
      NAUVIS_ROCKET_SILO,
      "ll-rocket-silo-down",
      "ll-rocket-silo-interstellar"
    },
    position = defines.relative_gui_position.right
  }

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
                    type = "radiobutton", name = "ll-auto-launch-none", caption = {"gui-rocket-silo.auto-launch-none"},
                    state = silo_data.auto_launch == "none",
                    handler = {[defines.events.on_gui_checked_state_changed] = RocketSilo.auto_launch_changed},
                  },
                  {
                    type = "radiobutton", name = "ll-auto-launch-full", caption = {"gui-rocket-silo.auto-launch-full"},
                    state = silo_data.auto_launch == "full",
                    handler = {[defines.events.on_gui_checked_state_changed] = RocketSilo.auto_launch_changed},
                  },
                  {
                    type = "radiobutton", name = "ll-auto-launch-circuit", caption = {"", {"gui-rocket-silo.auto-launch-circuit"}, " [img=info]"},
                    tooltip = {"gui-rocket-silo.auto-launch-circuit-tooltip"},
                    state = silo_data.auto_launch == "circuit",
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
    silo_gui_data["ll-auto-launch-full"].state = false
    silo_gui_data["ll-auto-launch-circuit"].state = false
  elseif element.name == "ll-auto-launch-full" then
    silo_data.auto_launch = "full"
    silo_gui_data["ll-auto-launch-none"].state = false
    silo_gui_data["ll-auto-launch-circuit"].state = false
  elseif element.name == "ll-auto-launch-circuit" then
    silo_data.auto_launch = "circuit"
    silo_gui_data["ll-auto-launch-none"].state = false
    silo_gui_data["ll-auto-launch-full"].state = false
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
  gui_elements["ll-auto-launch-full"].state = silo_data.auto_launch == "full"
  gui_elements["ll-auto-launch-circuit"].state = silo_data.auto_launch == "circuit"
  gui_elements["ll-destination-dropdown"].visible = silo.name ~= "ll-rocket-silo-interstellar"
end

---@param event EventData.on_gui_opened
local function on_gui_opened(event)
  local entity = event.entity
  if not entity or not entity.valid then return end
  if entity.type ~= "rocket-silo" then return end

  local player = game.get_player(event.player_index)  ---@cast player -?

  if player.gui.relative["ll-rocket-silo-relative-frame"] then
    player.gui.relative["ll-rocket-silo-relative-frame"].destroy()
  end

  if not player.gui.relative["ll-rocket-silo-relative-frame"] then
    build_gui(player, entity)
  else
    update_gui(player, entity)
  end
end

---@param event EventData.on_gui_closed
local function on_gui_closed(event)
  local entity = event.entity
  if not entity or not entity.valid then return end
  if entity.type ~= "rocket-silo" then return end
end

local function on_rocket_silo_built(event)
  local entity = event.entity
  if entity.type ~= "rocket-silo" then return end

  if entity.name == NAUVIS_ROCKET_SILO and entity.surface.name == "luna" then
    local new_entity = entity.surface.create_entity{
      name = "ll-rocket-silo-down",
      position = entity.position,
      force = entity.force,
      create_build_effect_smoke = false,
    }  ---@cast new_entity -?
    entity.destroy()
    entity = new_entity
  elseif entity.name == "ll-rocket-silo-down" and entity.surface.name == "nauvis" then
    local new_entity = entity.surface.create_entity{
      name = NAUVIS_ROCKET_SILO,
      position = entity.position,
      force = entity.force,
      create_build_effect_smoke = false,
    }  ---@cast new_entity -?
    entity.destroy()
    entity = new_entity
  end

  Buckets.add(storage.rocket_silos, entity.unit_number, {
    entity = entity,
    auto_launch = "none",  -- "none", "full", "circuit"
    destination = get_surface_destination_name(entity.surface.name),
  })
end

---@param landing_pad_name LandingPadName
---@param landing_pad_surface_name SurfaceName
---@return LandingPadData?
local function get_destination_landing_pad(landing_pad_name, landing_pad_surface_name)
  local landing_pads = storage.landing_pad_names[landing_pad_surface_name][landing_pad_name]
  if not landing_pads then return end

  local landing_pad_unit_number, _ = next(landing_pads)
  local landing_pad_data = storage.landing_pads[landing_pad_unit_number]
  if not (landing_pad_data and landing_pad_data.entity.valid) then
    return
  end
  return landing_pad_data
end

local function launch_if_destination_has_space(silo_data, ready_stacks)
  local silo = silo_data.entity
  local destination_name = silo_data.destination
  if silo_data.destination == "Nauvis Surface" or silo_data.destination == "Luna Surface" then
    silo.launch_rocket()
  else
    local destination_data = get_destination_landing_pad(destination_name, get_other_surface_name(silo.surface.name))
    if not destination_data then
      return  -- Destination landing pad doesn't exist, so don't autolaunch
    end
    if next(destination_data.cargo_pods_targeting) then
      return  -- There's already a cargo pod en route to the destination, so don't autolaunch
    end
    if silo.surface.name == "luna" then
      -- Rockets from Luna deposit rocket parts too
      ready_stacks = ready_stacks + LUNA_ROCKET_SILO_PARTS_REQUIRED
    end
    local inventory = destination_data.entity.get_inventory(defines.inventory.chest)  ---@cast inventory -?
    if inventory.count_empty_stacks(false, false) >= ready_stacks then
      silo.launch_rocket()
    end
  end
end

local function get_weight(inventory)
  local weight = 0
  local item_prototypes = prototypes.item
  for _, get_contents_data in pairs(inventory.get_contents()) do
    local item_prototype = item_prototypes[get_contents_data.name]
    weight = weight + (item_prototype.weight * get_contents_data.count)
  end
  return weight
end

local function inventory_has_weight_capacity_remaining(inventory)
  local weight = get_weight(inventory)
  local spare_weight = 1000000 - weight
  local item_1 = inventory.get_contents()[1]
  if item_1 then
    local item_prototype = prototypes.item[item_1.name]
    if spare_weight < item_prototype.weight then
      return false
    end
  end
  return true
end

---@param event EventData.on_tick
local function on_tick(event)
  for _, cargo_pod in pairs(storage.cargo_pods_to_delete or {}) do
    if cargo_pod.valid then
      cargo_pod.destroy()
    end
  end
  storage.cargo_pods_to_delete = {}

  for unit_number, silo_data in pairs(Buckets.get_bucket(storage.rocket_silos, event.tick)) do
    local silo = silo_data.entity
    if not silo.valid then
      Buckets.remove(storage.rocket_silos, unit_number)
    else
      if silo.rocket_silo_status == defines.rocket_silo_status.rocket_ready then
        if silo_data.auto_launch == "full" then
          local inventory = silo.get_inventory(defines.inventory.rocket_silo_rocket)
          if not inventory_has_weight_capacity_remaining(inventory) or inventory.is_full() then
            launch_if_destination_has_space(silo_data, #inventory - inventory.count_empty_stacks())
          end
        elseif silo_data.auto_launch == "circuit" then
          local launch_signal = silo.get_signal({type="virtual", name="signal-check"}, defines.wire_connector_id.circuit_red, defines.wire_connector_id.circuit_green)
          if launch_signal > 0 then
            local inventory = silo.get_inventory(defines.inventory.rocket_silo_rocket)
            launch_if_destination_has_space(silo_data, #inventory - inventory.count_empty_stacks(true, true))
          end
        end
      end
    end
  end
end

---@param event EventData.on_rocket_launch_ordered
local function on_rocket_launch_ordered(event)
  local silo = event.rocket_silo

  if BASE_ONLY then
    -- Remove interstellar satellite from rocket if it isn't an interstellar rocket
    if silo.name == "ll-rocket-silo-interstellar" then return end
    local inventory = event.rocket.cargo_pod.get_inventory(defines.inventory.cargo_unit)  ---@cast inventory -?
    local removed = inventory.remove({name = "ll-interstellar-satellite", count = 100})
    if removed > 0 then
      game.print({"ll-console-info.interstellar-satellite-removed"})
    end
  end

  local silo_data = Buckets.get(storage.rocket_silos, silo.unit_number)
  if not silo_data then return end
  local destination_name = silo_data.destination
  local cargo_pod = event.rocket.cargo_pod  ---@cast cargo_pod -?

  if silo_data.destination == "Nauvis Surface" then
    cargo_pod.cargo_pod_destination = {type = defines.cargo_destination.surface, surface = "nauvis"}
    return
  elseif silo_data.destination == "Luna Surface" then
    cargo_pod.cargo_pod_destination = {type = defines.cargo_destination.surface, surface = "luna"}
    return
  end
  -- todo test empty rocket
  local destination_data = get_destination_landing_pad(destination_name, get_other_surface_name(silo.surface.name))
  if not destination_data then
    cargo_pod.cargo_pod_destination = {
      type = defines.cargo_destination.surface,
      surface = get_other_surface_name(silo.surface.name)
    }
  else
    local landing_pad_position = destination_data.entity.position
    cargo_pod.cargo_pod_destination = {
      type = defines.cargo_destination.surface,
      surface = get_other_surface_name(silo.surface.name),
      position = {x = landing_pad_position.x-0.2, y = landing_pad_position.y - 1.7},
      land_at_exact_position = true,
    }
    storage.cargo_pod_destinations[cargo_pod.unit_number] = destination_data.entity.unit_number
    LandingPad.register_targeting_cargo_pod(destination_data.entity.unit_number, cargo_pod)
  end

end

---@param event EventData.on_rocket_launched
local function on_rocket_launched(event)
  local rocket = event.rocket
  if BASE_ONLY and rocket.name == "ll-interstellar-rocket" then
    -- Win the game
    if game.finished or game.finished_but_continuing or storage.finished then return end
    storage.finished = true
    if remote.interfaces["better-victory-screen"] and remote.interfaces["better-victory-screen"]["trigger_victory"] then
      remote.call("better-victory-screen", "trigger_victory", rocket.force)
    else
      game.set_game_state{
        game_finished = true,
        player_won = true,
        can_continue = true,
        victorious_force = rocket.force
      }
    end

    local cargo_pod = event.rocket.cargo_pod  ---@cast cargo_pod -?
    local inventory = event.rocket.cargo_pod.get_inventory(defines.inventory.cargo_unit)  ---@cast inventory -?
    if inventory.get_item_count("ll-interstellar-satellite") > 0 then
      if not rocket.force.technologies["space-science-pack"].researched then
        rocket.force.technologies["space-science-pack"].researched = true
      end
      inventory.remove({name = "ll-interstellar-satellite", count = 100})
      inventory.insert({name = "space-science-pack", count= 1000})
      cargo_pod.cargo_pod_destination = {type = defines.cargo_destination.surface, surface = "nauvis"}
    end
    return
  end

  if rocket.name == "rocket-silo-rocket" and not rocket.force.technologies["ll-luna-exploration"].researched then
    local inventory = event.rocket.cargo_pod.get_inventory(defines.inventory.cargo_unit)  ---@cast inventory -?
    if inventory.get_item_count("ll-landing-pad") > 0 then
      rocket.force.technologies["ll-luna-exploration"].researched = true
    end
  end

  if rocket.name == "rocket-silo-rocket" and rocket.force.technologies["ll-reusable-rockets"].researched then
    if rocket.surface.name == "nauvis" then
      local return_cargo_pod = rocket.surface.create_entity{
        name = "ll-rocket-part-cargo-pod",
        position = rocket.position,
        force = rocket.force,
        create_build_effect_smoke = false,
      }   ---@cast return_cargo_pod -?
      local return_inventory = return_cargo_pod.get_inventory(defines.inventory.cargo_unit)  ---@cast return_inventory -?
      return_inventory.insert({name = "ll-used-rocket-part", count = NAUVIS_ROCKET_SILO_PARTS_REQUIRED})
      return_cargo_pod.cargo_pod_destination = {type = defines.cargo_destination.surface, surface = "nauvis"}
      return_cargo_pod.force_finish_ascending()
    elseif rocket.surface.name == "luna" then
      local inventory = event.rocket.cargo_pod.get_inventory(defines.inventory.cargo_unit)  ---@cast inventory -?
      inventory.insert({name = "ll-used-rocket-part", count = LUNA_ROCKET_SILO_PARTS_REQUIRED})
    end
  end
end

---@param event EventData.on_research_finished
local function on_research_finished(event)
  if event.by_script then return end
  local technology = event.research
  if technology.name == (BASE_ONLY and "rocket-silo" or "ll-luna-rocket-silo") then
    if game.is_multiplayer() then
      game.print({"ll-console-info.rocket-silo-research-complete"})
    else
      game.show_message_dialog{text = {"ll-console-info.rocket-silo-research-complete"}}
    end
  elseif technology.name == "ll-luna-exploration" then
    if game.is_multiplayer() then
      game.print({"ll-console-info.luna-exploration-researched"})
    else
      game.show_message_dialog{text = {"ll-console-info.luna-exploration-researched"}}
    end
  end
end

---@param event EventData.on_cargo_pod_delivered_cargo
local function on_cargo_pod_finished_descending(event)
  local cargo_pod = event.cargo_pod
  local destination_unit_number = storage.cargo_pod_destinations[cargo_pod.unit_number]
  if not destination_unit_number then return end
  local destination_data = storage.landing_pads[destination_unit_number]
  if not (destination_data and destination_data.entity.valid) then return end
  local cargo_pod_inventory = cargo_pod.get_inventory(defines.inventory.cargo_unit)  ---@cast cargo_pod_inventory -?
  local landing_pad_inventory = destination_data.entity.get_inventory(defines.inventory.chest)  ---@cast landing_pad_inventory -?
  for i = 1, #cargo_pod_inventory do
    local stack = cargo_pod_inventory[i]
    if stack and stack.valid_for_read then
      local inserted = landing_pad_inventory.insert(stack)
      if inserted < stack.count then
        stack.count = stack.count - inserted
        cargo_pod.surface.spill_item_stack{
          position = destination_data.entity.position,
          stack = stack,
          allow_belts = false,
        }
      end
    end
  end
  storage.cargo_pod_destinations[cargo_pod.unit_number] = nil
  LandingPad.unregister_targeting_cargo_pod(destination_unit_number, cargo_pod)
  cargo_pod.destroy()
  if event.spawned_container then event.spawned_container.destroy() end
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
  [defines.events.on_cargo_pod_finished_descending] = on_cargo_pod_finished_descending,
  [defines.events.on_research_finished] = on_research_finished,
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
  ---@type Buckets<UnitNumber, RocketSiloData>
  storage.rocket_silos = Buckets.new()
  storage.rocket_silo_guis = {}
  ---@type table<UnitNumber, UnitNumber>
  storage.cargo_pod_destinations = {}
  disable_rocket_victory()

  for _, surface in pairs(game.surfaces) do
    for _, silo in pairs(surface.find_entities_filtered{type = "rocket-silo"}) do
      on_rocket_silo_built({entity = silo})
    end
  end
end

RocketSilo.on_configuration_changed = function(changed_data)
  storage.rocket_silos = storage.rocket_silos or {}
  storage.rocket_silo_guis = storage.rocket_silo_guis or {}
  storage.cargo_pod_destinations = storage.cargo_pod_destinations or {}
  disable_rocket_victory()
end

return RocketSilo
