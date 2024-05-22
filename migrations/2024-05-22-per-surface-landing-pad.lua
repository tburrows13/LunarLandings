local function name_added(name, unit_number, surface_name)
  names = global.landing_pad_names[surface_name]
  if names[name] then
    names[name][unit_number] = true
  else
    names[name] = {[unit_number] = true}
  end
end

global.landing_pad_names = {nauvis = {}, luna = {}}

local to_remove = {}
for unit_number, entity_data in pairs(global.landing_pads) do
  local entity = entity_data.entity
  if entity.valid then
    entity_data.surface_name = entity.surface.name
    name_added(entity_data.name, unit_number, entity_data.entity.surface.name)
  else
    table.insert(to_remove, unit_number)
  end
end

for _, unit_number in ipairs(to_remove) do
  global.landing_pads[unit_number] = nil
end