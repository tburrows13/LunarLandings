local handler = require "__core__.lualib.event_handler"
gui = require "__LunarLandings__.scripts.gui-lite"

local compatibility = require "scripts.compatibility"
compatibility.preload_remote_interface()

handler.add_libraries{
  gui,
  require "scripts.moon-surface",
  require "scripts.moon-view",
  require "scripts.rocket-silo",
  require "scripts.landing-pad",
  require "scripts.rtg",
  require "scripts.oxygen-diffuser",
  require "scripts.steam-condenser",
  require "scripts.arc-furnace",
  require "scripts.collision-test",
}

