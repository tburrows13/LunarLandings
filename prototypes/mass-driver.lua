local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

data:extend{
  {
    type = "recipe",
    name = "ll-mass-driver-capsule",
    enabled = false,
    category = "crafting-with-fluid",
    ingredients =
    {
      {"rocket-control-unit", 1},
      {"ll-heat-shielding", 1},
      {"ll-aluminium-plate", 3},
      {type="fluid", name="ll-rocket-fuel", amount=5}
    },
    results = {{type="item", name="ll-mass-driver-capsule", amount=1}},
  },
  {
    type = "item",
    name = "ll-mass-driver-capsule",
    icon = "__space-exploration-graphics__/graphics/icons/delivery-cannon-weapon-capsule.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "space-related",
    order = "s[mass-driver-requester]",
    stack_size = 50
  },
  {
    type = "recipe",
    name = "ll-mass-driver-requester",
    enabled = false,
    ingredients =
    {
      {"logistic-chest-requester", 1},
      {"processing-unit", 5},
      {"steel-plate", 20}
    },
    results = {{type="item", name="ll-mass-driver-requester", amount=1}},
  },
  {
    type = "item",
    name = "ll-mass-driver-requester",
    icon = "__base__/graphics/icons/logistic-chest-requester.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "space-related",
    order = "r[mass-driver-requester]",
    place_result = "ll-mass-driver-requester",
    stack_size = 50
  },
  {
    type = "logistic-container",
    name = "ll-mass-driver-requester",
    icon = "__base__/graphics/icons/logistic-chest-requester.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = "ll-mass-driver-requester"},
    max_health = 350,
    corpse = "requester-chest-remnants",
    dying_explosion = "requester-chest-explosion",
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    damaged_trigger_effect = hit_effects.entity(),
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    fast_replaceable_group = "container",
    inventory_size = 48,
    logistic_mode = "buffer",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.43 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.43 },
    animation_sound = sounds.logistics_chest_open,
    vehicle_impact_sound = sounds.generic_impact,
    opened_duration = logistic_chest_opened_duration,
    animation =
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/logistic-chest/hr-logistic-chest-requester.png",
          priority = "extra-high",
          width = 66,
          height = 74,
          frame_count = 7,
          shift = util.by_pixel(0, -2),
          scale = 0.5 * 4.5,
          
        },
        {
          filename = "__base__/graphics/entity/logistic-chest/hr-logistic-chest-shadow.png",
          priority = "extra-high",
          width = 112,
          height = 46,
          repeat_count = 7,
          shift = util.by_pixel(12*4,5, 4.5*4,5),
          draw_as_shadow = true,
          scale = 0.5 * 4.5
        }
      }
    },
    circuit_wire_connection_point = circuit_connector_definitions["chest"].points,
    circuit_connector_sprites = circuit_connector_definitions["chest"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance,
    created_effect = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          {
            type = "script",
            effect_id = "ll-mass-driver-requester-created",
          },
        }
      }
    },
    surface_conditions = {nauvis = false, luna = true},
  },
  {
    type = "recipe",
    name = "ll-mass-driver",
    enabled = false,
    ingredients =
    {
      {"copper-cable", 200},
      {"processing-unit", 20},
      {"steel-plate", 100}
    },
    results = {{type="item", name="ll-mass-driver", amount=1}},
  },
  {
    type = "item",
    name = "ll-mass-driver",
    icon = "__base__/graphics/icons/artillery-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "space-related",
    order = "q[mass-driver]",
    place_result = "ll-mass-driver",
    stack_size = 50
  },
  {
    type = "logistic-container",
    name = "ll-mass-driver",
    icon = "__base__/graphics/icons/artillery-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = "ll-mass-driver"},
    max_health = 1000,
    corpse = "artillery-turret-remnants",
    dying_explosion = "artillery-turret-explosion",
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    drawing_box = {{-2.5, -6}, {2.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    fast_replaceable_group = "container",
    inventory_size = 48,
    logistic_mode = "requester",
    inventory_type = "with_filters_and_bar",
    open_sound = sounds.artillery_open,
    close_sound = sounds.artillery_close,
    mined_sound = sounds.deconstruct_large(0.8),
    animation_sound = sounds.logistics_chest_open,
    vehicle_impact_sound = sounds.generic_impact,
    opened_duration = logistic_chest_opened_duration,
    animation =
    {
      layers =
      {
        {
          filename = "__LunarLandings__/graphics/entities/mass-driver.png",
          priority = "extra-high",
          width = 266,
          height = 358,
          frame_count = 1,
          scale = 0.75,
          shift = util.by_pixel(0, -50),
        },
        --[[{
          filename = "__base__/graphics/entity/logistic-chest/logistic-chest-shadow.png",
          priority = "extra-high",
          width = 56,
          height = 24,
          repeat_count = 1,
          shift = util.by_pixel(12, 5),
          draw_as_shadow = true,
          hr_version =
          {
            filename = "__base__/graphics/entity/logistic-chest/hr-logistic-chest-shadow.png",
            priority = "extra-high",
            width = 112,
            height = 46,
            repeat_count = 1,
            shift = util.by_pixel(12, 4.5),
            draw_as_shadow = true,
            scale = 0.5
          }
        }]]
      }
    },
    circuit_wire_connection_point = circuit_connector_definitions["chest"].points,
    circuit_connector_sprites = circuit_connector_definitions["chest"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance,
    surface_conditions = {nauvis = true, luna = false},
  },
  {
    type = "electric-turret",
    name = "ll-mass-driver-energy-source",
    localised_name = {"entity-name.ll-mass-driver"},
    icon = "__base__/graphics/icons/artillery-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "placeable-player", "placeable-enemy", "player-creation"},
    --minable = { mining_time = 0.5, result = "laser-turret" },
    max_health = 1000,
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    collision_mask = {},
    surface_conditions = {nauvis = true, luna = true},
    --damaged_trigger_effect = hit_effects.entity(),
    --rotation_speed = 0.01,
    --preparing_speed = 0.05,
    --preparing_sound = sounds.laser_turret_activate,
    --folding_sound = sounds.laser_turret_deactivate,
    --corpse = "laser-turret-remnants",
    --dying_explosion = "laser-turret-explosion",
    --folding_speed = 0.05,
    energy_source = {
      type = "electric",
      drain = "5MW",
      buffer_capacity = "200MJ",
      input_flow_limit = "20MW",
      usage_priority = "secondary-input"
    },
    folded_animation = util.empty_sprite(1),
    attack_parameters = {
      ammo_type = { category = "artillery-shell" },
      cooldown = 3600,
      range = 1,
      type = "projectile"
    },
    call_for_help_radius = 1,
  },

}