local function blacklist_entities()
  if not script.active_mods["PickerDollies"] then return end
  if not remote.interfaces["PickerDollies"] then return end
  if not remote.interfaces["PickerDollies"]["add_blacklist_name"] then return end
  -- Blacklist LL entities
  remote.call("PickerDollies", "add_blacklist_name", "ll-arc-furnace")
  remote.call("PickerDollies", "add_blacklist_name", "ll-arc-furnace-reactor")
  remote.call("PickerDollies", "add_blacklist_name", "ll-arc-furnace-storage-tank")
  remote.call("PickerDollies", "add_blacklist_name", "rocket-silo")
  remote.call("PickerDollies", "add_blacklist_name", "rocket-silo-down")
  remote.call("PickerDollies", "add_blacklist_name", "rocket-silo-interstellar")
  remote.call("PickerDollies", "add_blacklist_name", "ll-landing-pad")
  remote.call("PickerDollies", "add_blacklist_name", "steam-turbine")
  remote.call("PickerDollies", "add_blacklist_name", "ll-steam-condenser")
  remote.call("PickerDollies", "add_blacklist_name", "ll-mass-driver")
  remote.call("PickerDollies", "add_blacklist_name", "ll-mass-driver-requester")
end

return
{
  load = blacklist_entities
}
