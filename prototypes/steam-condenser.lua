data:extend{
  {
    type = "recipe-category",
    name = "ll-steam-condensing"
  },
  {
    type = "recipe",
    name = "ll-condense-steam",
    icon = "__LunarLandings__/graphics/icons/condense-steam.png",
    icon_size = 64,
    enabled = false,
    category = "ll-steam-condensing",
    subgroup = "fluid-recipes",
    energy_required = 0.1,
    ingredients = {
      {type = "fluid", name = "water", amount = 100},
      {type = "fluid", name = "steam", amount = 400, temperature = 500},
    },
    results = {{type = "fluid", name = "water", amount = 450}},
    order = "a[fluid]-c[water]",
    main_product = ""
  },
  {
    type = "assembling-machine",
    name = "ll-steam-condenser",
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.5, result = "ll-steam-condenser" },        
    max_health = 150,
    corpse = "medium-remnants",

    collision_box = {{ -1.3, -1.3 }, { 1.3, 1.3 }},
    selection_box = {{ -1.5, -1.5 }, { 1.5, 1.5 }},
    fluid_boxes =
    {
      {
        production_type = "input",
        --pipe_picture = bery0zas.functions.pipe_pictures(),  -- TODO
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections = {{ flow_direction = "input", direction = defines.direction.north, position = { 1, -1 } }},
      },
      {
        production_type = "input",  -- TODO 2.0 make linked connection?
        --pipe_picture = bery0zas.functions.pipe_pictures(),
        --pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections = {{ flow_direction = "input", direction = defines.direction.north, position = { 0, -0.35 } }},
        hide_connection_info = true,
      },
      {
        production_type = "output",
        --pipe_picture = bery0zas.functions.pipe_pictures(),
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections = {{ flow_direction = "output", direction = defines.direction.north, position = { -1, -1 } }},
      }
    },

    crafting_categories = { "ll-steam-condensing" },
    crafting_speed = 1,
    fixed_recipe = "ll-condense-steam",
    energy_source =
    {
      type = "void",
      --usage_priority = "primary-input",
    },
    energy_usage = "300kW",

    --module_slots = 2,
    --allowed_effects = { "consumption", "speed" },

    icon = "__LunarLandings__/graphics/icons/steam-condenser.png",
    icon_size = 64,

    integration_patch_render_layer = "lower-object-above-shadow",
    match_animation_speed_to_activity = true,
    graphics_set = {
      animation =
      {
        east =
        {
          layers =
          {
            {
              filename = "__LunarLandings__/graphics/steam-condenser/hr-adsorber-east.png",
              priority = "extra-high",
              width = 448,
              height = 448,
              frame_count = 1,
              animation_speed = 1.0,
              line_length = 1,
              shift = util.by_pixel(31, -33),
              scale = 0.5
            },
            {
              filename = "__LunarLandings__/graphics/steam-condenser/hr-adsorber-east-shadow.png",
              priority = "medium",
              width = 448,
              height = 448,
              frame_count = 1,
              animation_speed = 1.0,
              line_length = 1,
              draw_as_shadow = true,
              shift = util.by_pixel(31, -33),
              scale = 0.5
            }
          }
        },
        north =
        {
          layers =
          {
            {
              filename = "__LunarLandings__/graphics/steam-condenser/hr-adsorber-north.png",
              priority = "extra-high",
              width = 448,
              height = 448,
              frame_count = 1,
              animation_speed = 1.0,
              line_length = 1,
              shift = util.by_pixel(32, -35),
              scale = 0.5
            },
            {
              filename = "__LunarLandings__/graphics/steam-condenser/hr-adsorber-north-shadow.png",
              priority = "medium",
              width = 448,
              height = 448,
              frame_count = 1,
              animation_speed = 1.0,
              line_length = 1,
              draw_as_shadow = true,
              shift = util.by_pixel(32, -35),
              scale = 0.5
            }
          }
        },      
        west =
        {
          layers =
          {
            {
              filename = "__LunarLandings__/graphics/steam-condenser/hr-adsorber-west.png",
              priority = "extra-high",
              width = 448,
              height = 448,
              frame_count = 1,
              animation_speed = 1.0,
              line_length = 1,
              shift = util.by_pixel(32, -32),
              scale = 0.5
            },
            {
              filename = "__LunarLandings__/graphics/steam-condenser/hr-adsorber-west-shadow.png",
              priority = "medium",
              width = 448,
              height = 448,
              frame_count = 1,
              animation_speed = 1.0,
              line_length = 1,
              draw_as_shadow = true,
              shift = util.by_pixel(32, -32),
              scale = 0.5
            }
          }
        },
        south =
        {
          layers =
          {
            {
              filename = "__LunarLandings__/graphics/steam-condenser/hr-adsorber-south.png",
              priority = "extra-high",
              width = 448,
              height = 448,
              frame_count = 1,
              animation_speed = 1.0,
              line_length = 1,
              shift = util.by_pixel(32, -34),
              scale = 0.5
            },
            {
              filename = "__LunarLandings__/graphics/steam-condenser/hr-adsorber-south-shadow.png",
              priority = "medium",
              width = 448,
              height = 448,
              frame_count = 1,
              animation_speed = 1.0,
              line_length = 1,
              draw_as_shadow = true,
              shift = util.by_pixel(32, -34),
              scale = 0.5
            }
          }
        }
      },
    },
    radius_visualisation_specification =
    {
      sprite = {
        filename = "__base__/graphics/entity/beacon/beacon-radius-visualization.png",
        priority = "extra-high-no-scale",
        width = 10,
        height = 10
      },
      distance = 5.5,
    },
    
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    working_sound =
    {
      sound = {{ filename = "__base__/sound/electric-furnace.ogg", volume = 0.7 }},
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
      apparent_volume = 1.5,
    },
    created_effect = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          {
            type = "script",
            effect_id = "ll-steam-condenser-created",
          },
        }
      }
    },
  },
  {
    type = "item",
    name = "ll-steam-condenser",
    icon = "__LunarLandings__/graphics/icons/steam-condenser.png",
    icon_size = 64,
    subgroup = "energy",
    order = "f[nuclear-energy]-d[steam-turbine]-a",
    place_result = "ll-steam-condenser",
    stack_size = 10
  },
  {
    type = "recipe",
    name = "ll-steam-condenser",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="steel-plate", amount=20},
      {type="item", name="pipe", amount=40},
      {type="item", name="barrel", amount=20},
      {type="item", name="engine-unit", amount=4},
      {type="item", name="electronic-circuit", amount=10},
    },
    results = {{type="item", name="ll-steam-condenser", amount=1}}
  },
}