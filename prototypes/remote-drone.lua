-- From IRobot by Pi-C

local drone = table.deepcopy(data.raw.character.character)

local IMG_PATH = "__LunarLandings__/graphics/remote-drone/"

drone.name = "ll-remote-drone"

drone.icon = IMG_PATH.."irobot-icon.png"
drone.icon_size = 64

drone.animations = require("remote-drone-animations")
drone.character_corpse = "ll-remote-drone-corpse"
--drone.heartbeat  -- TODO
--drone.vehicle_impact_sound


local corpse = table.deepcopy(data.raw["character-corpse"]["character-corpse"])
corpse.name = "ll-remote-drone-corpse"
corpse.icon = IMG_PATH.."corpse-icon.png"
corpse.icon_size = 128
corpse.pictures = nil
corpse.armor_picture_mapping = nil
corpse.pictures = {  -- TODO get alternate corpse variation to appear
  layers = {
    {
      filename          = IMG_PATH.."compilatron-corpse.png",
      frame_count       = 2,
      size              = 64,
      hr_version        = {
        filename    = IMG_PATH.."hr-compilatron-corpse.png",
        frame_count = 2,
        size        = 128,
        scale       = 0.5,
      },
    },
    {
      filename          = IMG_PATH.."compilatron-corpse-mask.png",
      apply_runtime_tint = true,
      frame_count       = 2,
      size              = 64,
      hr_version        = {
        filename           = IMG_PATH.."hr-compilatron-corpse-mask.png",
        apply_runtime_tint = true,
        frame_count        = 2,
        size               = 128,
        scale              = 0.5,
      },
    },
  },
}

data:extend{drone, corpse}