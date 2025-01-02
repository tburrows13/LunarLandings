x_util = require("__LunarLandings__.x-util")

BASE_ONLY = not mods["space-age"]
SPACE_AGE = not BASE_ONLY

local function require_base_only(filename)
  if BASE_ONLY then
    require("__LunarLandings__.prototypes-base-only." .. filename)
  end
end

local function require_space_age(filename)
  if BASE_ONLY then
    require("__LunarLandings__.prototypes-space-age." .. filename)
  end
end

local function require_base_or_sa(filename)
  if BASE_ONLY then
    require("__LunarLandings__.prototypes-base-only." .. filename)
  else
    require("__LunarLandings__.prototypes-space-age." .. filename)
  end
end

require "__LunarLandings__.prototypes.luna"
require "__LunarLandings__.prototypes.quantum-module"
require "__LunarLandings__.prototypes.custom-input"
require "__LunarLandings__.prototypes.item-groups"
require_base_only "rocket-silo-interstellar"
require_base_or_sa "rocket-silo"
require "__LunarLandings__.prototypes.rocket-parts"
require_base_only "interstellar-satellite"
require "__LunarLandings__.prototypes.packed-parts"
require "__LunarLandings__.prototypes.mass-driver"
require_base_only "liquid-rocket-fuel"
require "__LunarLandings__.prototypes.electric-furnace"
require "__LunarLandings__.prototypes.heat-furnace"
require "__LunarLandings__.prototypes.centrifuge"
require "__LunarLandings__.prototypes.hidden-radar"
require "__LunarLandings__.prototypes.arc-furnace"
require "__LunarLandings__.prototypes.rtg"
require "__LunarLandings__.prototypes.core-extractor"
require "__LunarLandings__.prototypes.landing-pad"
require "__LunarLandings__.prototypes.tiles"
require "__LunarLandings__.prototypes.moon-rock"
require "__LunarLandings__.prototypes.rich-moon-rock"
require "__LunarLandings__.prototypes.silicon"
require "__LunarLandings__.prototypes.oxygen"
require "__LunarLandings__.prototypes.ice"
require "__LunarLandings__.prototypes.aluminium"
require "__LunarLandings__.prototypes.low-grav-assembling-machine"
require "__LunarLandings__.prototypes.telescope"
require "__LunarLandings__.prototypes.moon-rails"
require "__LunarLandings__.prototypes.elevated-moon-rails"
require "__LunarLandings__.prototypes.space-science"
require "__LunarLandings__.prototypes.data-cards"
require "__LunarLandings__.prototypes.oxygen-diffuser"
require "__LunarLandings__.prototypes.steam-condenser"
require "__LunarLandings__.prototypes.quantum-processor"
require "__LunarLandings__.prototypes.astrocrystals"
require "__LunarLandings__.prototypes.quantum-science"
require "__LunarLandings__.prototypes.polariton"
require "__LunarLandings__.prototypes.quantum-resonator"
require "__LunarLandings__.prototypes.technology"
require_base_or_sa "technology-updates"
require_base_only "technology-infinite"
require "__LunarLandings__.prototypes.resources"
require "__LunarLandings__.prototypes.moon-cliffs"
require "__LunarLandings__.prototypes.decoratives-crater"
require "__LunarLandings__.prototypes.decoratives"
require "__LunarLandings__.prototypes.luna-map-gen"
require "__LunarLandings__.prototypes.autoplace-controls"
require "__LunarLandings__.prototypes.remote-drone"
require "__LunarLandings__.prototypes.recipe-changes"
require "__LunarLandings__.prototypes.tips-and-tricks"
require "__LunarLandings__.prototypes.sounds"
require "__LunarLandings__.prototypes.item-sounds"
--require "__LunarLandings__.prototypes.construction-bots"
