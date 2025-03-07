-- Scale rocket & rocket silo from 9x9 to 7x7
local scale = 7 / 9  -- 0.77778
local scale_offset = x_util.scale_offset
local scale_sprite = x_util.scale_sprite

local rocket_silo = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
rocket_silo.name = "ll-rocket-silo-up"
rocket_silo.localised_name = {"entity-name.ll-rocket-silo-up"}
rocket_silo.localised_description = {"entity-description.ll-rocket-silo", tostring(NAUVIS_ROCKET_SILO_PARTS_REQUIRED), tostring(LUNA_ROCKET_SILO_PARTS_REQUIRED)}
rocket_silo.factoriopedia_description = {"entity-description.ll-rocket-silo-rich-text", tostring(NAUVIS_ROCKET_SILO_PARTS_REQUIRED), tostring(LUNA_ROCKET_SILO_PARTS_REQUIRED)}
rocket_silo.factoriopedia_alternative = "ll-rocket-silo-up"
rocket_silo.minable.result = "ll-rocket-silo-up"
rocket_silo.placeable_by = {item = "ll-rocket-silo-up", count = 1}
rocket_silo.rocket_entity = "ll-small-rocket-silo-rocket"
rocket_silo.crafting_categories = {"rocket-building-nauvis-luna"}
rocket_silo.rocket_parts_required = NAUVIS_ROCKET_SILO_PARTS_REQUIRED
rocket_silo.fixed_recipe = "ll-rocket-part-nauvis"
rocket_silo.launch_to_space_platforms = false
rocket_silo.to_be_inserted_to_rocket_inventory_size = 20
rocket_silo.logistic_trash_inventory_size = 0
for i, flag in pairs(rocket_silo.flags) do
  if flag == "draw-logistic-overlay" then
    table.remove(rocket_silo.flags, i)
    break
  end
end
rocket_silo.fluid_boxes = {
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    pipe_connections = {{ flow_direction = "input", direction = defines.direction.north, position = {0, -3} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    pipe_connections = {{ flow_direction = "input", direction = defines.direction.south, position = {0, 3} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    pipe_connections = {{ flow_direction = "input", direction = defines.direction.east, position = {3, 0} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    pipe_connections = {{ flow_direction = "input", direction = defines.direction.west, position = {-3, 0} }},
    secondary_draw_orders = { north = -1 }
  },
}
rocket_silo.fluid_boxes_off_when_no_fluid_recipe = true

-- Reduce size from 9x9 to 7x7
rocket_silo.collision_box = {{-3.20, -3.20}, {3.20, 3.20}}
rocket_silo.selection_box = {{-3.5, -3.5}, {3.5, 3.5}}
scale_offset(rocket_silo.door_back_open_offset, scale)
scale_offset(rocket_silo.door_front_open_offset, scale)

scale_sprite(rocket_silo.shadow_sprite, scale)
scale_sprite(rocket_silo.hole_sprite, scale)
scale_sprite(rocket_silo.hole_light_sprite, scale)
scale_sprite(rocket_silo.rocket_shadow_overlay_sprite, scale)
scale_sprite(rocket_silo.rocket_glow_overlay_sprite, scale)
scale_sprite(rocket_silo.door_back_sprite, scale)
scale_sprite(rocket_silo.door_front_sprite, scale)
scale_sprite(rocket_silo.base_day_sprite, scale)
for _, sprite in pairs(rocket_silo.red_lights_back_sprites.layers) do
  scale_sprite(sprite, scale)
end
for _, sprite in pairs(rocket_silo.red_lights_front_sprites.layers) do
  scale_sprite(sprite, scale)
end
scale_sprite(rocket_silo.satellite_animation, scale)
scale_sprite(rocket_silo.arm_01_back_animation, scale)
scale_sprite(rocket_silo.arm_02_right_animation, scale)
scale_sprite(rocket_silo.arm_03_front_animation, scale)
scale_sprite(rocket_silo.base_front_sprite, scale)

local rocket_silo_down = table.deepcopy(rocket_silo)
rocket_silo_down.name = "ll-rocket-silo-down"
rocket_silo_down.localised_name = {"entity-name.ll-rocket-silo-down"}
rocket_silo_down.rocket_parts_required = 5
rocket_silo_down.fixed_recipe = "ll-rocket-part-luna"
table.insert(rocket_silo_down.flags, "not-in-made-in")
data:extend{rocket_silo_down}

-- Rocket entity
local rocket = table.deepcopy(data.raw["rocket-silo-rocket"]["rocket-silo-rocket"])
rocket.name = "ll-small-rocket-silo-rocket"
rocket.inventory_size = 20

scale_sprite(rocket.rocket_sprite.layers[1], scale)
scale_sprite(rocket.rocket_sprite.layers[2], scale)
scale_sprite(rocket.rocket_shadow_sprite, scale)
scale_sprite(rocket.rocket_glare_overlay_sprite, scale)
scale_sprite(rocket.rocket_smoke_top1_animation, scale)
scale_sprite(rocket.rocket_smoke_top2_animation, scale)
scale_sprite(rocket.rocket_smoke_top3_animation, scale)
scale_sprite(rocket.rocket_smoke_bottom1_animation, scale)
scale_sprite(rocket.rocket_smoke_bottom2_animation, scale)
scale_sprite(rocket.rocket_flame_animation, scale)

scale_offset(rocket.rocket_initial_offset, scale)
scale_offset(rocket.rocket_rise_offset, scale)
scale_offset(rocket.rocket_launch_offset, scale)
scale_offset(rocket.cargo_attachment_offset, scale)

local rocket_silo_item = table.deepcopy(data.raw["item"]["rocket-silo"])
rocket_silo_item.name = "ll-rocket-silo-up"
rocket_silo_item.place_result = "ll-rocket-silo-up"
rocket_silo_item.stack_size = 5

data:extend{
  rocket,
  rocket_silo,
  rocket_silo_down,
  rocket_silo_item,
  {
    type = "recipe",
    name = "ll-rocket-silo-up",
    enabled = false,
    ingredients =
    {
      {type = "item", name = "steel-plate", amount = 1000},
      {type = "item", name = "concrete", amount = 1000},
      {type = "item", name = "pipe", amount = 100},
      {type = "item", name = "processing-unit", amount = 200},
      {type = "item", name = "electric-engine-unit", amount = 200}
    },
    energy_required = 30,
    results = {{type="item", name="ll-rocket-silo-up", amount=1}},
    requester_paste_multiplier = 1
  },
}