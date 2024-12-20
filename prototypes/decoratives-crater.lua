local function crater_picture (name, width, height)
  return {
    filename = "__alien-biomes-graphics__/graphics/decorative/crater/crater-"..name..".png",
    width = width,
    height = height,
    scale = 0.5
  }
end
local function make_crater(name, box, pictures)
  return {
    name = "ll-moon-" .. name,
    type = "optimized-decorative",
    subgroup = "ll-luna",
    order = "x-a",
    collision_box = {{-box, -box*0.75}, {box, box*0.75}},
    collision_mask = {
      layers = {
        doodad = true,
      },
      not_colliding_with_itself = true,
    },
    render_layer = "decals",
    tile_layer = 183,  -- TODO investigate
    --autoplace set in decoratives.lua
    pictures = pictures
  }
end
data:extend({
  -- {
  --     type = "noise-layer",
  --     name = "crater"
  -- },
  make_crater("crater3-huge", 8, {
    crater_picture("huge-01", 1249, 877),
  }),
  make_crater("crater1-large-rare", 4, {
    crater_picture("large-01", 679, 513),
  }),
  make_crater("crater1-large", 4, {
    crater_picture("large-02", 327, 284),
    crater_picture("large-03", 481, 393),
    crater_picture("large-04", 406, 382),
    crater_picture("large-05", 363, 301),
  }),
  make_crater("crater2-medium", 3, {
    crater_picture("medium-01", 283, 231),
    crater_picture("medium-02", 213, 182),
    crater_picture("medium-03", 243, 189),
    crater_picture("medium-04", 237, 173),
    crater_picture("medium-05", 195, 182),
    crater_picture("medium-06", 146, 125),
    crater_picture("medium-07", 180, 127),
  }),
  make_crater("crater4-small", 2, {
    crater_picture("small-01", 122, 108),
  }),
})

data:extend{

  {
    name = "ll-moon-sand-decal-white",
    type = "optimized-decorative",
    subgroup = "ll-luna",
    order = "b[decorative]-b[red-desert-decal]",
    collision_box = {{-6, -6}, {6, 6}},
    collision_mask = {
      layers = {
        doodad = true,
        water_tile = true,
      },
      not_colliding_with_itself = true
    },
    render_layer = "decals",
    tile_layer = 187, -- despite the name, this is not sand exclusive decal; draw under stone path and concrete
    pictures =
    {
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-01.png",
        width = 975,
        height = 664,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-02.png",
        width = 628,
        height = 477,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-03.png",
        width = 519,
        height = 331,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-04.png",
        width = 870,
        height = 781,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-05.png",
        width = 230,
        height = 161,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-06.png",
        width = 140,
        height = 110,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-07.png",
        width = 285,
        height = 243,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-08.png",
        width = 156,
        height = 85,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-09.png",
        width = 212,
        height = 152,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-10.png",
        width = 233,
        height = 197,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-11.png",
        width = 324,
        height = 413,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-12.png",
        width = 504,
        height = 488,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-13.png",
        width = 329,
        height = 305,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-14.png",
        width = 811,
        height = 724,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-15.png",
        width = 266,
        height = 262,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-16.png",
        width = 921,
        height = 712,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-17.png",
        width = 722,
        height = 395,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-18.png",
        width = 187,
        height = 289,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-19.png",
        width = 999,
        height = 374,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-20.png",
        width = 783,
        height = 399,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-21.png",
        width = 668,
        height = 406,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-22.png",
        width = 437,
        height = 318,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-23.png",
        width = 394,
        height = 246,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-24.png",
        width = 361,
        height = 291,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-25.png",
        width = 1290,
        height = 1281,
        slice_y = 4,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-26.png",
        width = 314,
        height = 174,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-27.png",
        width = 348,
        height = 264,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-28.png",
        width = 488,
        height = 357,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-29.png",
        width = 594,
        height = 634,
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/sand-decal/sand-decal-30.png",
        width = 195,
        height = 215,
        scale = 0.5
      },
    },
  },
  {
    name = "ll-moon-stone-decal-white",
    type = "optimized-decorative",
    subgroup = "ll-luna",
    order = "b[decorative]-b[red-desert-decal]",
    collision_box = {{-4, -4}, {4, 4}},
    collision_mask = {
      layers = {
        doodad = true,
        water_tile = true,
      },
      not_colliding_with_itself = true
    },
    render_layer = "decals",
    tile_layer = 187, -- under stone-path
    pictures =
    {
      --lightDecal
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-00.png",
        width = 400,
        height = 299,
        shift = util.by_pixel(4.5, -2.25),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-01.png",
        width = 419,
        height = 320,
        shift = util.by_pixel(-0.75, 2),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-02.png",
        width = 417,
        height = 287,
        shift = util.by_pixel(-1.25, 1.25),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-03.png",
        width = 421,
        height = 298,
        shift = util.by_pixel(-0.25, 5.5),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-04.png",
        width = 396,
        height = 302,
        shift = util.by_pixel(6, 4),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-05.png",
        width = 408,
        height = 295,
        shift = util.by_pixel(-2.5, 7.75),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-06.png",
        width = 417,
        height = 317,
        shift = util.by_pixel(-1.25, 3.25),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-07.png",
        width = 419,
        height = 312,
        shift = util.by_pixel(0.75, 2.5),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-08.png",
        width = 413,
        height = 317,
        shift = util.by_pixel(-2.25, 2.25),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-09.png",
        width = 403,
        height = 310,
        shift = util.by_pixel(0.25, 1.5),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-10.png",
        width = 411,
        height = 307,
        shift = util.by_pixel(-0.75, 1.75),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-11.png",
        width = 421,
        height = 295,
        shift = util.by_pixel(-0.25, -0.75),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-12.png",
        width = 420,
        height = 280,
        shift = util.by_pixel(-0.5, -7),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-13.png",
        width = 403,
        height = 311,
        shift = util.by_pixel(0.75, 3.25),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-14.png",
        width = 418,
        height = 304,
        shift = util.by_pixel(0, 2),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-15.png",
        width = 398,
        height = 284,
        shift = util.by_pixel(-3.5, 6.5),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-16.png",
        width = 406,
        height = 313,
        shift = util.by_pixel(4, 0.25),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-17.png",
        width = 420,
        height = 294,
        shift = util.by_pixel(0.5, 4.5),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-18.png",
        width = 379,
        height = 289,
        shift = util.by_pixel(0.25, 5.75),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-19.png",
        width = 401,
        height = 311,
        shift = util.by_pixel(-5.25, 1.25),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-20.png",
        width = 418,
        height = 315,
        shift = util.by_pixel(0.5, 1.25),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-21.png",
        width = 418,
        height = 314,
        shift = util.by_pixel(1, 3),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-22.png",
        width = 421,
        height = 270,
        shift = util.by_pixel(-0.25, 1),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-23.png",
        width = 403,
        height = 290,
        shift = util.by_pixel(2.25, -2.5),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-24.png",
        width = 418,
        height = 315,
        shift = util.by_pixel(-0.5, 2.25),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-25.png",
        width = 414,
        height = 310,
        shift = util.by_pixel(-2, 4),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-26.png",
        width = 403,
        height = 306,
        shift = util.by_pixel(-3.75, 5),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-27.png",
        width = 416,
        height = 303,
        shift = util.by_pixel(1, 0.25),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-28.png",
        width = 422,
        height = 311,
        shift = util.by_pixel(0, 2.25),
        scale = 0.5
      },
      {
        filename = "__alien-biomes-graphics__/graphics/decorative/rock/base/stone-decal/stone-decal-29.png",
        width = 406,
        height = 292,
        shift = util.by_pixel(-3.5, 2),
        scale = 0.5
      },
    },
  },
}

local white_tint = {r = 0.95137254901961, g = 0.92705882352941, b = 0.89960784313725, a = 1}
for _, pic in pairs(data.raw["optimized-decorative"]["ll-moon-stone-decal-white"].pictures) do
  pic.tint = white_tint
end

for _, pic in pairs(data.raw["optimized-decorative"]["ll-moon-sand-decal-white"].pictures) do
  pic.tint = white_tint
end
