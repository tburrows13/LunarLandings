local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

data:extend{
  {
    type = "recipe",
    name = "ll-mass-driver-capsule",
    enabled = false,
    category = "crafting-with-fluid",
    energy_required = 1,
    ingredients =
    {
      {type="item", name="rocket-control-unit", amount=1},
      {type="item", name="ll-heat-shielding", amount=1},
      {type="item", name="ll-aluminium-plate", amount=3},
      {type="item", name="rocket-fuel", amount=1}
    },
    results = {{type="item", name="ll-mass-driver-capsule", amount=1}},
  },
  {
    type = "item",
    name = "ll-mass-driver-capsule",
    icon = "__space-exploration-graphics__/graphics/icons/delivery-cannon-weapon-capsule.png",
    icon_size = 64,
    subgroup = "space-related",
    order = "s[mass-driver-requester]",
    stack_size = 50
  },
  {
    type = "recipe",
    name = "ll-mass-driver-requester",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="requester-chest", amount=1},
      {type="item", name="processing-unit", amount=5},
      {type="item", name="steel-plate", amount=20}
    },
    results = {{type="item", name="ll-mass-driver-requester", amount=1}},
  },
  {
    type = "item",
    name = "ll-mass-driver-requester",
    icon = "__LunarLandings__/graphics/icons/mass-driver-requester.png",
    icon_size = 64,
    subgroup = "space-related",
    order = "r[mass-driver-requester]",
    place_result = "ll-mass-driver-requester",
    stack_size = 10
  },
  {
    type = "logistic-container",
    name = "ll-mass-driver-requester",
    icon = "__LunarLandings__/graphics/icons/mass-driver-requester.png",
    icon_size = 64,
    trash_inventory_size = 18,
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
    impact_category = "metal",
    opened_duration = logistic_chest_opened_duration,
    picture = {layers = {
      {
        filename = '__LunarLandings__/graphics/entities/mass-driver-requester.png',
        height = 199,
        priority = 'high',
        scale = 0.8,
        width = 207
      },
      {
          draw_as_shadow = true,
          filename = '__base__/graphics/entity/artillery-turret/artillery-turret-base-shadow.png',
          height = 149,
          priority = 'high',
          scale = 0.8,
          shift = {0.5625*1.6, 0.5*1.6},
          width = 277,
      },
    }},
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
    ll_surface_conditions = {nauvis = false, luna = true},
  },
  {
    type = "recipe",
    name = "ll-mass-driver",
    enabled = false,
    energy_required = 30,
    ingredients =
    {
      {type="item", name="copper-cable", amount=200},
      {type="item", name="processing-unit", amount=20},
      {type="item", name="steel-plate", amount=100}
    },
    results = {{type="item", name="ll-mass-driver", amount=1}},
  },
  {
    type = "item",
    name = "ll-mass-driver",
    icon = "__base__/graphics/icons/artillery-turret.png",
    icon_size = 64,
    subgroup = "space-related",
    order = "q[mass-driver]",
    place_result = "ll-mass-driver",
    stack_size = 10
  },
  {
    type = "logistic-container",
    name = "ll-mass-driver",
    icon = "__base__/graphics/icons/artillery-turret.png",
    icon_size = 64,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = "ll-mass-driver"},
    max_health = 1000,
    trash_inventory_size = 18,
    corpse = "artillery-turret-remnants",
    dying_explosion = "artillery-turret-explosion",
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    damaged_trigger_effect = hit_effects.entity(),
    fast_replaceable_group = "container",
    inventory_size = 48,
    logistic_mode = "requester",
    use_exact_mode = true,
    inventory_type = "with_filters_and_bar",
    open_sound = sounds.artillery_open,
    close_sound = sounds.artillery_close,
    mined_sound = sounds.deconstruct_large(0.8),
    animation_sound = sounds.logistics_chest_open,
    impact_category = "metal",
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
          width = 112,
          height = 46,
          repeat_count = 1,
          shift = util.by_pixel(12, 4.5),
          draw_as_shadow = true,
          scale = 0.5
        }]]
      }
    },
    circuit_wire_connection_point = circuit_connector_definitions["chest"].points,
    circuit_connector_sprites = circuit_connector_definitions["chest"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance,
    ll_surface_conditions = {nauvis = true, luna = false},
  },
  {
    type = "electric-turret",
    name = "ll-mass-driver-energy-source",
    localised_name = {"entity-name.ll-mass-driver"},
    icon = "__base__/graphics/icons/artillery-turret.png",
    icon_size = 64,
    flags = { "placeable-player", "placeable-enemy", "player-creation"},
    hidden = true,
    --minable = { mining_time = 0.5, result = "laser-turret" },
    max_health = 1000,
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    collision_mask = {layers={}},
    ll_surface_conditions = {nauvis = true, luna = true},
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
    graphics_set = {},
    attack_parameters = {
      ammo_type = { category = "artillery-shell" },
      cooldown = 3600,
      range = 1,
      type = "projectile",
      ammo_category = "laser",
    },
    call_for_help_radius = 1,
  },
  {
    type = "sound",
    name = "ll-mass-driver-kaboom",
    category = "explosion",
    filename = "__LunarLandings__/sound/mass-driver-kaboom.ogg",
    speed = 0.7
  }
}