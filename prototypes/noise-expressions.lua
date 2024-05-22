--[[
  Copied from core/prototypes/noise-programs.lua
  Modifications marked with --m
  /c game.print(serpent.block(game.player.surface.calculate_tile_properties({"elevation"}, {game.player.character.position})))
]]

local noise = require("noise")
local util = require("util")
local tne = noise.to_noise_expression
local litexp = noise.literal_expression

local onethird = tne(1)/3 -- Looks nicer in output than 0.333333

local function make_basis_noise_function(seed0,seed1,outscale0,inscale0)
  outscale0 = outscale0 or 1
  inscale0 = inscale0 or 1/outscale0
  return function(x,y,inscale,outscale)
    return tne
    {
      type = "function-application",
      function_name = "factorio-basis-noise",
      arguments =
      {
        x = tne(x),
        y = tne(y),
        seed0 = tne(seed0),
        seed1 = tne(seed1),
        input_scale = tne((inscale or 1) * inscale0),
        output_scale = tne((outscale or 1) * outscale0)
      }
    }
  end
end

local function multioctave_noise(params)
  local x = params.x or noise.var("x")
  local y = params.y or noise.var("y")
  local seed0 = params.seed0 or 1
  local seed1 = params.seed1 or 1
  local octave_count = params.octave_count or 1
  local octave0_output_scale = params.octave0_output_scale or 1
  local octave0_input_scale = params.octave0_input_scale or 1
  if params.persistence and params.octave_output_scale_multiplier then
    error("Both persistence and octave_output_scale_multiplier were provided to multioctave_noise, which makes no sense!")
  end
  local octave_output_scale_multiplier = params.octave_output_scale_multiplier or 2
  local octave_input_scale_multiplier = params.octave_input_scale_multiplier or 1/2
  local basis_noise_function = params.basis_noise_function or make_basis_noise_function(seed0, seed1)

  if params.persistence then
    octave_output_scale_multiplier = params.persistence
    -- invert everything so that we can multiply by persistence every time
    -- first octave is the largest instead of the smallest
    octave0_input_scale = octave0_input_scale * math.pow(octave_input_scale_multiplier, octave_count - 1)
    -- 'persistence' implies that the octaves would otherwise have been powers of 2, I think
    octave0_output_scale = octave0_output_scale * math.pow(2, octave_count - 1)
    octave_input_scale_multiplier = 1 / octave_input_scale_multiplier
  end

  return tne{
    type = "function-application",
    function_name = "factorio-quick-multioctave-noise",
    arguments =
    {
      x = tne(x),
      y = tne(y),
      seed0 = tne(seed0),
      seed1 = tne(seed1),
      input_scale = tne(octave0_input_scale),
      output_scale = tne(octave0_output_scale),
      octaves = tne(octave_count),
      octave_output_scale_multiplier = tne(octave_output_scale_multiplier),
      octave_input_scale_multiplier = tne(octave_input_scale_multiplier)
    }
  }
end

-- Multioctave noise that's constructed in a simple way and knows about 'persistence'.
-- It doesn't *have* to be variable,
-- but this construction allows for it.
local function simple_variable_persistence_multioctave_noise(params)
  local x = params.x or noise.var("x")
  local y = params.y or noise.var("y")
  local seed0 = params.seed0 or 1
  local seed1 = params.seed1 or 1
  local octave_count = params.octave_count or 1
  local octave0_output_scale = params.octave0_output_scale or 1
  local octave0_input_scale = params.octave0_input_scale or 1
  local persistence = params.persistence or 1/2

  local terms = {}
  -- Start at the 'large' octave (assuming powers of 2 size increases)
  -- and work inwards, doubling the frequency and mulitplying amplitude by persistence.
  -- 'octave0' is the smallest octave.
  local largest_octave_scale = (2 ^ octave_count)
  local inscale = octave0_input_scale / largest_octave_scale
  local outscale = octave0_output_scale * largest_octave_scale
  for oct=1,octave_count do
    terms[oct] = tne{
      type = "function-application",
      function_name = "factorio-basis-noise",
      arguments = {
        x = tne(x),
        y = tne(y),
        seed0 = tne(seed0),
        seed1 = tne(seed1),
        input_scale = tne(inscale),
        output_scale = tne(1), -- Since outscale is variable, need to multiply separately
      }
    } * outscale
    inscale = inscale * 2 -- double frequency
    outscale = outscale * persistence -- lower amplitude (unless persistence is >1, which would be weird but okay)
  end
  return tne{
    type = "function-application",
    function_name = "add",
    arguments = terms
  }
end

-- Accounts for multiple octaves to return an expression whose amplitude maxes out at about +-1
-- (or +-octave0_input_scale, if that's passed in).
-- Parameters are the same as for simple_variable_persistence_multioctave_noise.
local function simple_amplitude_corrected_multioctave_noise(params)
  local amplitide = params.amplitude or 1
  local persistence = params.persistence or 0.5
  local octave_count = params.octave_count or 1
  -- 0.12's ImprovedNoise would do like:
  -- output = total / ((1 - amplitude) / (1 - persistence)) -- where amplitude is persistence ^ octaves
  -- output = total * (1 - persistence) / (1 - persistence ^ octaves)
  -- So use (1 - persistence) / (1 - persistence ^ octaves) as the output multiplier
  -- but it also uses 1 as the amplitude of the largest octave, whereas
  -- simple_variable_persistence_multioctave_noise uses 2^octave_count.
  -- So divide by that, too:
  local multiplier = (1 - persistence) / (2^octave_count) / (1 - persistence ^ octave_count)

  if params.octave0_output_scale then
    error("Don't pass octave0_output_scale to simple_amplitude_corrected_multioctave_noise; pass amplitude, instead")
  end
  return simple_variable_persistence_multioctave_noise(util.merge{params, {octave0_output_scale = multiplier * amplitide}})
end

local function water_level_correct(to_be_corrected, map)
  return noise.ident(noise.max(
    map.wlc_elevation_minimum,
    to_be_corrected + map.wlc_elevation_offset
  ))
end

local function finish_elevation(elevation, map)
  local elevation = water_level_correct(elevation, map)
  elevation = elevation / map.segmentation_multiplier
  --elevation = noise.min(elevation, standard_starting_lake_elevation_expression)  --m
  return elevation
end

local function make_0_12like_lakes(x, y, tile, map, options)
  options = options or {}
  local terrain_octaves = options.terrain_octaves or 8
  local amplitude_multiplier = 1/8
  --local roughness_persistence = 0.7
  local bias = options.bias or 20 -- increase average elevation level by this much
  local starting_plateau_bias = 20
  local starting_plateau_octaves = 6

  local lakes = simple_variable_persistence_multioctave_noise{
    x = x,
    y = y,
    seed0 = map.seed,
    seed1 = 1,
    octave_count = terrain_octaves,
    octave0_input_scale = 1/2,
    octave0_output_scale = amplitude_multiplier,
    --persistence = persistence
  }
  local starting_plateau_basis = simple_variable_persistence_multioctave_noise{
    x = x,
    y = y,
    seed0 = map.seed,
    seed1 = 2,
    octave_count = starting_plateau_octaves,
    octave0_input_scale = 1/2,
    octave0_output_scale = amplitude_multiplier,
    --persistence = persistence
  }
  local starting_plateau = starting_plateau_basis + starting_plateau_bias + map.finite_water_level - tile.distance * map.segmentation_multiplier / 10
  return noise.max(lakes + bias, starting_plateau)
end

-- Additions
local luna_max_elevation = 10
local function luna_elevation(elevation, map)
  elevation = noise.min(elevation, luna_max_elevation)

  -- Add mountains
  local regular_spots = tne{
    type = "function-application",
    function_name = "spot-noise",
    arguments =
    {
      x = noise.var("x") / 4,  -- Increase 4 to make mountains further apart
      y = noise.var("y") / 4,
      seed0 = map.seed,
      seed1 = tne(199),
      region_size = tne(1024),
      candidate_spot_count = tne(21),
      suggested_minimum_candidate_point_spacing = tne(40),
      --skip_span = noise.var("regular-resource-patch-set-count"),
      --skip_offset = tne(regular_patch_metaset:get_patch_set_index(patch_set_name)),
      density_expression = litexp(2), -- low-frequency noise evaluate for an entire region
      spot_quantity_expression = litexp(1), -- used to figure out where spots go
      hard_region_target_quantity = tne(false), -- it's fine for large spots to push region quantity past the target
      spot_radius_expression = litexp(1.9),  -- Increase this to make mountains larger
      spot_favorability_expression = litexp(1),
      basement_value = tne(-2),
      maximum_spot_basement_radius = tne(128)
    }
  }  -- In the range -2 to 0.1

  -- Add some blobbiness
  local blobs0 = tne{
    type = "function-application",
    function_name = "factorio-basis-noise",
    arguments =
    {
      x = noise.var("x"),
      y = noise.var("y"),
      seed0 = noise.var("map_seed"),
      seed1 = tne(199),
      input_scale = tne(1/8),
      output_scale = tne(1)
    }
  } + tne{
    type = "function-application",
    function_name = "factorio-basis-noise",
    arguments =
    {
      x = noise.var("x"),
      y = noise.var("y"),
      seed0 = noise.var("map_seed"),
      seed1 = tne(199),
      input_scale = tne(1/24),
      output_scale = tne(1)
    }
  }
  local blobs0f = blobs0 - 1/4  
  local blobs1 = blobs0 + tne{
    type = "function-application",
    function_name = "factorio-basis-noise",
    arguments =
    {
      x = noise.var("x"),
      y = noise.var("y"),
      seed0 = noise.var("map_seed"),
      seed1 = tne(199),
      input_scale = tne(1/64),
      output_scale = tne(1.5)
    }
  }
  local blobs1f = blobs1 - onethird -- attempt to remove positive bias

  local blobby_spots = regular_spots + blobs0f * (1/8)
  local mountains = noise.max(blobby_spots + 1, 0) * 20
  elevation = elevation + mountains
  --elevation = noise.max(regular_spots, 0)
  return elevation
end
-- End additions

data:extend{
  {
    type = "noise-expression",
    name = "ll-luna-elevation",
    --intended_property = "elevation",
    expression = noise.define_noise_function( function(x,y,tile,map)
      x = x * map.segmentation_multiplier + 10000 -- Move the point where 'fractal similarity' is obvious off into the boonies
      y = y * map.segmentation_multiplier
      --map.seed = map.seed + 10000  --m
      return luna_elevation(finish_elevation(make_0_12like_lakes(x, y, tile, map), map), map)
    end)
  },

}