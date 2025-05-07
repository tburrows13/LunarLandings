local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")

data:extend{
  {
    type = "recipe",
    name = "ll-ion-logistic-robot",
    enabled = false,
    ingredients =
    {
      {type = "item", name = "flying-robot-frame", amount = 1},
      {type = "item", name = "low-density-structure", amount = 2},
      {type = "item", name = "processing-unit", amount = 1}
    },
    results = {{type="item", name="ll-ion-logistic-robot", amount=1}}
  },
  {
    type = "item",
    name = "ll-ion-logistic-robot",
    icon = "__LunarLandings__/graphics/icons/ion-logistic-robot.png",
    subgroup = "logistic-network",
    order = "a[robot]-c[ion-logistic-robot]",
    inventory_move_sound = item_sounds.robotic_inventory_move,
    pick_sound = item_sounds.robotic_inventory_pickup,
    drop_sound = item_sounds.robotic_inventory_move,
    place_result = "ll-ion-logistic-robot",
    stack_size = 50,
    random_tint_color = item_tints.iron_rust
  },
  {
    type = "recipe",
    name = "ll-ion-construction-robot",
    enabled = false,
    ingredients =
    {
      {type = "item", name = "flying-robot-frame", amount = 1},
      {type = "item", name = "low-density-structure", amount = 2},
      {type = "item", name = "processing-unit", amount = 1}
    },
    results = {{type="item", name="ll-ion-construction-robot", amount=1}}
  },
  {
    type = "item",
    name = "ll-ion-construction-robot",
    icon = "__LunarLandings__/graphics/icons/ion-construction-robot.png",
    subgroup = "logistic-network",
    order = "a[robot]-d[ion-construction-robot]",
    inventory_move_sound = item_sounds.robotic_inventory_move,
    pick_sound = item_sounds.robotic_inventory_pickup,
    drop_sound = item_sounds.robotic_inventory_move,
    place_result = "ll-ion-construction-robot",
    stack_size = 50,
    random_tint_color = item_tints.iron_rust
  },
  {
    type = "recipe",
    name = "ll-ion-roboport",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type = "item", name = "pump", amount = 5},
      {type = "item", name = "steel-plate", amount = 45},
      {type = "item", name = "processing-unit", amount = 20}
    },
    results = {{type="item", name="ll-ion-roboport", amount=1}}
  },
  {
    type = "item",
    name = "ll-ion-roboport",
    icon = "__LunarLandings__/graphics/icons/ion-roboport.png",
    subgroup = "logistic-network",
    order = "c[signal]-b[ion-roboport]",
    inventory_move_sound = item_sounds.roboport_inventory_move,
    pick_sound = item_sounds.roboport_inventory_pickup,
    drop_sound = item_sounds.roboport_inventory_move,
    place_result = "ll-ion-roboport",
    stack_size = 10,
    weight = 100*kg,
    random_tint_color = item_tints.iron_rust
  },
}

local sparks =
{
  {
    filename = "__base__/graphics/entity/sparks/sparks-01.png",
    draw_as_glow = true,
    width = 39,
    height = 34,
    frame_count = 19,
    line_length = 19,
    shift = {-0.109375, 0.3125},
    tint = {1.0, 0.9, 0.0, 1.0},
    animation_speed = 0.3
  },
  {
    filename = "__base__/graphics/entity/sparks/sparks-02.png",
    draw_as_glow = true,
    width = 36,
    height = 32,
    frame_count = 19,
    line_length = 19,
    shift = {0.03125, 0.125},
    tint = {1.0, 0.9, 0.0, 1.0},
    animation_speed = 0.3
  },
  {
    filename = "__base__/graphics/entity/sparks/sparks-03.png",
    draw_as_glow = true,
    width = 42,
    height = 29,
    frame_count = 19,
    line_length = 19,
    shift = {-0.0625, 0.203125},
    tint = {1.0, 0.9, 0.0, 1.0},
    animation_speed = 0.3
  },
  {
    filename = "__base__/graphics/entity/sparks/sparks-04.png",
    draw_as_glow = true,
    width = 40,
    height = 35,
    frame_count = 19,
    line_length = 19,
    shift = {-0.0625, 0.234375},
    tint = {1.0, 0.9, 0.0, 1.0},
    animation_speed = 0.3
  },
  {
    filename = "__base__/graphics/entity/sparks/sparks-05.png",
    draw_as_glow = true,
    width = 39,
    height = 29,
    frame_count = 19,
    line_length = 19,
    shift = {-0.109375, 0.171875},
    tint = {1.0, 0.9, 0.0, 1.0},
    animation_speed = 0.3
  },
  {
    filename = "__base__/graphics/entity/sparks/sparks-06.png",
    draw_as_glow = true,
    width = 44,
    height = 36,
    frame_count = 19,
    line_length = 19,
    shift = {0.03125, 0.3125},
    tint = {1.0, 0.9, 0.0, 1.0},
    animation_speed = 0.3
  }
}


local ion_roboport_pipe_pictures = assembler2pipepictures()
ion_roboport_pipe_pictures.north = util.empty_sprite()

data:extend{
  {
    type = "logistic-robot",
    name = "ll-ion-logistic-robot",
    icon = "__LunarLandings__/graphics/icons/ion-logistic-robot.png",
    flags = {"placeable-player", "player-creation", "placeable-off-grid", "not-on-map"},
    minable = {mining_time = 0.1, result = "ll-ion-logistic-robot"},
    is_military_target = false,
    resistances =
    {
      {
        type = "fire",
        percent = 85
      }
    },
    max_health = 1000,
    collision_box = {{0, 0}, {0, 0}},
    selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
    hit_visualization_box = {{-0.1, -1.1}, {0.1, -1.0}},
    damaged_trigger_effect = hit_effects.flying_robot(),
    dying_explosion = "logistic-robot-explosion",
    --factoriopedia_simulation = simulations.factoriopedia_logistic_robot,
    max_payload_size = 5,
    speed = 0.02,
    max_energy = "1.5MJ",
    energy_per_tick = "0.05kJ",
    speed_multiplier_when_out_of_energy = 0.2,
    energy_per_move = "5kJ",
    min_to_charge = 0.2,
    max_to_charge = 0.95,
    working_sound = sounds.flying_robot(0.48),
    charging_sound = sounds.robot_charging,
    icon_draw_specification = {shift = {0, -0.2}, scale = 0.5, render_layer = "air-entity-info-icon"},
    water_reflection = robot_reflection(1),
    idle = {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-logistic-robot.png",
      priority = "high",
      line_length = 16,
      width = 256,
      height = 256,
      shift = util.by_pixel(0, -3),
      direction_count = 16,
      frame_count = 1,
      scale = 0.2
    },
    idle_with_cargo =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-logistic-robot.png",
      priority = "high",
      line_length = 16,
      width = 256,
      height = 256,
      shift = util.by_pixel(0, -3),
      direction_count = 16,
      frame_count = 1,
      scale = 0.2
    },
    in_motion =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-logistic-robot.png",
      priority = "high",
      line_length = 16,
      width = 256,
      height = 256,
      shift = util.by_pixel(0, -3),
      direction_count = 16,
      frame_count = 1,
      scale = 0.2
    },
    in_motion_with_cargo =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-logistic-robot.png",
      priority = "high",
      line_length = 16,
      width = 256,
      height = 256,
      shift = util.by_pixel(0, -3),
      direction_count = 16,
      frame_count = 1,
      scale = 0.2
    },
    shadow_idle =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-logistic-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 128,
      height = 128,
      shift = util.by_pixel(31.75, 19.75),
      direction_count = 16,
      frame_count = 1,
      scale = 0.4,
      draw_as_shadow = true
    },
    shadow_idle_with_cargo =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-logistic-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 128,
      height = 128,
      shift = util.by_pixel(31.75, 19.75),
      direction_count = 16,
      frame_count = 1,
      scale = 0.4,
      draw_as_shadow = true
    },
    shadow_in_motion =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-logistic-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 128,
      height = 128,
      shift = util.by_pixel(31.75, 19.75),
      direction_count = 16,
      frame_count = 1,
      scale = 0.4,
      draw_as_shadow = true
    },
    shadow_in_motion_with_cargo =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-logistic-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 128,
      height = 128,
      shift = util.by_pixel(31.75, 19.75),
      direction_count = 16,
      frame_count = 1,
      scale = 0.4,
      draw_as_shadow = true
    },
  },
  {
    type = "construction-robot",
    name = "ll-ion-construction-robot",
    icon = "__LunarLandings__/graphics/icons/ion-construction-robot.png",
    flags = {"placeable-player", "player-creation", "placeable-off-grid", "not-on-map"},
    minable = {mining_time = 0.1, result = "ll-ion-construction-robot"},
    resistances =
    {
      {
        type = "fire",
        percent = 85
      },
      {
        type = "electric",
        percent = 50
      }
    },
    max_health = 1000,
    collision_box = {{0, 0}, {0, 0}},
    selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
    hit_visualization_box = {{-0.1, -1.1}, {0.1, -1.0}},
    damaged_trigger_effect = hit_effects.flying_robot(),
    dying_explosion = "construction-robot-explosion",
    --factoriopedia_simulation = simulations.factoriopedia_construction_robot,
    max_payload_size = 5,
    speed = 0.06,
    max_energy = "3MJ",
    energy_per_tick = "0.05kJ",
    speed_multiplier_when_out_of_energy = 0.2,
    energy_per_move = "5kJ",
    min_to_charge = 0.2,
    max_to_charge = 0.95,
    smoke =
    {
      filename = "__base__/graphics/entity/smoke-construction/smoke-01.png",
      width = 39,
      height = 32,
      frame_count = 19,
      line_length = 19,
      shift = {0.078125, -0.15625},
      animation_speed = 0.3
    },
    sparks = sparks,
    repairing_sound = sound_variations("__base__/sound/robot-repair", 6, 0.6),
    working_sound = sounds.construction_robot(0.47),
    charging_sound = sounds.robot_charging,
    mined_sound_volume_modifier = 0.6,
    icon_draw_specification = {shift = {0, -0.2}, scale = 0.5, render_layer = "air-entity-info-icon"},
    construction_vector = {0.30, 0.22},
    water_reflection = robot_reflection(1),
    idle = {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-construction-robot.png",
      priority = "high",
      line_length = 16,
      width = 256,
      height = 256,
      shift = util.by_pixel(0, -3),
      direction_count = 16,
      frame_count = 1,
      scale = 0.2
    },
    idle_with_cargo =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-construction-robot.png",
      priority = "high",
      line_length = 16,
      width = 256,
      height = 256,
      shift = util.by_pixel(0, -3),
      direction_count = 16,
      frame_count = 1,
      scale = 0.2
    },
    in_motion =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-construction-robot.png",
      priority = "high",
      line_length = 16,
      width = 256,
      height = 256,
      shift = util.by_pixel(0, -3),
      direction_count = 16,
      frame_count = 1,
      scale = 0.2
    },
    in_motion_with_cargo =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-construction-robot.png",
      priority = "high",
      line_length = 16,
      width = 256,
      height = 256,
      shift = util.by_pixel(0, -3),
      direction_count = 16,
      frame_count = 1,
      scale = 0.2
    },
    working =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-construction-robot.png",
      priority = "high",
      line_length = 16,
      width = 256,
      height = 256,
      shift = util.by_pixel(0, -3),
      direction_count = 16,
      frame_count = 1,
      scale = 0.2
    },
    shadow_idle =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-construction-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 128,
      height = 128,
      shift = util.by_pixel(31.75, 19.75),
      direction_count = 16,
      frame_count = 1,
      scale = 0.4,
      draw_as_shadow = true
    },
    shadow_idle_with_cargo =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-construction-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 128,
      height = 128,
      shift = util.by_pixel(31.75, 19.75),
      direction_count = 16,
      frame_count = 1,
      scale = 0.4,
      draw_as_shadow = true
    },
    shadow_in_motion =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-construction-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 128,
      height = 128,
      shift = util.by_pixel(31.75, 19.75),
      direction_count = 16,
      frame_count = 1,
      scale = 0.4,
      draw_as_shadow = true
    },
    shadow_in_motion_with_cargo =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-construction-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 128,
      height = 128,
      shift = util.by_pixel(31.75, 19.75),
      direction_count = 16,
      frame_count = 1,
      scale = 0.4,
      draw_as_shadow = true
    },
    shadow_working =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-construction-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 128,
      height = 128,
      shift = util.by_pixel(31.75, 19.75),
      direction_count = 16,
      frame_count = 1,
      scale = 0.4,
      draw_as_shadow = true
    },
  },
  {
    type = "roboport",
    name = "ll-ion-roboport",
    icon = "__LunarLandings__/graphics/icons/ion-roboport.png",
    flags = {"placeable-player", "player-creation"},
    fast_replaceable_group = "roboport",
    minable = {mining_time = 0.1, result = "ll-ion-roboport"},
    max_health = 500,
    corpse = "roboport-remnants",  -- TODO big-remnants ?
    dying_explosion = "roboport-explosion",  -- TODO medium-explosion?
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    damaged_trigger_effect = hit_effects.entity(),
    resistances =
    {
      {
        type = "fire",
        percent = 60
      },
      {
        type = "impact",
        percent = 30
      }
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "5MW",
      buffer_capacity = "100MJ"
    },
    recharge_minimum = "40MJ",
    energy_usage = "50kW",
    -- per one charge slot
    charging_energy = "500kW",
    logistics_radius = 25,
    construction_radius = 55,
    charge_approach_distance = 5,
    robot_slots_count = 7,
    material_slots_count = 7,
    stationing_offset = {0, 0},
    -- stationing_offset = {0, -0.5},
    charging_offsets = {{-1.5, -0.5}, {1.5, -0.5}, {-1, 1}, {1, 1}, {-1, -1.3}, {1, -1.3}},
    robots_shrink_when_entering_and_exiting = true,
    base =
    {
      layers =
      {
        {
          filename = "__LunarLandings__/graphics/entities/ion-robot/ion-roboport-base.png",
          width = 512,
          height = 512,
          scale = 0.39,
          shift = util.by_pixel(0, 5),
        },
        --[[{
          filename = "__base__/graphics/entity/roboport/roboport-shadow.png",
          width = 294,
          height = 201,
          draw_as_shadow = true,
          shift = util.by_pixel(28.5, 9.25),
          scale = 0.5
        }]]
      }
    },
    --[[base_patch =
    {
      filename = "__base__/graphics/entity/roboport/roboport-base-patch.png",
      priority = "medium",
      width = 138,
      height = 100,
      shift = util.by_pixel(1.5, -5),
      scale = 0.5
    },]]
    --[[base_animation =
    {
      filename = "__base__/graphics/entity/roboport/roboport-base-animation.png",
      priority = "medium",
      width = 83,
      height = 59,
      frame_count = 8,
      animation_speed = 0.5,
      shift = util.by_pixel(-17.75, -71.25),
      scale = 0.5
    },]]
    door_animation_up =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-roboport-animation.png",
      priority = "medium",
      width = 512,
      height = 512,
      scale = 0.39,
      line_length = 5,
      animation_speed = 0.5,
      frame_count = 5,
      --shift = util.by_pixel(-0.25, -39.5),
    },
    door_animation_down =
    {
      filename = "__LunarLandings__/graphics/entities/ion-robot/ion-roboport-animation.png",
      priority = "medium",
      width = 512,
      height = 512,
      scale = 0.39,
      line_length = 5,
      animation_speed = 0.5,
      frame_count = 5,
      --shift = util.by_pixel(-0.25, -19.75),
    },
    recharging_animation =
    {
      filename = "__base__/graphics/entity/roboport/roboport-recharging.png",
      draw_as_glow = true,
      priority = "high",
      width = 37,
      height = 35,
      frame_count = 16,
      scale = 1.5,
      animation_speed = 0.5,
    },
    impact_category = "metal",
    open_sound = {filename = "__base__/sound/open-close/roboport-open.ogg", volume = 0.5},
    close_sound = {filename = "__base__/sound/open-close/roboport-close.ogg", volume = 0.4},
    working_sound =
    {
      sound = {filename = "__base__/sound/roboport-working.ogg", volume = 0.4, audible_distance_modifier = 0.75},
      max_sounds_per_prototype = 3,
    },
    recharging_light = {intensity = 0.2, size = 3, color = {0.5, 0.5, 1}},
    request_to_open_door_timeout = 15,
    spawn_and_station_height = 0.3,
    stationing_render_layer_swap_height = 0.87,
    radar_visualisation_color = {0.059, 0.092, 0.235, 0.275},

    draw_logistic_radius_visualization = true,
    draw_construction_radius_visualization = true,

    --open_door_trigger_effect = sounds.roboport_door_open,
    --close_door_trigger_effect = sounds.roboport_door_close,

    circuit_connector = circuit_connector_definitions["roboport"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,

    default_available_logistic_output_signal = {type = "virtual", name = "signal-X"},
    default_total_logistic_output_signal = {type = "virtual", name = "signal-Y"},
    default_available_construction_output_signal = {type = "virtual", name = "signal-Z"},
    default_total_construction_output_signal = {type = "virtual", name = "signal-T"},
    default_roboport_count_output_signal = {type = "virtual", name = "signal-R"},

    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/roboport/roboport-reflection.png",
        priority = "extra-high",
        width = 28,
        height = 28,
        shift = util.by_pixel(0, 65),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    },
    created_effect = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          {
            type = "script",
            effect_id = "ll-ion-roboport-created",
          },
        }
      }
    },
  },
  {
    type = "storage-tank",
    name = "ll-ion-roboport-fluidbox",
    icon = "__base__/graphics/icons/storage-tank.png",
    icon_size = 64,
    flags = {"placeable-player", "player-creation"},
    hidden = true,
    --minable = {mining_time = 0.5, result = "storage-tank"},
    max_health = 500,
    corpse = "storage-tank-remnants",
    --dying_explosion = "storage-tank-explosion",
    collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    selection_priority = 1,
    collision_mask = {layers={}},
    --damaged_trigger_effect = hit_effects.entity(),
    fluid_box =
    {
      volume = 400,
      pipe_picture = ion_roboport_pipe_pictures,
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        { direction = defines.direction.east, position = {2, 0} },
        { direction = defines.direction.west, position = {-2, 0} },
        { direction = defines.direction.south, position = {0, 2} },
        { direction = defines.direction.north, position = {0, -2} }
      },
      hide_connection_info = false,
      filter = "ll-oxygen"
    },
    --two_direction_only = true,
    window_bounding_box = {{-0.125, 0.6875}, {0.1875, 1.1875}},
    pictures =
    {
      picture = util.empty_sprite(),
      fluid_background = util.empty_sprite(),
      window_background = util.empty_sprite(),
      flow_sprite = util.empty_sprite(),
      gas_flow = util.empty_sprite(1),
    },
    flow_length_in_ticks = 360,
  },
}