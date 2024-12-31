local resource_autoplace = require("__core__/lualib/resource-autoplace")

data:extend{
  { -- Taken from core mod, with modified double_density_distance and regular_patch_fade_in_distance
    type = "noise-function",
    name = "resource_autoplace_luna_patches",
    parameters =
    {
      "base_density",
      "base_spots_per_km2",
      "candidate_spot_count",
      "frequency_multiplier",
      "has_starting_area_placement",
      "random_spot_size_minimum",
      "random_spot_size_maximum",
      "regular_blob_amplitude_multiplier", -- Amplitude of spot 'blob noise' relative to typical spot amplitude
      "regular_patch_set_count",
      "regular_patch_set_index",
      "regular_rq_factor", -- rq_factor is the ratio of the radius of a patch to the cube root of its quantity,
                           -- i.e. radius of a quantity=1 patch; higher values = fatter, shallower patches
      "seed1",
      "size_multiplier",
      "starting_blob_amplitude_multiplier",
      "starting_patch_set_count",
      "starting_patch_set_index",
      "starting_rq_factor"
    },
    expression = "if(has_starting_area_placement == 1, max(starting_patches, regular_patches), regular_patches)",
    local_expressions =
    {
      -- Since starting and regular spots get maxed together, the basement value should be the lower of the two.
      -- This value needs to be low enough that any noise added to it is still below zero, so that we don't get bits of ores
      -- sticking out between spot noise spots. It also needs to be constant because that's how the spot noise op works.
      -- Simply using -infinity would work, but calculating it based on blob amplitude:
      --   a) looks nicer if you render the value on a map preview
      --   b) acts as a check on our blob_amplitude calculations
      basement_value = "-6 * max(regular_blob_amplitude_at(regular_blob_amplitude_maximum_distance), starting_blob_amplitude)",

      blobs0 = "basis_noise{x = x, y = y, seed0 = map_seed, seed1 = seed1, input_scale = 1/8, output_scale = 1} + \z
                basis_noise{x = x, y = y, seed0 = map_seed, seed1 = seed1, input_scale = 1/24, output_scale = 1}",
      double_density_distance = 1900, -- Distance at which patches have twice as much stuff in them.
      regular_patch_fade_in_distance = 500,
      starting_resource_placement_radius = 170, -- The starting area size option should not affect regular ore placement, so it is hard-coded.
      starting_patches_split = 0.5, -- Lower numbers decrease the likelihood that the starting patches get split.

      -- Starting patches
      starting_patches = "spot_noise{x = x,\z
                                     y = y,\z
                                     density_expression = starting_amount / (pi * starting_resource_placement_radius * starting_resource_placement_radius) * \z
                                                          starting_modulation,\z
                                     spot_quantity_expression = starting_area_spot_quantity,\z
                                     spot_radius_expression = starting_rq_factor * starting_area_spot_quantity ^ (1/3),\z
                                     spot_favorability_expression = clamp((elevation_lakes - 1) / 10, 0, 1) * starting_modulation * 2 - \z
                                                                    distance / starting_resource_placement_radius + random_penalty_at(0.5, 1),\z
                                     seed0 = map_seed,\z
                                     seed1 = seed1 + 1,\z
                                     skip_span = starting_patch_set_count,\z
                                     skip_offset = starting_patch_set_index,\z
                                     region_size = starting_resource_placement_radius * 2,\z
                                     candidate_spot_count = 32,\z
                                     suggested_minimum_candidate_point_spacing = 32,\z
                                     hard_region_target_quantity = 1,\z
                                     basement_value = basement_value,\z
                                     maximum_spot_basement_radius = 128} + \z
                          (blobs0 - 0.25) * starting_blob_amplitude",
      starting_amount = "20000 * base_density * (frequency_multiplier + 1) * size_multiplier",
      starting_area_spot_quantity = "starting_amount / starting_patches_split / frequency_multiplier",
      starting_blob_amplitude = "starting_blob_amplitude_multiplier / (pi/3 * starting_rq_factor ^ 2) * starting_area_spot_quantity ^ (1/3)",
      starting_modulation = "starting_resource_placement_radius > distance",

      -- Regular patches
      regular_patches = "spot_noise{x = x,\z
                                    y = y,\z
                                    density_expression = regular_density_at(distance),\z
                                    spot_quantity_expression = regular_spot_quantity_expression,\z
                                    spot_radius_expression = min(32, regular_rq_factor * regular_spot_quantity_expression ^ (1/3)),\z
                                    spot_favorability_expression = 1,\z
                                    seed0 = map_seed,\z
                                    seed1 = seed1,\z
                                    region_size = 1024,\z
                                    candidate_spot_count = candidate_spot_count,\z
                                    suggested_minimum_candidate_point_spacing = 45.254833995939045,\z
                                    skip_span = regular_patch_set_count,\z
                                    skip_offset = regular_patch_set_index,\z
                                    hard_region_target_quantity = 0,\z
                                    basement_value = basement_value,\z
                                    maximum_spot_basement_radius = 128} + \z
                         (blobs0 + basis_noise{x = x, y = y, seed0 = map_seed, seed1 = seed1, input_scale = 1/64, output_scale = 1.5} - 1/3) * \z
                         regular_blob_amplitude_at(distance)",
      regular_blob_amplitude_maximum_distance = "if(has_starting_area_placement == -1,\z
                                                    double_density_distance,\z
                                                    double_density_distance + regular_patch_fade_in_distance)",
      regular_spot_quantity_expression = "random_penalty_between(random_spot_size_minimum, random_spot_size_maximum, 1) * \z
                                          regular_spot_quantity_base_at(distance)"
    },
    local_functions =
    {
      size_effective_distance_at =
      {
        parameters = {"distance"},
        expression = "if(has_starting_area_placement == -1, distance, distance - regular_patch_fade_in_distance)"
      },
      regular_density_at =
      {
        parameters = {"distance"},
        expression = "base_density * frequency_multiplier * size_multiplier * \z
                      if(has_starting_area_placement == -1, 1, clamp((distance - starting_resource_placement_radius) / regular_patch_fade_in_distance, 0, 1)) * \z
                      (1 + clamp(size_effective_distance_at(distance) / double_density_distance, 0, 1))"
      },
      regular_spot_quantity_base_at =
      {
        parameters = {"distance"},
        expression = "1000000 / base_spots_per_km2 / frequency_multiplier * regular_density_at(distance)"
      },
      regular_spot_height_typical_at =
      {
        parameters = {"distance"},
        expression = "((random_spot_size_minimum + random_spot_size_maximum) / 2 * regular_spot_quantity_base_at(distance)) ^ (1/3) / (pi/3 * regular_rq_factor ^ 2)"
      },
      regular_blob_amplitude_at =
      {
        parameters = {"distance"},
        expression = "regular_blob_amplitude_multiplier * min(regular_spot_height_typical_at(regular_blob_amplitude_maximum_distance),\z
                                                              regular_spot_height_typical_at(distance))"
      }
    }
  }
}

local resources = {"ll-moon-rock", "ll-rich-moon-rock", "ll-ice", "ll-astrocrystals"}

resource_autoplace.initialize_patch_set("ll-moon-rock", true)
resource_autoplace.initialize_patch_set("ll-rich-moon-rock", false)
resource_autoplace.initialize_patch_set("ll-ice", true)
resource_autoplace.initialize_patch_set("ll-astrocrystals", false)

data.raw.resource["ll-moon-rock"].autoplace = resource_autoplace.resource_autoplace_settings({
  name = "ll-moon-rock",
  order = "b",
  base_density = 5,
  base_spots_per_km2 = 1.3,
  has_starting_area_placement = true,
  regular_rq_factor_multiplier = 1.0,
  starting_rq_factor_multiplier = 1.1,
})

data.raw.resource["ll-rich-moon-rock"].autoplace = resource_autoplace.resource_autoplace_settings({
  name = "ll-rich-moon-rock",
  order = "b",
  base_density = 4,
  base_spots_per_km2 = 1,
  has_starting_area_placement = false,
  regular_rq_factor_multiplier = 1.0,
  starting_rq_factor_multiplier = 1.1,
})

data.raw.resource["ll-ice"].autoplace = resource_autoplace.resource_autoplace_settings({
  name = "ll-ice",
  order = "b",
  base_density = 5,
  richness_multiplier = 1,
  base_spots_per_km2 = 0.02,
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
  base_spots_per_km2 = 0.005,
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

  local noise_expression_name = "default-" .. name .. "-patches"
  local noise_expression = data.raw["noise-expression"][noise_expression_name]
  local expression = noise_expression.expression
  if expression:find("resource_autoplace_all_patches") then
    expression = expression:gsub("resource_autoplace_all_patches", "resource_autoplace_luna_patches")
    noise_expression.expression = expression
  end
end