local function force_setting(setting_type, setting_name, value)
  local setting = data.raw[setting_type .. "-setting"][setting_name]
  if setting then
    log(setting.name)
    if setting_type == "bool" then
      setting.forced_value = value
    else
      setting.allowed_values = { value }
    end
    setting.default_value = value
    setting.hidden = true
  end
end

force_setting("bool", "space-battery-decay-enable-setting", true)
force_setting("string", "space-battery-pack-energy-density-setting", "50 MJ (Default)")
force_setting("string", "space-fluid-wagon-capacity-setting", "30.000 (Default)")
force_setting("string", "space-cargo-wagon-capacity-setting", "50 Slots (Default)")
force_setting("string", "space-locomotive-speed-setting", "518 km/h (Default)")