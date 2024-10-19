for i, recipe in pairs({"copper-cable", "electronic-circuit", "advanced-circuit"}) do
  data.raw.recipe[recipe].category = "circuit-crafting"
end

local function add_to_crafting_categories(prototype)
  local crafting_categories = prototype.crafting_categories or {}
  for i, category in pairs(crafting_categories) do
    if category == "crafting" then
      table.insert(crafting_categories, "circuit-crafting")
      break
    end
  end
end

for _, prototype in pairs(data.raw["assembling-machine"]) do
  add_to_crafting_categories(prototype)
end
for _, prototype in pairs(data.raw["character"]) do
  add_to_crafting_categories(prototype)
end

data.raw.recipe["processing-unit"].category = "advanced-circuit-crafting"

local animation_speed = 0.3
data:extend{
  {
    type = "recipe-category",
    name = "circuit-crafting"
  },
  {
    type = "recipe-category",
    name = "advanced-circuit-crafting"
  },
  {
    type = "recipe",
    name = "ll-low-grav-assembling-machine",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="ll-lunar-foundation", amount=20},
      {type="item", name="advanced-circuit", amount=20},
      {type="item", name="steel-plate", amount=10},
      {type="item", name="iron-gear-wheel", amount=20},
    },
    results = {{type="item", name="ll-low-grav-assembling-machine", amount=1}}
  },
  {
    type = "item",
    name = "ll-low-grav-assembling-machine",
    icon = "__LunarLandings__/graphics/icons/low-gravity-assembling-machine.png",
    icon_size = 64,
    subgroup = "production-machine",
    order = "c[assembling-machine-3]",
    place_result = "ll-low-grav-assembling-machine",
    stack_size = 50
  },
  {
    type = "assembling-machine",
    name = "ll-low-grav-assembling-machine",
    icon = "__LunarLandings__/graphics/icons/low-gravity-assembling-machine.png",
    icon_size = 64,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "ll-low-grav-assembling-machine"},
    max_health = 900,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(0, 6),
    entity_info_icon_shift = util.by_pixel(0, 6),
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections = {{ flow_direction="input", direction = defines.direction.north, position = {0, -2} }},
        secondary_draw_orders = { north = -1 }
      },
    },
    fluid_boxes_off_when_no_fluid_recipe = true,
    --open_sound = x_util.machine_open_sound,
    --close_sound = x_util.machine_close_sound, TODO
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t3-1.ogg",
          volume = 0.8
        },
        {
          filename = "__base__/sound/assembling-machine-t3-2.ogg",
          volume = 0.8
        },
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
      apparent_volume = 1.5,
    },
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    collision_mask = {
      layers = {
        water_tile = true,
        item = true,
        object = true,
        player = true,
      }
    },
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    drawing_box = {{-2.5, -2.8}, {2.5, 2.5}},
    graphics_set = {
      animation =
      {
        layers =
        {
          {
            draw_as_shadow = true,
            filename = "__LunarLandings__/graphics/entities/low-gravity-assembling-machine/low-gravity-assembling-machine-shadow.png",
            priority = "high",
            width = 520,
            height = 500,
            frame_count = 1,
            line_length = 1,
            repeat_count = 99,
            animation_speed = animation_speed,
            shift = util.by_pixel_hr(0, -16),
            scale = 0.5,
          },
          {
            priority = "high",
            width = 320,
            height = 320,
            frame_count = 99,
            shift = util.by_pixel_hr(0, -16),
            animation_speed = animation_speed,
            scale = 0.5,
            stripes =
            {
              {
                filename = "__LunarLandings__/graphics/entities/low-gravity-assembling-machine/low-gravity-assembling-machine-animation-1.png",
                width_in_frames = 8,
                height_in_frames = 8,
              },
              {
                filename = "__LunarLandings__/graphics/entities/low-gravity-assembling-machine/low-gravity-assembling-machine-animation-2.png",
                width_in_frames = 8,
                height_in_frames = 8,
              },
            },
          },
        },
      },
      working_visualisations = {{
        fadeout = true,
        secondary_draw_order = 1,
        animation = {
          layers = {
            {
              size = {320, 320},
              shift = util.by_pixel_hr(0, -16),
              scale = 0.5,
              frame_count = 99,
              draw_as_glow = true,
              blend_mode = "additive",
              animation_speed = animation_speed,
              stripes =
              {
                {
                  filename = "__LunarLandings__/graphics/entities/low-gravity-assembling-machine/low-gravity-assembling-machine-animation-emission-1.png",
                  width_in_frames = 8,
                  height_in_frames = 8,
                },
                {
                  filename = "__LunarLandings__/graphics/entities/low-gravity-assembling-machine/low-gravity-assembling-machine-animation-emission-2.png",
                  width_in_frames = 8,
                  height_in_frames = 8,
                },
              },
            },
          },
        },
      }},
    },
    crafting_categories = {"circuit-crafting", "advanced-circuit-crafting"},
    crafting_speed = 2,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 50 },
    },
    energy_usage = "750kW",
    module_slots = 6,
    --module_info_icon_shift = util.by_pixel_hr(0, 32 + (0.7*64)),  -- default is {0, 0.7}
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    --scale_entity_info_icon = true,
    --[[working_visualisations =
    {
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = {intensity = 0.8, size = 20, shift = {0.0, 0.0}, color = {r = 0.7, g = 0.8, b = 1}}
      },
    },]]
    ll_surface_conditions = {nauvis = false, luna = {plain = false, lowland = false, mountain = false, foundation = true}},
  },

}