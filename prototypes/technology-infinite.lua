
local infinite_mining_productivity = data.raw.technology["mining-productivity-4"]
infinite_mining_productivity.name = "mining-productivity-6"
infinite_mining_productivity.prerequisites = {"mining-productivity-5", "space-science-pack"}
infinite_mining_productivity.unit.count_formula = "2500*(L - 5)" -- "2500*(L - 3)"
data:extend{
  infinite_mining_productivity,
  {
    type = "technology",
    name = "mining-productivity-4",
    icon_size = 256,
    icons = util.technology_icon_constant_productivity("__base__/graphics/technology/mining-productivity.png"),
    effects =
    {
      {
        type = "mining-drill-productivity-bonus",
        modifier = 0.1
      }
    },
    prerequisites = {"mining-productivity-3", "ll-space-science-pack"},
    unit =
    {
      count = 1500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "c-k-f-e"
  },
  {
    type = "technology",
    name = "mining-productivity-5",
    icon_size = 256,
    icons = util.technology_icon_constant_productivity("__base__/graphics/technology/mining-productivity.png"),
    effects =
    {
      {
        type = "mining-drill-productivity-bonus",
        modifier = 0.1
      }
    },
    prerequisites = {"mining-productivity-4", "ll-quantum-science-pack"},
    unit =
    {
      count = 2000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
        {"ll-quantum-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "c-k-f-e"
  },
}

local infinite_bot_speed = data.raw.technology["worker-robots-speed-6"]
infinite_bot_speed.name = "worker-robots-speed-8"
infinite_bot_speed.prerequisites = {"worker-robots-speed-7", "space-science-pack"}
infinite_bot_speed.unit.count_formula = "2^(L-8)*1000"
data:extend{
  infinite_bot_speed,
  {
    type = "technology",
    name = "worker-robots-speed-6",
    icon_size = 256,
    icons = util.technology_icon_constant_speed("__base__/graphics/technology/worker-robots-speed.png"),
    effects =
    {
      {
        type = "worker-robot-speed",
        modifier = 0.1
      }
    },
    prerequisites = {"worker-robots-speed-5", "ll-space-science-pack"},
    unit =
    {
      count = 700,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "c-k-f-e"
  },
  {
    type = "technology",
    name = "worker-robots-speed-7",
    icon_size = 256,
    icons = util.technology_icon_constant_speed("__base__/graphics/technology/worker-robots-speed.png"),
    effects =
    {
      {
        type = "worker-robot-speed",
        modifier = 0.1
      }
    },
    prerequisites = {"worker-robots-speed-6", "ll-quantum-science-pack"},
    unit =
    {
      count = 800,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
        {"ll-quantum-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "c-k-f-e"
  },
}

local physical_projectile_damage_2_icon = "__base__/graphics/technology/physical-projectile-damage-2.png"
local infinite_physical_projectile_damage = data.raw.technology["physical-projectile-damage-7"]
infinite_physical_projectile_damage.name = "physical-projectile-damage-9"
infinite_physical_projectile_damage.prerequisites = {"physical-projectile-damage-8", "space-science-pack"}
infinite_physical_projectile_damage.unit.count_formula = "2^(L-9)*1000"
data:extend{
  infinite_physical_projectile_damage,
  {
    type = "technology",
    name = "physical-projectile-damage-7",
    icon_size = 256,
    icons = util.technology_icon_constant_damage(physical_projectile_damage_2_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bullet",
        modifier = 0.1
      },
      {
        type = "ammo-damage",
        ammo_category = "shotgun-shell",
        modifier = 0.1
      }
    },
    prerequisites = {"physical-projectile-damage-6", "ll-space-science-pack"},
    unit =
    {
      count = 100*7,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-f"
  },
  {
    type = "technology",
    name = "physical-projectile-damage-8",
    icon_size = 256,
    icons = util.technology_icon_constant_damage(physical_projectile_damage_2_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "bullet",
        modifier = 0.4
      },
      {
        type = "turret-attack",
        turret_id = "gun-turret",
        modifier = 0.7
      },
      {
        type = "ammo-damage",
        ammo_category = "shotgun-shell",
        modifier = 0.4
      },
      {
        type = "ammo-damage",
        ammo_category = "cannon-shell",
        modifier = 1
      }
    },
    prerequisites = {"physical-projectile-damage-7", "ll-quantum-science-pack"},
    unit =
    {
      count = 100*8,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
        {"ll-quantum-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-f"
  },
}

local laser_weapons_damage_3_icon = "__base__/graphics/technology/laser-weapons-damage.png"
local infinite_laser_weapons_damage = data.raw.technology["laser-weapons-damage-7"]
infinite_laser_weapons_damage.name = "laser-weapons-damage-9"
infinite_laser_weapons_damage.prerequisites = {"laser-weapons-damage-8", "space-science-pack"}
infinite_laser_weapons_damage.unit.count_formula = "2^(L-9)*1000"
data:extend{
  infinite_laser_weapons_damage,
  {
    type = "technology",
    name = "laser-weapons-damage-7",
    icon_size = 256,
    icons = util.technology_icon_constant_damage(laser_weapons_damage_3_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "laser",
        modifier = 0.7
      },
      {
        type = "ammo-damage",
        ammo_category = "electric",
        modifier = 0.7
      },
      {
        type = "ammo-damage",
        ammo_category = "beam",
        modifier = 0.3
      }
    },
    prerequisites = {"laser-weapons-damage-6", "ll-space-science-pack"},
    unit =
    {
      count = 100*7,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-f"
  },
  {
    type = "technology",
    name = "laser-weapons-damage-8",
    icon_size = 256,
    icons = util.technology_icon_constant_damage(laser_weapons_damage_3_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "laser",
        modifier = 0.7
      },
      {
        type = "ammo-damage",
        ammo_category = "electric",
        modifier = 0.7
      },
      {
        type = "ammo-damage",
        ammo_category = "beam",
        modifier = 0.3
      }
    },
    prerequisites = {"laser-weapons-damage-7", "ll-quantum-science-pack"},
    unit =
    {
      count = 100*8,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
        {"ll-quantum-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-f"
  },
}

local stronger_explosives_3_icon = "__base__/graphics/technology/stronger-explosives-3.png"
local infinite_stronger_explosives = data.raw.technology["stronger-explosives-7"]
infinite_stronger_explosives.name = "stronger-explosives-9"
infinite_stronger_explosives.prerequisites = {"stronger-explosives-8", "space-science-pack"}
infinite_stronger_explosives.unit.count_formula = "2^(L-9)*1000"
data:extend{
  infinite_stronger_explosives,
  {
    type = "technology",
    name = "stronger-explosives-7",
    icon_size = 256,
    icons = util.technology_icon_constant_damage(stronger_explosives_3_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "rocket",
        modifier = 0.5
      },
      {
        type = "ammo-damage",
        ammo_category = "grenade",
        modifier = 0.2
      },
      {
        type = "ammo-damage",
        ammo_category = "landmine",
        modifier = 0.2
      }
    },
    prerequisites = {"stronger-explosives-6", "ll-space-science-pack"},
    unit =
    {
      count = 100*7,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-f"
  },
  {
    type = "technology",
    name = "stronger-explosives-8",
    icon_size = 256,
    icons = util.technology_icon_constant_damage(stronger_explosives_3_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "rocket",
        modifier = 0.5
      },
      {
        type = "ammo-damage",
        ammo_category = "grenade",
        modifier = 0.2
      },
      {
        type = "ammo-damage",
        ammo_category = "landmine",
        modifier = 0.2
      }
    },
    prerequisites = {"stronger-explosives-7", "ll-quantum-science-pack"},
    unit =
    {
      count = 100*8,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
        {"ll-quantum-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-f"
  },
}

local refined_flammables_icon = "__base__/graphics/technology/refined-flammables.png"
local infinite_refined_flammables = data.raw.technology["refined-flammables-7"]
infinite_refined_flammables.name = "refined-flammables-9"
infinite_refined_flammables.prerequisites = {"refined-flammables-8", "space-science-pack"}
infinite_refined_flammables.unit.count_formula = "2^(L-9)*1000"

data:extend{
  infinite_refined_flammables,
  {
    type = "technology",
    name = "refined-flammables-7",
    icon_size = 256,
    icons = util.technology_icon_constant_damage(refined_flammables_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "flamethrower",
        modifier = 0.2
      },
      {
        type = "turret-attack",
        turret_id = "flamethrower-turret",
        modifier = 0.2
      }
    },
    prerequisites = {"refined-flammables-6", "ll-space-science-pack"},
    unit =
    {
      count = 100*7,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-f"
  },
  {
    type = "technology",
    name = "refined-flammables-8",
    icon_size = 256,
    icons = util.technology_icon_constant_damage(refined_flammables_icon),
    effects =
    {
      {
        type = "ammo-damage",
        ammo_category = "flamethrower",
        modifier = 0.2
      },
      {
        type = "turret-attack",
        turret_id = "flamethrower-turret",
        modifier = 0.2
      }
    },
    prerequisites = {"refined-flammables-7", "ll-quantum-science-pack"},
    unit =
    {
      count = 100*8,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
        {"ll-quantum-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-f"
  },
}

local infinite_artillery_range = data.raw.technology["artillery-shell-range-1"]
infinite_artillery_range.name = "artillery-shell-range-3"
infinite_artillery_range.prerequisites = {"artillery-shell-range-2", "space-science-pack"}
infinite_artillery_range.unit.count_formula = "2^(L-2)*1000"
infinite_artillery_range.upgrade = true
data:extend{
  infinite_artillery_range,
  {
    type = "technology",
    name = "artillery-shell-range-1",
    icon_size = 256,
    icons = util.technology_icon_constant_range("__base__/graphics/technology/artillery-range.png"),
    effects =
    {
      {
        type = "artillery-range",
        modifier = 0.3
      }
    },
    prerequisites = {"artillery", "ll-space-science-pack"},
    unit =
    {
      count = 1000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "e-k-d"
  },
  {
    type = "technology",
    name = "artillery-shell-range-2",
    icon_size = 256,
    icons = util.technology_icon_constant_range("__base__/graphics/technology/artillery-range.png"),
    effects =
    {
      {
        type = "artillery-range",
        modifier = 0.3
      }
    },
    prerequisites = {"artillery-shell-range-1", "ll-quantum-science-pack"},
    unit =
    {
      count = 1500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
        {"ll-quantum-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "e-k-d"
  },
}

local infinite_artillery_speed = data.raw.technology["artillery-shell-speed-1"]
infinite_artillery_speed.name = "artillery-shell-speed-3"
infinite_artillery_speed.prerequisites = {"artillery-shell-speed-2", "space-science-pack"}
infinite_artillery_speed.unit.count_formula = "1000+3^(L-3)*1000"
infinite_artillery_speed.upgrade = true
data:extend{
  infinite_artillery_speed,
  {
    type = "technology",
    name = "artillery-shell-speed-1",
    icon_size = 256,
    icons = util.technology_icon_constant_speed("__base__/graphics/technology/artillery-speed.png"),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "artillery-shell",
        icon = "__base__/graphics/icons/artillery-shell.png",
        icon_size = 64,
        modifier = 1
      }
    },
    prerequisites = {"artillery", "ll-space-science-pack"},
    unit =
    {
      count = 1000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "e-k-k"
  },
  {
    type = "technology",
    name = "artillery-shell-speed-2",
    icon_size = 256,
    icons = util.technology_icon_constant_speed("__base__/graphics/technology/artillery-speed.png"),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "artillery-shell",
        icon = "__base__/graphics/icons/artillery-shell.png",
        icon_size = 64,
        modifier = 1
      }
    },
    prerequisites = {"artillery-shell-speed-1", "ll-quantum-science-pack"},
    unit =
    {
      count = 1500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"ll-space-science-pack", 1},
        {"ll-quantum-science-pack", 1},
      },
      time = 60
    },
    upgrade = true,
    order = "e-k-k"
  },
}