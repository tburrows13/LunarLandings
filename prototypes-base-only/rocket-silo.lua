-- Scale rocket & rocket silo from 9x9 to 7x7
local scale = 7 / 9  -- 0.77778
local scale_offset = x_util.scale_offset
local scale_sprite = x_util.scale_sprite

local NAUVIS_ROCKET_SILO_PARTS_REQUIRED = 20
local LUNA_ROCKET_SILO_PARTS_REQUIRED = 5

local rocket_silo = data.raw["rocket-silo"]["rocket-silo"]
rocket_silo.localised_description = {"entity-description.ll-rocket-silo", tostring(NAUVIS_ROCKET_SILO_PARTS_REQUIRED), tostring(LUNA_ROCKET_SILO_PARTS_REQUIRED)}
rocket_silo.factoriopedia_description = {"entity-description.ll-rocket-silo-rich-text", tostring(NAUVIS_ROCKET_SILO_PARTS_REQUIRED), tostring(LUNA_ROCKET_SILO_PARTS_REQUIRED)}
rocket_silo.factoriopedia_alternative = "rocket-silo"
rocket_silo.crafting_categories = {"rocket-building-nauvis-luna"}
rocket_silo.rocket_parts_required = NAUVIS_ROCKET_SILO_PARTS_REQUIRED
rocket_silo.fixed_recipe = "ll-rocket-part-nauvis"
rocket_silo.to_be_inserted_to_rocket_inventory_size = 20
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

data.raw["rocket-silo"]["rocket-silo"].circuit_connector = circuit_connector_definitions.create_vector
(
  universal_connector_template,
  {
    { variation = 25, main_offset = util.by_pixel(48.5 * scale, 104 * scale), shadow_offset = util.by_pixel(75.5 * scale, 129 * scale), show_shadow = true },
    { variation = 25, main_offset = util.by_pixel(48.5 * scale, 104 * scale), shadow_offset = util.by_pixel(75.5 * scale, 129 * scale), show_shadow = true }, -- unused but RocketSilo derives from AssemblingMachine which requires 4 connectors
    { variation = 25, main_offset = util.by_pixel(48.5 * scale, 104 * scale), shadow_offset = util.by_pixel(75.5 * scale, 129 * scale), show_shadow = true }, -- also unused
    { variation = 25, main_offset = util.by_pixel(48.5 * scale, 104 * scale), shadow_offset = util.by_pixel(75.5 * scale, 129 * scale), show_shadow = true }  -- also unused
  }
)

data.raw["rocket-silo"]["rocket-silo"].circuit_wire_max_distance = default_circuit_wire_max_distance

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
rocket_silo_down.minable.result = "rocket-silo"
rocket_silo_down.placeable_by = {item = "rocket-silo", count = 1}
rocket_silo_down.rocket_parts_required = LUNA_ROCKET_SILO_PARTS_REQUIRED
rocket_silo_down.fixed_recipe = "ll-rocket-part-luna"
rocket_silo_down.hidden = true
--table.insert(rocket_silo_down.flags, "not-in-made-in")
data:extend{rocket_silo_down}

-- Rocket entity
local rocket = data.raw["rocket-silo-rocket"]["rocket-silo-rocket"]
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

data.raw["item"]["rocket-silo"].localised_name = {"entity-name.rocket-silo"}
data.raw["item"]["rocket-silo"].stack_size = 5
data.raw["item"]["rocket-silo"].weight = 0.5 * tons

data.raw.recipe["rocket-silo"].ingredients =
{
  {type="item", name="steel-plate", amount=200},
  {type="item", name="concrete", amount=200},
  {type="item", name="pipe", amount=20},
  {type="item", name="advanced-circuit", amount=100},
  {type="item", name="electric-engine-unit", amount=40}
}

data.raw["cargo-landing-pad"]["cargo-landing-pad"].localised_name = {"entity-name.ll-cargo-landing-pad"}
data.raw["cargo-landing-pad"]["cargo-landing-pad"].localised_description = {"entity-description.ll-cargo-landing-pad"}
data.raw["cargo-landing-pad"]["cargo-landing-pad"].ll_surface_conditions = {nauvis = true, luna = false}
for _, hatch in pairs(data.raw["cargo-landing-pad"]["cargo-landing-pad"].cargo_station_parameters.hatch_definitions) do
  hatch.receiving_cargo_units = {"ll-rocket-part-cargo-pod", "ll-interstellar-cargo-pod"}
end

local rocket_part_cargo_pod = table.deepcopy(data.raw["cargo-pod"]["cargo-pod"])
rocket_part_cargo_pod.name = "ll-rocket-part-cargo-pod"
rocket_part_cargo_pod.order = "c[cargo-pod]-b[rocket-part]"

rocket_part_cargo_pod.inventory_size = 20
data:extend{rocket_part_cargo_pod}

data.raw["cargo-pod"]["cargo-pod"].inventory_size = 25
data.raw["temporary-container"]["cargo-pod-container"].inventory_size = 25

data.raw.item["rocket-part"] = nil
data.raw.recipe["rocket-part"] = nil
