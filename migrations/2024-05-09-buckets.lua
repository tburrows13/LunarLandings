local Buckets = require "scripts.buckets"

if not storage.oxygen_diffusers.interval then
  storage.oxygen_diffusers = Buckets.migrate(storage.oxygen_diffusers)
end

if not storage.rocket_silos.interval then
  storage.rocket_silos = Buckets.migrate(storage.rocket_silos)
end

if not storage.rtgs.interval then
  storage.rtgs = Buckets.migrate(storage.rtgs)
end

if not storage.steam_condensers.interval then
  storage.steam_condensers = Buckets.migrate(storage.steam_condensers)
end
