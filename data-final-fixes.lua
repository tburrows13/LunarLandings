require "__LunarLandings__.prototypes.surface-conditions"
require "__LunarLandings__.prototypes.heat-recipes"

local collision_mask_util = require "__core__.lualib.collision-mask-util"

-- Set tile layer because Alien Biomes overwrites it in data-final-fixes
data.raw.tile["ll-moon"].layer = 10
