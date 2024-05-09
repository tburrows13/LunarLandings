local Buckets = require "scripts.buckets"

if not global.oxygen_diffusers.interval then
  global.oxygen_diffusers = Buckets.migrate(global.oxygen_diffusers)
end

if not global.rocket_silos.interval then
  global.rocket_silos = Buckets.migrate(global.rocket_silos)
end

if not global.rtgs.interval then
  global.rtgs = Buckets.migrate(global.rtgs)
end

if not global.steam_condensers.interval then
  global.steam_condensers = Buckets.migrate(global.steam_condensers)
end
