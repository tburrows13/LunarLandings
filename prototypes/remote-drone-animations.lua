-- From IRobot by Pi-C
------------------------------------------------------------------------------------
--                         Animations of the new character                        --
------------------------------------------------------------------------------------
local IMG_PATH = "__LunarLandings__/graphics/remote-drone/"

-- But melee attacks against biters and enemies is based on per attack, and we're
-- attacking every frame. This means that melee attacking will VAPORIZE any biters
-- that get in range of you. You can start the game and just go on a base killing
-- rampage before doing literally anything.
-- I suggest to put in at least a fake swing animation that takes some frames to
-- complete. It could also fix the loud sound issue.
-- (https://mods.factorio.com/mod/IRobot/discussion/645b12b516f3ee1913dff94f)
--
-- Modifier of the animation playing speed, the default is 1, which means one
-- animation frame per tick (60 fps).
local mining_animation_speed = 10/60

local compilatron_animations = {
  walk = {
    width = 78,
    height = 104,
    frame_count = 2,
    axially_symmetrical = false,
    direction_count = 32,
    shift = util.by_pixel(0.0, -14),
    scale = 0.5,
    stripes = {
      {
        filename = IMG_PATH.."hr-compilatron-walk-1.png",
        width_in_frames = 2,
        height_in_frames = 16
      },
      {
        filename = IMG_PATH.."hr-compilatron-walk-2.png",
        width_in_frames = 2,
        height_in_frames = 16
      }
    },
  },
  walk_mask = {
    width = 78,
    height = 104,
    frame_count = 2,
    axially_symmetrical = false,
    apply_runtime_tint = true,
    direction_count = 32,
    shift = util.by_pixel(0, -14),
    scale = 0.5,
    stripes = util.multiplystripes(2, {
      {
        filename = IMG_PATH.."hr-compilatron-walk-1-mask.png",
        width_in_frames = 1,
        height_in_frames = 16
      },
      {
        filename = IMG_PATH.."hr-compilatron-walk-2-mask.png",
        width_in_frames = 1,
        height_in_frames = 16
      }
    }),
  },
  walk_shadow = {
    width = 142,
    height = 56,
    frame_count = 2,
    axially_symmetrical = false,
    direction_count = 32,
    shift = util.by_pixel(15.5, -0.5),
    draw_as_shadow = true,
    scale = 0.5,
    stripes = util.multiplystripes(2, {
      {
        filename = IMG_PATH.."hr-compilatron-walk-shadow.png",
        width_in_frames = 1,
        height_in_frames = 32
      }
    })
  },
  mining = {
    animation_speed = mining_animation_speed,
    width = 78,
    height = 104,
    frame_count = 2,
    axially_symmetrical = false,
    direction_count = 32,
    shift = util.by_pixel(0.0, -14),
    scale = 0.5,
    stripes = {
      {
        filename = IMG_PATH.."hr-compilatron-walk-1.png",
        width_in_frames = 2,
        height_in_frames = 16
      },
      {
        filename = IMG_PATH.."hr-compilatron-walk-2.png",
        width_in_frames = 2,
        height_in_frames = 16
      }
    },
  },
  mining_mask = {
    animation_speed = mining_animation_speed,
    width = 78,
    height = 104,
    frame_count = 2,
    axially_symmetrical = false,
    apply_runtime_tint = true,
    direction_count = 32,
    shift = util.by_pixel(0, -14),
    scale = 0.5,
    stripes = util.multiplystripes(2, {
      {
        filename = IMG_PATH.."hr-compilatron-walk-1-mask.png",
        width_in_frames = 1,
        height_in_frames = 16
      },
      {
        filename = IMG_PATH.."hr-compilatron-walk-2-mask.png",
        width_in_frames = 1,
        height_in_frames = 16
      }
    }),
  },
  mining_shadow = {
    animation_speed = mining_animation_speed,
    width = 142,
    height = 56,
    frame_count = 2,
    axially_symmetrical = false,
    direction_count = 32,
    shift = util.by_pixel(15.5, -0.5),
    draw_as_shadow = true,
    scale = 0.5,
    stripes = util.multiplystripes(2, {
      {
        filename = IMG_PATH.."hr-compilatron-walk-shadow.png",
        width_in_frames = 1,
        height_in_frames = 32
      }
    })
  },
  running_gun = {
    width = 78,
    height = 104,
    frame_count = 2,
    axially_symmetrical = false,
    direction_count = 18,
    shift = util.by_pixel(0.0, -14),
    scale = 0.5,
    stripes = {
      {
        filename = IMG_PATH.."hr-compilatron-walk-1.png",
        width_in_frames = 2,
        height_in_frames = 16
      },
      {
        filename = IMG_PATH.."hr-compilatron-walk-2.png",
        width_in_frames = 2,
        height_in_frames = 16
      }
    },
  },
  running_gun_mask = {
    width = 78,
    height = 104,
    frame_count = 2,
    axially_symmetrical = false,
    apply_runtime_tint = true,
    direction_count = 18,
    shift = util.by_pixel(0, -14),
    scale = 0.5,
    stripes = util.multiplystripes(2, {
      {
        filename = IMG_PATH.."hr-compilatron-walk-1-mask.png",
        width_in_frames = 1,
        height_in_frames = 16
      },
      {
        filename = IMG_PATH.."hr-compilatron-walk-2-mask.png",
        width_in_frames = 1,
        height_in_frames = 16
      }
    }),
  },
  running_gun_shadow = {
    width = 142,
    height = 56,
    frame_count = 2,
    axially_symmetrical = false,
    direction_count = 18,
    shift = util.by_pixel(19, 0),
    draw_as_shadow = true,
    scale = 0.5,
    stripes = util.multiplystripes(2, {
      {
        filename = IMG_PATH.."hr-compilatron-walk-shadow.png",
        width_in_frames = 1,
        height_in_frames = 32
      }
    })
  },
}


return {
  {
    idle = {
      layers = {
        compilatron_animations.walk,
        compilatron_animations.walk_mask,
        compilatron_animations.walk_shadow,
      }
    },
    idle_with_gun = {
      layers = {
        compilatron_animations.walk,
        compilatron_animations.walk_mask,
        compilatron_animations.walk_shadow,
      }
    },
    mining_with_tool = {
      --~ layers = {
        --~ compilatron_animations.walk,
        --~ compilatron_animations.walk_mask,
        --~ compilatron_animations.walk_shadow,
      --~ }
      layers = {
        compilatron_animations.mining,
        compilatron_animations.mining_mask,
        compilatron_animations.mining_shadow,
      }
    },
    running = {
      layers = {
        compilatron_animations.walk,
        compilatron_animations.walk_mask,
        compilatron_animations.walk_shadow,
      }
    },
    running_with_gun = {
      layers = {
        compilatron_animations.running_gun,
        compilatron_animations.running_gun_mask,
        compilatron_animations.running_gun_shadow,
      }
    },
    flipped_shadow_running_with_gun = {
      layers =
      {
        compilatron_animations.running_gun_shadow
      }
    },
  }
}
