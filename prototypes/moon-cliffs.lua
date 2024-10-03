local sounds = require("__base__.prototypes.entity.sounds")

local function cliff_sprite_variations(name, column_offset, row_offset, variation_count, scale)
  local frame_width = 128
  local shadow_frame_width = name == "entrance" and 128 or 160
  local shadow_shift = name == "entrance" and {0, 0} or {0.5, 0}
  local frame_height = 128
  pictures = {}
  for i=0,(variation_count-1) do
    table.insert(pictures,
    {
      layers =
      {
        {
          filename = "__LunarLandings__/graphics/cliffs/cliff-" .. name .. ".png",
          width = frame_width,
          height = frame_height,
          x = (column_offset + i) * frame_width,
          y = row_offset * frame_height,
          scale = scale,
          hr_version =
          {
            filename = "__LunarLandings__/graphics/cliffs/hr-cliff-" .. name .. ".png",
            width = frame_width * 2,
            height = frame_height * 2,
            x = (column_offset + i) * frame_width * 2,
            y = row_offset * frame_height * 2,
            scale = scale * 0.5
          }
        },
        {
          filename = "__base__/graphics/terrain/cliffs/cliff-" .. name .. "-shadow.png",
          width = shadow_frame_width,
          height = frame_height,
          x = (column_offset + i) * shadow_frame_width,
          y = row_offset * frame_height,
          draw_as_shadow = true,
          scale = scale,
          shift = shadow_shift,
          hr_version =
          {
            filename = "__base__/graphics/terrain/cliffs/hr-cliff-" .. name .. "-shadow.png",
            width = shadow_frame_width * 2,
            height = frame_height * 2,
            x = (column_offset + i) * shadow_frame_width * 2,
            y = row_offset * frame_height * 2,
            draw_as_shadow = true,
            scale = scale * 0.5,
            shift = shadow_shift
          }
        }
      }
    })
  end
  return pictures
end

local sqrt2 = 1.4142135623730951
local function dq(n) -- 'diagonal quarter' i.e. 1/4 of the way across 1x1 cell diagonally
  return sqrt2 * n / 4
end

local function rotbb(cx, cy, halfwidth, halfheight, angle)
  return {{cx-halfwidth, cy-halfheight}, {cx+halfwidth, cy+halfheight}, angle}
end


local function cliff_orientation(name, column_offset, row_offset, variation_count, collision_bounding_box, scale, fill_volume)
  return
  {
    pictures = cliff_sprite_variations(name, column_offset, row_offset, variation_count, scale),
    collision_bounding_box = collision_bounding_box,
    fill_volume = fill_volume
  }
end


local scale = 1
local fill_volume = 16
local grid_offset = {0, 0.5}
data:extend{
  {
    type = "cliff",
    name = "ll-luna-cliff",
    icon = "__base__/graphics/icons/cliff.png",
    icon_size = 64,
    subgroup = "cliffs",
    flags = {"placeable-neutral"},
    -- generic collision box is intentionally small so you can place trees nearby in map editor
    -- cliffs are auto-placed with centers at (0, 0.5) offset from the grid;
    -- using a collision box with even width and odd height makes them place properly in the editor.
    collision_box = {{-1.0, -0.5}, {1.0, 0.5}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    order = "b[decorative]-l[rock]-b[big]",
    selectable_in_game = false,
    map_color = {r=144, g=119, b=87},
    grid_size = {4 * scale, 4 * scale},
    grid_offset = grid_offset,
    mined_sound = sounds.deconstruct_bricks(0.8),
    vehicle_impact_sound = sounds.car_stone_impact,
    map_color = {r=180, g=180, b=180},
    orientations =
    {
      -- Since removing a cliff also causes neighboring cliffs to be removed,
      -- we'll think of it (for purposes of fill volume) as filling two sections centered on the ends of this segment.
      -- That way you can't "cheat" by filling every other cliff segment -- the numbers should work out the same.
      west_to_east   = cliff_orientation("sides"   , 0, 2, 8, {{-2.0, -1.5}, {2.0,  1.5}}, scale, fill_volume*2),
      north_to_south = cliff_orientation("sides"   , 0, 3, 8, {{-1.0, -2.0}, {1.0,  2.0}}, scale, fill_volume*2),
      east_to_west   = cliff_orientation("sides"   , 0, 0, 8, {{-2.0, -0.5}, {2.0,  0.5}}, scale, fill_volume*2),
      south_to_north = cliff_orientation("sides"   , 0, 1, 8, {{-1.0, -2.0}, {1.0,  2.0}}, scale, fill_volume*2),
      west_to_north  = cliff_orientation("outer"   , 0, 3, 8, rotbb(-5/4, -3/4, dq(5.4), dq(3.6), 7/8), scale, fill_volume*2),
      north_to_east  = cliff_orientation("outer"   , 0, 0, 8, rotbb( 5/4, -3/4, dq(5.4), dq(3.6), 1/8), scale, fill_volume*2),
      east_to_south  = cliff_orientation("outer"   , 0, 1, 8, rotbb( 3/4,  5/4, dq(4.4), dq(2.6), 7/8), scale, fill_volume*2),
      south_to_west  = cliff_orientation("outer"   , 0, 2, 8, rotbb(-3/4,  5/4, dq(4.4), dq(2.6), 1/8), scale, fill_volume*2),
      west_to_south  = cliff_orientation("inner"   , 0, 0, 8, rotbb(-5/4,  3/4, dq(5.4), dq(3.6), 1/8), scale, fill_volume*2),
      north_to_west  = cliff_orientation("inner"   , 0, 1, 8, rotbb(-3/4, -5/4, dq(4.4), dq(2.6), 7/8), scale, fill_volume*2),
      east_to_north  = cliff_orientation("inner"   , 0, 2, 8, rotbb( 3/4, -5/4, dq(4.4), dq(2.6), 1/8), scale, fill_volume*2),
      south_to_east  = cliff_orientation("inner"   , 0, 3, 8, rotbb( 5/4,  3/4, dq(5.4), dq(3.6), 7/8), scale, fill_volume*2),
      west_to_none   = cliff_orientation("entrance", 2, 0, 2, {{-2.0, -1.5}, {0.0,  1.5}}, scale, fill_volume),
      none_to_east   = cliff_orientation("entrance", 0, 0, 2, {{ 0.0, -1.5}, {2.0,  1.5}}, scale, fill_volume),
      north_to_none  = cliff_orientation("entrance", 2, 3, 2, rotbb( 0.75, -0.75, dq(4.5), dq(2.5), 1/8), scale, fill_volume),
      none_to_south  = cliff_orientation("entrance", 0, 3, 2, rotbb( 0.60,  0.90, dq(4), dq(2), 7/8), scale, fill_volume),
      east_to_none   = cliff_orientation("entrance", 2, 2, 2, rotbb( 0.75,  0.75, dq(4), dq(2), 7/8), scale, fill_volume),
      none_to_west   = cliff_orientation("entrance", 0, 2, 2, rotbb(-0.85,  0.85, dq(4), dq(2), 1/8), scale, fill_volume),
      south_to_none  = cliff_orientation("entrance", 2, 1, 2, rotbb(-0.85,  0.85, dq(4), dq(2), 1/8), scale, fill_volume),
      none_to_north  = cliff_orientation("entrance", 0, 1, 2, rotbb(-0.70, -0.70, dq(4.5), dq(2.5), 7/8), scale, fill_volume)
    }
  }

}