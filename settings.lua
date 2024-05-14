local function force_setting(setting_type, setting_name, value)
  local setting = data.raw[setting_type .. "-setting"][setting_name]
  log(setting.name)
  if setting then
    if setting_type == "bool" then
      setting.forced_value = value
    else
      setting.allowed_values = { value }
    end
    setting.default_value = value
    setting.hidden = true
  end
end

force_setting("string", "alien-biomes-include-dirt-grey", "Enabled")