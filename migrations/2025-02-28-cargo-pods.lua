for _, player in pairs(game.players) do
  if player.opened then
    player.opened = nil
  end
end

for _, landing_pad_data in pairs(storage.landing_pads) do
  landing_pad_data.cargo_pods_targeting = {}
end

for _, rocket_silo_data in pairs(storage.rocket_silos) do
  if rocket_silo_data.auto_launch == "any" then
    rocket_silo_data.auto_launch = "none"
  end
end