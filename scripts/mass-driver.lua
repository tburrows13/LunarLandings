local Buckets = require "scripts.buckets"

---@type ScriptLib
local MassDriver = {}

local format_energy = function(energy)
  return string.format("%.2f", energy / 1000000) .. "MJ"
end

local function build_gui(player, mass_driver)
  local mass_driver_data = Buckets.get(storage.mass_drivers, mass_driver.unit_number)

  local anchor = {gui = defines.relative_gui_type.container_gui, position = defines.relative_gui_position.right}

  local mass_driver_requester_names = {[1] = "None"}
  local i = 1
  local dropdown_index = 1
  for name, _ in pairs(storage.mass_driver_requester_names) do
    table.insert(mass_driver_requester_names, name)
    if name == mass_driver_data.destination then
      dropdown_index = i + 1
    end
    i = i + 1
  end

  storage.mass_driver_guis[player.index] = gui.add(player.gui.relative, {
    {
      type = "frame",
      --style = "sp_relative_stretchable_frame",
      name = "ll-mass-driver-relative-frame",
      direction = "vertical",
      anchor = anchor,
      children = {
        {type = "label", style = "frame_title", caption = {"gui-blueprint.settings"}, ignored_by_interaction = true},
        {type = "frame", name = "ll-mass-driver-inner-frame", direction = "vertical", style = "inside_shallow_frame_with_padding", children = {
          {
            type = "flow",
            direction = "vertical",
            style = "inset_frame_container_vertical_flow",
              name = "ll-mass-driver-info-flow",
            children = {
              {
                type = "flow", direction = "vertical", name = "ll-mass-driver-energy-flow",
                children = {
                  {
                    type = "label",
                    style = "heading_2_label",
                    caption = {"description.energy"},
                    --tooltip = {"gui-rocket-silo.destination-tooltip"}
                  },
                  {
                    type = "label",
                    --style = "heading_2_label",
                    --caption = {"", {"gui-rocket-silo.destination"}, " [img=info]"},
                    caption = format_energy(mass_driver_data.energy_source.energy) .. "/200MJ",
                    --tooltip = {"gui-rocket-silo.destination-tooltip"}
                      name = "ll-mass-driver-energy-label",
                  },
                } 
              },
              {
                type = "flow", direction = "vertical", 
                children = {
                  {
                    type = "label",
                    style = "heading_2_label",
                    caption = {"gui-rocket-silo.destination"},
                    --caption = {"", {"gui-rocket-silo.destination"}, " [img=info]"},
                    --tooltip = {"gui-rocket-silo.destination-tooltip"}
                  },
                  {
                    type = "drop-down", name = "ll-destination-dropdown",
                    items = mass_driver_requester_names,
                    selected_index = dropdown_index,
                    handler = {[defines.events.on_gui_selection_state_changed] = MassDriver.mass_driver_destination_changed},
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

function MassDriver.mass_driver_destination_changed(player, element, mass_driver, mass_driver_data)
  mass_driver_data.destination = element.get_item(element.selected_index)
  MassDriver.update_mass_driver(mass_driver, mass_driver_data)
end


gui.add_handlers(MassDriver,
  function(event, handler)
    local player = game.players[event.player_index]
    local mass_driver = player.opened
    if not mass_driver or not mass_driver.valid then return end
    local mass_driver_data = Buckets.get(storage.mass_drivers, mass_driver.unit_number)
    local mass_driver_gui_data = storage.mass_driver_guis[player.index]
    handler(player, event.element, mass_driver, mass_driver_data, mass_driver_gui_data)
  end
)

--[[
local function update_gui(player, mass_driver)
  -- Currently out of date and unused
  local mass_driver_data = Buckets.get(storage.mass_drivers, mass_driver.unit_number)
  local gui_elements = storage.mass_driver_guis[player.index]
  gui_elements["ll-auto-launch-none"].state = mass_driver_data.auto_launch == "none"
  gui_elements["ll-auto-launch-any"].state = mass_driver_data.auto_launch == "any"
  gui_elements["ll-auto-launch-full"].state = mass_driver_data.auto_launch == "full"
  gui_elements["ll-destination-dropdown"].visible = mass_driver.name ~= "ll-rocket-silo-interstellar"
end
]]

local is_container = {
  ["container"] = true,
  ["logistic-container"] = true,
  ["infinity-container"] = true,
}
local function on_gui_opened(event)
  local entity = event.entity
  if not entity or not entity.valid then return end
  local player = game.get_player(event.player_index)
  if is_container[entity.type] then
    -- on_gui_closed doesn't always fire when exiting the GUI
    if player.gui.relative["ll-mass-driver-relative-frame"] then
      player.gui.relative["ll-mass-driver-relative-frame"].destroy()
    end
    if player.gui.relative["ll-mass-driver-requester-relative-frame"] then
      player.gui.relative["ll-mass-driver-requester-relative-frame"].destroy()
    end    
  end
  if entity.name ~= "ll-mass-driver" then return end


  if not player.gui.relative["ll-mass-driver-relative-frame"] then
    build_gui(player, entity)
  --else
    --update_gui(player, entity)
  end
end

local function on_gui_closed(event)
  local entity = event.entity
  if not entity or not entity.valid then return end
  if entity.name ~= "ll-mass-driver" then return end
  local player = game.get_player(event.player_index)

  if player.gui.relative["ll-mass-driver-relative-frame"] then
    player.gui.relative["ll-mass-driver-relative-frame"].destroy()
  end
end

local function on_mass_driver_built(event)
  local entity = event.created_entity or event.entity
  if not entity.valid or entity.name ~= "ll-mass-driver" then return end

  entity.get_inventory(defines.inventory.chest).set_filter(1, "ll-mass-driver-capsule")
  local logistic_section = get_logistic_section(entity)
  logistic_section.set_slot(1, {
    value = {
      name = "ll-mass-driver-capsule",
      type = "item",
      comparator = "=",
      quality = "normal",
    },
    min = 50,
    import_from = "nauvis"         -- the mass driver is only used for nauvis-luna connection. we can assume this to be a constant
  })

  local energy_source = entity.surface.create_entity{
    name = "ll-mass-driver-energy-source",
    position = entity.position,
    force = entity.force,
  }

  Buckets.add(storage.mass_drivers, entity.unit_number, {
    entity = entity,
    energy_source = energy_source,
    destination = nil,
  })
  script.register_on_object_destroyed(entity)
end

local function on_object_destroyed(event)
  local entity_data = Buckets.get(storage.mass_drivers, event.useful_id)
  if not entity_data then return end

  if entity_data.energy_source.valid then
    entity_data.energy_source.destroy()
  end
  
end

local function get_destination_mass_driver_requester(mass_driver_requester_name)
  local mass_driver_requesters = storage.mass_driver_requester_names[mass_driver_requester_name]
  if not mass_driver_requesters then return end

  local mass_driver_requester_unit_number, _ = next(mass_driver_requesters)
  local mass_driver_requester = storage.mass_driver_requesters[mass_driver_requester_unit_number]
  if not (mass_driver_requester and mass_driver_requester.entity.valid) then
    return
  end
  return mass_driver_requester.entity
end

-- Each update, perform 2 functions:
-- 1
-- Check the destination requests, and compare with current items and requests
-- 2
-- If we have a complete stack, launch to destination

function is_allowed(item_name)
  if item_name == "ll-lunar-foundation" then return true end
  local prototype = prototypes.item[item_name]
  if prototype.place_result then return true end
  if prototype.place_as_equipment_result then return true end
  if prototype.module_effects then return true end
  if prototype.capsule_action and prototype.capsule_action.type == "destroy-cliffs" then return true end
  if prototype.flags and prototype.flags.spawnable then return true end -- blueprint books, deconstruction planners, spidertron remote, etc
  return false
end

function MassDriver.kaboom(mass_driver)
  mass_driver.surface.play_sound{
    path = "ll-mass-driver-kaboom",
    position = mass_driver.position,
  }
end

function MassDriver.update_mass_driver(mass_driver, mass_driver_data)
  local requester = get_destination_mass_driver_requester(mass_driver_data.destination)
  if not requester then
    local section = get_logistic_section(mass_driver)
    for i = 1, section.filters_count do
      section.clear_slot(i + 1)
    end
  else
    -- Send complete stacks to destination
    local sender_inventory = mass_driver.get_inventory(defines.inventory.chest)
    local sender_content = sender_inventory.get_contents()
    local requester_inventory = requester.get_inventory(defines.inventory.chest)
    if requester_inventory.count_empty_stacks(false, false) > 0 then
      local driver_capsule = sender_inventory.find_item_stack("ll-mass-driver-capsule")
      if driver_capsule then
        for _, item in pairs(sender_content) do
          local name, count, quality = item.name, item.count, item.quality
          if count >= prototypes.item[name].stack_size and is_allowed(name) then
            local energy_source_entity = mass_driver_data.energy_source
            if energy_source_entity.valid and energy_source_entity.energy >= (200000000) then
              energy_source_entity.energy = 0
              local stack = {name = name, count = prototypes.item[name].stack_size, quality = quality}
              local sent = requester_inventory.insert(stack)
              if sent > 0 then
                stack.count = sent
                sender_inventory.remove(stack)
                sender_inventory.remove{name = "ll-mass-driver-capsule", count = 1, quality = driver_capsule.quality}
                MassDriver.kaboom(mass_driver)
              end
              break
            end
          end
        end
      end
    end

    -- Update requests
    local requester_logistic_section = get_logistic_section(requester)
    local mass_driver_logistic_section = get_logistic_section(mass_driver)
    local requester_request_count = requester_logistic_section.filters_count
    local requester_inventory = requester.get_inventory(defines.inventory.chest)
    local mass_driver_request_count = mass_driver_logistic_section.filters_count

    for i = 1, math.max(requester_request_count, mass_driver_request_count) do
      local request = requester_logistic_section.get_slot(i)
      if request and request.min then
        local item_name = request.value.name
        local requested_count = request.min
        requested_count = math.max(requested_count, prototypes.item[item_name].stack_size)
        local already_delivered_count = requester_inventory.get_item_count{name = item_name, quality = request.value.quality}
        local needed_count = requested_count - already_delivered_count
        if needed_count > 0 then
          local existing_request = mass_driver_logistic_section.get_slot(i + 1) -- i+1 because capsule will be in slot 1
          if not existing_request or existing_request.min ~= needed_count or existing_request.value.name ~= item_name then
            mass_driver_logistic_section.set_slot(i + 1, {
              value = {
                name = item_name,
                type = request.value.type,
                comparator = request.value.comparator,
                quality = request.value.quality,
              },
              min = needed_count,
              import_from = "nauvis" -- the mass driver is only used for nauvis-luna connection. we can assume this to be a constant
            })
          end
        else
          mass_driver_logistic_section.clear_slot(i + 1)
        end
      else
        mass_driver_logistic_section.clear_slot(i + 1)
      end
    end
  end

  -- Update GUI to display the current energy stored
  for _, player in pairs(game.connected_players) do
    local gui = player.gui.relative["ll-mass-driver-relative-frame"]
    if gui and player.opened == mass_driver then
      local energy_info = gui["ll-mass-driver-inner-frame"]["ll-mass-driver-info-flow"]["ll-mass-driver-energy-flow"]["ll-mass-driver-energy-label"]
      energy_info.caption = format_energy(mass_driver_data.energy_source.energy) .. "/200MJ"
    end
  end
end

local function on_tick(event)
  for unit_number, mass_driver_data in pairs(Buckets.get_bucket(storage.mass_drivers, event.tick)) do
    local mass_driver = mass_driver_data.entity
    if not mass_driver.valid then
      Buckets.remove(storage.mass_drivers, unit_number)
    else
      MassDriver.update_mass_driver(mass_driver, mass_driver_data)
    end
  end
end

MassDriver.events = {
  [defines.events.on_tick] = on_tick,
  [defines.events.on_gui_opened] = on_gui_opened,
  [defines.events.on_gui_closed] = on_gui_closed,
  [defines.events.on_built_entity] = on_mass_driver_built,
  [defines.events.on_robot_built_entity] = on_mass_driver_built,
  [defines.events.script_raised_built] = on_mass_driver_built,
  [defines.events.script_raised_revive] = on_mass_driver_built,
  [defines.events.on_object_destroyed] = on_object_destroyed,
}

MassDriver.on_init = function ()
  storage.mass_drivers = Buckets.new(180)
  storage.mass_driver_guis = {}
end

MassDriver.on_configuration_changed = function(changed_data)
  storage.mass_drivers = storage.mass_drivers or Buckets.new(180)
  storage.mass_driver_guis = storage.mass_driver_guis or {}
end

return MassDriver