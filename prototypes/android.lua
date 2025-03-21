

--[[data:extend{

  {
    type = "character",
    name = "ll-andoid",
    icon = "__core__/graphics/icons/entity/character.png",
    icon_size = 64,
    flags = {"placeable-off-grid", "not-repairable", "not-on-map", "not-flammable"},
    max_health = 250,
    alert_when_damaged = false,
    healing_per_tick = 0.15,
    collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
    selection_box = {{-0.4, -1.4}, {0.4, 0.2}},
    hit_visualization_box = {{-0.2, -1.1}, {0.2, 0.2}},
    sticker_box = {{-0.2, -1}, {0.2, 0}},
    crafting_categories = {"crafting"},
    mining_categories = {"basic-solid"},
    character_corpse = "character-corpse",
    inventory_size = 40,
    build_distance = 10,
    drop_item_distance = 10,
    reach_distance = 10,
    item_pickup_distance = 1,
    loot_pickup_distance = 2,
    enter_vehicle_distance = 3,
    reach_resource_distance = 2.7,
    ticks_to_keep_gun = 600,
    ticks_to_keep_aiming_direction = 100,
    --ticks you need to wait after firing a weapon or taking damage to get out of combat and get healed
    ticks_to_stay_in_combat = 600,
    damage_hit_tint = {r = 0.12, g = 0, b = 0, a = 0},
    running_speed = 0.15,
    distance_per_frame = 0.13,
    maximum_corner_sliding_distance = 0.7,
    subgroup = "creatures",
    order="a",
    eat =
    {
      {
        filename = "__base__/sound/eat.ogg",
        volume = 1
      }
    },
    heartbeat =
    {
      {
        filename = "__base__/sound/heartbeat.ogg"
      }
    },
    tool_attack_result =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "damage",
          damage = { amount = 8 , type = "physical"}
        }
      }
    },

    animations =
    {
      {
        idle =
        {
          layers =
          {
            character_animations.level1.idle,
            character_animations.level1.idle_mask,
            character_animations.level1.idle_shadow
          }
        },
        idle_with_gun =
        {
          layers =
          {
            character_animations.level1.idle_gun,
            character_animations.level1.idle_gun_mask,
            character_animations.level1.idle_gun_shadow
          }
        },
        mining_with_tool =
        {
          layers =
          {
            character_animations.level1.mining_tool,
            character_animations.level1.mining_tool_mask,
            character_animations.level1.mining_tool_shadow
          }
        },
        running_with_gun =
        {
          layers =
          {
            character_animations.level1.running_gun,
            character_animations.level1.running_gun_mask,
            character_animations.level1.running_gun_shadow
          }
        },
        flipped_shadow_running_with_gun =
        {
          layers =
          {
            character_animations.level1.running_gun_shadow_flipped
          }
        },
        running =
        {
          layers =
          {
            character_animations.level1.running,
            character_animations.level1.running_mask,
            character_animations.level1.running_shadow
          }
        }
      },
      {
        armors = {"heavy-armor", "modular-armor"},
        idle =
        {
          layers =
          {
            character_animations.level1.idle,
            character_animations.level1.idle_mask,
            character_animations.level2addon.idle,
            character_animations.level2addon.idle_mask,
            character_animations.level1.idle_shadow,
            character_animations.level2addon.idle_shadow
          }
        },
        idle_with_gun =
        {
          layers =
          {
            character_animations.level1.idle_gun,
            character_animations.level1.idle_gun_mask,
            character_animations.level2addon.idle_gun,
            character_animations.level2addon.idle_gun_mask,
            character_animations.level1.idle_gun_shadow,
            character_animations.level2addon.idle_gun_shadow
          }
        },
        mining_with_tool =
        {
          layers =
          {
            character_animations.level1.mining_tool,
            character_animations.level1.mining_tool_mask,
            character_animations.level2addon.mining_tool,
            character_animations.level2addon.mining_tool_mask,
            character_animations.level1.mining_tool_shadow,
            character_animations.level2addon.mining_tool_shadow
          }
        },
        running_with_gun =
        {
          layers =
          {
            character_animations.level1.running_gun,
            character_animations.level1.running_gun_mask,
            character_animations.level2addon.running_gun,
            character_animations.level2addon.running_gun_mask,
            character_animations.level1.running_gun_shadow,
            character_animations.level2addon.running_gun_shadow
          }
        },
        flipped_shadow_running_with_gun =
        {
          layers =
          {
            character_animations.level1.running_gun_shadow_flipped,
            character_animations.level2addon.running_gun_shadow_flipped
          }
        },
        running =
        {
          layers =
          {
            character_animations.level1.running,
            character_animations.level1.running_mask,
            character_animations.level2addon.running,
            character_animations.level2addon.running_mask,
            character_animations.level1.running_shadow,
            character_animations.level2addon.running_shadow
          }
        }
      },
      {
        armors = {"power-armor", "power-armor-mk2"},
        idle =
        {
          layers =
          {
            character_animations.level1.idle,
            character_animations.level1.idle_mask,
            character_animations.level3addon.idle,
            character_animations.level3addon.idle_mask,
            character_animations.level1.idle_shadow,
            character_animations.level3addon.idle_shadow
          }
        },
        idle_with_gun =
        {
          layers =
          {
            character_animations.level1.idle_gun,
            character_animations.level1.idle_gun_mask,
            character_animations.level3addon.idle_gun,
            character_animations.level3addon.idle_gun_mask,
            character_animations.level1.idle_gun_shadow,
            character_animations.level3addon.idle_gun_shadow
          }
        },
        mining_with_tool =
        {
          layers =
          {
            character_animations.level1.mining_tool,
            character_animations.level1.mining_tool_mask,
            character_animations.level3addon.mining_tool,
            character_animations.level3addon.mining_tool_mask,
            character_animations.level1.mining_tool_shadow,
            character_animations.level3addon.mining_tool_shadow
          }
        },
        running_with_gun =
        {
          layers =
          {
            character_animations.level1.running_gun,
            character_animations.level1.running_gun_mask,
            character_animations.level3addon.running_gun,
            character_animations.level3addon.running_gun_mask,
            character_animations.level1.running_gun_shadow,
            character_animations.level3addon.running_gun_shadow
          }
        },
        flipped_shadow_running_with_gun =
        {
          layers =
          {
            character_animations.level1.running_gun_shadow_flipped,
            character_animations.level3addon.running_gun_shadow_flipped
          }
        },
        running =
        {
          layers =
          {
            character_animations.level1.running,
            character_animations.level1.running_mask,
            character_animations.level3addon.running,
            character_animations.level3addon.running_mask,
            character_animations.level1.running_shadow,
            character_animations.level3addon.running_shadow
          }
        }
      }
    },
    light =
    {
      {
        minimum_darkness = 0.3,
        intensity = 0.4,
        size = 25,
        color = {r=1.0, g=1.0, b=1.0}
      },
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {0, -13},
        size = 2,
        intensity = 0.6,
        color = {r=1.0, g=1.0, b=1.0}
      }
    },
    mining_speed = 0.5,
    mining_with_tool_particles_animation_positions = {19},
    running_sound_animation_positions = {5, 16},
    synced_footstep_particle_triggers = movement_triggers.character,
    footprint_particles =
    {
      {
        tiles =
        {
          "dry-dirt",
          "dirt-1", "dirt-2", "dirt-3", "dirt-4","dirt-5", "dirt-6", "dirt-7",
          "sand-1", "sand-2", "sand-3", "nuclear-ground",
          "red-desert-0", "red-desert-1", "red-desert-2", "red-desert-3"
        },
        particle_name = "character-footprint-particle"
      },
      -- no particle by default so that both (synced_)footstep_particle_triggers are consistently not defined for tiles by default
      {
        tiles = {},
        use_as_default = true,
        particle_name = nil
      }
    },
    right_footprint_frames = { 10, 21 },
    left_footprint_frames = {5, 16}, --{ 5 },
    right_footprint_offset = { 0.1, 0 },
    left_footprint_offset = { -0.1, 0 },

    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/character/character-reflection.png",
        priority = "extra-high",
        -- flags = { "linear-magnification", "not-compressed" },
        -- default value: flags = { "terrain-effect-map" },
        width = 13,
        height = 19,
        shift = util.by_pixel(0, 67 * 0.5),
        scale = 5,
        variation_count = 1
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
}]]