local resource_autoplace = require("__core__/lualib/resource-autoplace")
local noise = require("__core__/lualib/noise")

local resources = {"ll-moon-rock", "ll-rich-moon-rock", "ll-ice", "ll-astrocrystals"}

resource_autoplace.initialize_patch_set("ll-moon-rock", true)
resource_autoplace.initialize_patch_set("ll-rich-moon-rock", false)
resource_autoplace.initialize_patch_set("ll-ice", true)
resource_autoplace.initialize_patch_set("ll-astrocrystals", false)

data.raw.resource["ll-moon-rock"].autoplace = resource_autoplace.resource_autoplace_settings
{
  name = "ll-moon-rock",
  order = "b",
  base_density = 5,
  has_starting_area_placement = true,
  regular_rq_factor_multiplier = 1.0,
  starting_rq_factor_multiplier = 1.1,
}

data.raw.resource["ll-rich-moon-rock"].autoplace = resource_autoplace.resource_autoplace_settings
{
  name = "ll-rich-moon-rock",
  order = "b",
  base_density = 4,
  has_starting_area_placement = false,
  regular_rq_factor_multiplier = 1.0,
  starting_rq_factor_multiplier = 1.1,
}

data.raw.resource["ll-ice"].autoplace = resource_autoplace.resource_autoplace_settings({
  name = "ll-ice",
  order = "b",
  base_density = 5,
  richness_multiplier = 1,
  richness_multiplier_distance_bonus = 1.3,
  base_spots_per_km2 = 0.06,
  has_starting_area_placement = true,
  random_spot_size_minimum = 0.01,
  random_spot_size_maximum = 0.1,
  regular_blob_amplitude_multiplier = 1,
  richness_post_multiplier = 1.0,
  --additional_richness = 400000,
  starting_rq_factor_multiplier = 0.1,  -- Makes patches have only one entity
  regular_rq_factor_multiplier = 0.1,
  candidate_spot_count = 22,
})

data.raw.resource["ll-astrocrystals"].autoplace = resource_autoplace.resource_autoplace_settings({
  name = "ll-astrocrystals",
  order = "b",
  base_density = 4,
  richness_multiplier = 1,
  richness_multiplier_distance_bonus = 1.5,
  base_spots_per_km2 = 0.04,
  has_starting_area_placement = false,
  random_spot_size_minimum = 0.01,
  random_spot_size_maximum = 0.1,
  regular_blob_amplitude_multiplier = 1,
  richness_post_multiplier = 1.0,
  --additional_richness = 350000,
  starting_rq_factor_multiplier = 0.1,  -- Makes patches have only one entity
  regular_rq_factor_multiplier = 0.1,
  candidate_spot_count = 22,
})

for _, name in pairs(resources) do
  local resource = data.raw.resource[name]
  resource.autoplace.default_enabled = false
  resource.autoplace.tile_restriction = {"ll-luna-plain"}
end