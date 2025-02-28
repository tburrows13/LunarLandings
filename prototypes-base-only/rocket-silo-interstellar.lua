local INTERSTELLAR_ROCKET_PARTS_REQUIRED = 50

local rocket_silo_interstellar = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
rocket_silo_interstellar.name = "ll-rocket-silo-interstellar"
rocket_silo_interstellar.icon = "__space-exploration-graphics__/graphics/icons/probe-rocket-silo.png"
rocket_silo_interstellar.localised_name = {"entity-name.ll-rocket-silo-interstellar"}
rocket_silo_interstellar.localised_description = {"entity-description.ll-rocket-silo-interstellar", tostring(INTERSTELLAR_ROCKET_PARTS_REQUIRED)}
rocket_silo_interstellar.factoriopedia_description = nil
rocket_silo_interstellar.factoriopedia_alternative = nil
rocket_silo_interstellar.minable.result = "ll-rocket-silo-interstellar"
rocket_silo_interstellar.crafting_categories = {"rocket-building-interstellar"}
rocket_silo_interstellar.rocket_parts_required = INTERSTELLAR_ROCKET_PARTS_REQUIRED
rocket_silo_interstellar.fixed_recipe = "ll-rocket-part-interstellar"
rocket_silo_interstellar.rocket_entity = "ll-interstellar-rocket"
rocket_silo_interstellar.ll_surface_conditions = {nauvis = false, luna = true}

rocket_silo_interstellar.base_day_sprite = {layers = {
  {
    filename = "__base__/graphics/entity/rocket-silo/06-rocket-silo.png",
    width = 608,
    height = 596,
    shift = util.by_pixel(3, -1),
    scale = 0.5
  },
  {
    filename = "__space-exploration-graphics-5__/graphics/entity/probe/06-rocket-silo-mask.png",
    width = 608,
    height = 596,
    shift = util.by_pixel(3, -1),
    tint = {r=0.9,b=0.3,g=0.3},
    scale = 0.5
  },
}}
rocket_silo_interstellar.base_front_sprite = {
  layers = {
    {
      filename = "__base__/graphics/entity/rocket-silo/14-rocket-silo-front.png",
      width = 580,
      height = 262,
      shift = util.by_pixel(-1, 78),
      scale = 0.5
    },
    {
      filename = "__space-exploration-graphics-5__/graphics/entity/probe/14-rocket-silo-front-mask.png",
      width = 580,
      height = 262,
      shift = util.by_pixel(-1, 78),
      tint = {r=0.9,b=0.3,g=0.3},
      scale = 0.5
    },
  }
}
rocket_silo_interstellar.circuit_connector = circuit_connector_definitions["rocket-silo"]
rocket_silo_interstellar.circuit_wire_max_distance = default_circuit_wire_max_distance

local rocket_interstellar = table.deepcopy(data.raw["rocket-silo-rocket"]["rocket-silo-rocket"])
rocket_interstellar.name = "ll-interstellar-rocket"
rocket_interstellar.cargo_pod_entity = "ll-interstellar-cargo-pod"
rocket_interstellar.inventory_size = 1
rocket_interstellar.rocket_sprite = util.add_shift_offset(util.by_pixel(0, 32*3.5), --util.mul_shift(rocket_rise_offset, -1),
{
  filename = "__space-exploration-graphics-5__/graphics/entity/probe/probe-rocket.png",
  width = 310,
  height = 596,
  shift = util.by_pixel(-5, -27),
  scale = 0.5
})

local cargo_pod_interstellar = table.deepcopy(data.raw["cargo-pod"]["cargo-pod"])
cargo_pod_interstellar.name = "ll-interstellar-cargo-pod"
cargo_pod_interstellar.order = "c[cargo-pod]-c[interstellar]"


data:extend{
  rocket_silo_interstellar,
  rocket_interstellar,
  cargo_pod_interstellar,
  {
    type = "item",
    name = "ll-rocket-silo-interstellar",
    icon = "__space-exploration-graphics__/graphics/icons/probe-rocket-silo.png",
    icon_size = 64,
    subgroup = "space-related",
    order = "x[interstellar-rocket-silo]",
    place_result = "ll-rocket-silo-interstellar",
    stack_size = 1
  },
  {
    type = "recipe",
    name = "ll-rocket-silo-interstellar",
    enabled = false,
    ingredients =
    {
      {type="item", name="steel-plate", amount=1000},
      {type="item", name="ll-lunar-foundation", amount=500},
      {type="item", name="pipe", amount=100},
      {type="item", name="ll-quantum-processor", amount=200},
      {type="item", name="electric-engine-unit", amount=200}
    },
    energy_required = 30,
    results = {{type="item", name="ll-rocket-silo-interstellar", amount=1}},
    requester_paste_multiplier = 1
  },
  {
    type = "item",
    name = "ll-rocket-part-interstellar",
    localised_name = {"item-name.ll-rocket-part-interstellar"},
    icon = "__base__/graphics/icons/rocket-part.png",
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "o[rocket-part]-d",
    hidden = true,
    stack_size = 5,
    weight = (1000/50)*kg
  },
  {
    type = "recipe",
    name = "ll-rocket-part-interstellar",
    energy_required = 3,
    enabled = false,
    hide_from_player_crafting = true,
    category = "rocket-building-interstellar",
    ingredients =
    {
      {type="item", name="ll-heat-shielding", amount=10},
      {type="item", name="low-density-structure", amount=10},
      {type="item", name="rocket-control-unit", amount=10},
      {type="item", name="ll-quantum-processor", amount=1},
      {type="item", name="nuclear-fuel", amount=1},
    },
    results = {{type="item", name="ll-rocket-part-interstellar", amount=1}}
  },
  {
    type = "recipe-category",
    name = "rocket-building-interstellar"
  },
}