local vanilla_tip_names = {
  "introduction",
  "show-info",
  "e-confirm",
  "clear-cursor",
  "pipette",
  "stack-transfers",
  "entity-transfers",
  "z-dropping",
  "shoot-targeting",
  "bulk-crafting",
  "rotating-assemblers",
  "circuit-network",
  "inserters",
  "burner-inserter-refueling",
  "long-handed-inserters",
  "move-between-labs",
  "insertion-limits",
  "limit-chests",
  "transport-belts",
  "belt-lanes",
  "splitters",
  "splitter-filters",
  "underground-belts",
  "electric-network",
  "steam-power",
  "electric-pole-connections",
  "low-power",
  "connect-switch",
  "copy-entity-settings",
  "copy-paste-trains",
  "copy-paste-filters",
  "copy-paste-requester-chest",
  "copy-paste-spidertron",
  "drag-building",
  "drag-building-poles",
  "pole-dragging-coverage",
  "drag-building-underground-belts",
  "fast-belt-bending",
  "fast-obstacle-traversing",
  "trains",
  "rail-building",
  "train-stops",
  "rail-signals-basic",
  "rail-signals-advanced",
  "gate-over-rail",
  "pump-connection",
  "train-stop-same-name",
  "logistic-network",
  "personal-logistics",
  "construction-robots",
  "passive-provider-chest",
  "storage-chest",
  "requester-chest",
  "active-provider-chest",
  "buffer-chest",
  "ghost-building",
  "ghost-rail-planner",
  "copy-paste",
  "fast-replace",
  "fast-replace-direction",
  "fast-replace-belt-splitter",
  "fast-replace-belt-underground",
}

local vanilla_category_names = {
  "game-interaction",
  "inserters",
  "belts",
  "electric-network",
  "copy-paste",
  "drag-building",
  "trains",
  "logistic-network",
  "ghost-building",
  "fast-replace",
}

if not mods["FreightForwarding"] then
  for _, tip_name in pairs(vanilla_tip_names) do
    local tip = data.raw["tips-and-tricks-item"][tip_name]
    local indent = tip.indent or 0
    indent = indent + 1
    local dependencies = tip.dependencies or {}
    table.insert(dependencies, "ll-vanilla")
    local order = tip.order or ""
    order = "zzz-[vanilla]-" .. order
    tip.indent = indent
    tip.dependencies = dependencies
    tip.order = order
    tip.starting_status = "unlocked"
  end

  for _, category_name in pairs(vanilla_category_names) do
    local category = data.raw["tips-and-tricks-item-category"][category_name]
    local order = category.order or ""
    order = "zzz-[vanilla]-" .. order
    category.order = order
  end

  data:extend({
    {
      type = "tips-and-tricks-item",
      name = "ll-vanilla",
      order = "zzz-[vanilla]",
      is_title = true,
      starting_status = "unlocked",
    }
  })
end

data:extend{
  {
    type = "tips-and-tricks-item-category",
    name = "lunar-landings",
    order = "a-[lunar-landings]",
  },
  {
    type = "tips-and-tricks-item",
    name = "ll-introduction",
    --tag = "[entity=rocket-silo]",
    category = "lunar-landings",
    is_title = true,
    order = "a",
    --trigger = {type = "build-entity", entity = "spidertron", match_type_only = true}
  },
  {
    type = "tips-and-tricks-item",
    name = "ll-nauvis",
    tag = "[virtual-signal=ll-nauvis]",
    category = "lunar-landings",
    indent = 1,
    order = "b",
    --trigger = {type = "build-entity", entity = "spidertron", match_type_only = true},
  },
  {
    type = "tips-and-tricks-item",
    name = "ll-luna",
    tag = "[virtual-signal=ll-luna]",
    category = "lunar-landings",
    indent = 1,
    order = "c",
    --trigger = {type = "build-entity", entity = "spidertron", match_type_only = true},
  },
  {
    type = "tips-and-tricks-item",
    name = "ll-lunar-logistics",
    tag = "[entity=rocket-silo]",
    category = "lunar-landings",
    indent = 1,
    order = "d",
    --trigger = {type = "build-entity", entity = "spidertron", match_type_only = true},
  },
  {
    type = "tips-and-tricks-item",
    name = "ll-oxygen",
    tag = "[fluid=ll-oxygen]",
    category = "lunar-landings",
    indent = 1,
    order = "e",
    --trigger = {type = "build-entity", entity = "spidertron", match_type_only = true},
    simulation = {
      mods = {"LunarLandings"},
      init_update_count = 700,
      init =
      [[
        local function fill_tiles(left_top, right_bottom, tile)
          local tiles = {}
          for i = left_top[1], right_bottom[1] do
            for j = left_top[2], right_bottom[2] do
              table.insert(tiles, {position = {i, j}, name = tile})
            end
          end
          game.surfaces[1].set_tiles(tiles)
        end

        fill_tiles({-13, -10}, {13, 10}, "ll-luna-plain")
        fill_tiles({-2, -1}, {2, 1}, "ll-lunar-foundation")
        fill_tiles({-7, -2}, {-3, 2}, "ll-lunar-foundation")
        fill_tiles({3, -3}, {5, 3}, "ll-lunar-foundation")

        game.surfaces[1].create_entities_from_blueprint_string
        {
          string = "0eNrNmutuozoQgN+F33hlY8ylr3JURQScrHUIIANtc6q8+zGhJGljlxk3K21/tUA/z9UzvrwH23qUnVbNEDy9B6psmz54+uc96NW+Kerp2XDsZPAUqEEegjBoisP0167oBzLooum7Vg9kK+shOIWBair5FjyxU7hKqGtSt69kr4sXUvS9PGxr1ezJoSh/q0bewKLTcxjIZlCDkrNs5z+Om2Y8bKU2o12Y/dA2krwWdW3G6dre/EvbTBIYDGHxLxEGR/Nb+kucJgm/cKILRzU71ZhXpPwt+8HCSm9R4eX7TS+HwWjRT99peWhf5GY07+pBalltJgOYV7ui7mUYzI9nja426VU9OcGMWbbj5BRGaRgc2mp6XwyklsVZoouln22q8BuTFOW/RDW91Ga071RJ7FaJ4VaJf2KVQY/SNr6AqxLfqhIGldKynN/HFnACV0z85e5O4TYSK+7OLihZG+tpVRLZSL0/Gqgh7opS3lPTD+t8Mfr03avUm0631fjx0Oh3+QmD7bjbmQ969Z/89MoiWH7VcdwaNc+4O0kYW0SxIBgFzRQsWpkoGPt2Hrw3erIAY0hgsgiJv6Sw+IqPbHjuK70ASR8j8fEt3gYUvsDYAUyQQOE0QGLDpz4pRPiHzH8yh1gGS6JFFBsi942eCBI9EfXFcxCe+cZS5OgZIl8gdwCv2dmpzhYodE0kS8VeQ3F3XbvWqvbtuJfncJG6NIMWe3mOFVPmzJNiGLWcs/Vr+bJKKXwdzUCOTuAl8UKmDoOmvj5mDmD2GQhpaShI6xwcPA7R+DX/uvHQfUOg6+Lwa7ZN8aLVbtxbhOIL8ayiIarzcqEZSxM+muxGWRNt1ihtKfvehGVgGyqCmlQ4LWqbzPk1HdfcnjrBtirMYzA4wYEFGJzjwAkYnOHA6c2E5XIbYzi/ZWBhGcVJm4PXDddGkj5wQRRT6Bra3clEn1PtmltkNALaEixm4V0pIJXa7cbeOnHRm5FsOHS+MohzYny6Mkg4xfhshXHxyQrj4nMVxkWl6r3LwsDEutaqkptzWV66VttQHhkM08EjgdlD1/0mZSoydmQ0eqnxMFe4Up7Xoss2wKWLkm9FOdTH1T0AcZ0W7qcCwt1lN/48FxTVS9GURsBS6XK0TwaCgburSzBwSP4KZDt98Tyo+xcc73n+UM+XbWdaZVIW21penR357PmIeK3XW2ZOx7paeOysgXYARAJubzmKi+3DIxQ9Q9Kpi26bdAR22cww9IR+igUytKYnMLFVfSO2Y3MkYVDnOSW0JXaCTGyUcRP4drdACY3cykpRQiMXwAkKjtziylHw1A8O2vxMkGmYoSTP8XULFCkp9axbjrk5ZZ68GGKGNMLXQfHQOtjVRitVkm2hf3r0waFl0LGZn/ruV7t4AiqQ4wQmTTwFcvGwZZPfKLgeS1/y1RQdqefis1aW7/nhclTcjkM3WlvPNPfUxnXeRT2bigRinYxBN+Qc0ZRF+MoOOv3MONZvbN1tqnF4LUMmGSoEM3gjy1EmQiZihBIamZUCBUcW0RgFhxfRGGPunPp1WyChc+bXbcHgkV9DBINzv4YIBo/xDVECaYhy4dnAwMROPOmwQEzx7VHy0PZoPjduG9MhLbswP9ssyDNoU5LZ61Cegw8VF1K+eqbYj/VunI7Hi1JVK+eKEfBc8dxEwkquQ1VGGfoANfc+Pz0TXCeoc+g49IzwqZuB7odQ7pldToPGmLs7jNohAp+V2d+dlYwmP7gqwtgfvSpCU5DTCFuEsUK8rpMtgRDdnR48VMEceW+URa7rYMh7ZTPoOZxvxD7dXMENgxcTdLO2GYvTPEqzJKecxqfT/3n3YJk=",
          position = {0,0}
        }
        game.camera_alt_info = true
      ]]
    }
  },
  {
    type = "tips-and-tricks-item",
    name = "ll-steam-condenser",
    tag = "[entity=ll-steam-condenser]",
    category = "lunar-landings",
    indent = 1,
    order = "f",
    --trigger = {type = "build-entity", entity = "spidertron", match_type_only = true},
    simulation = {
      mods = {"LunarLandings"},
      init_update_count = 500,
      init =
      [[
        game.surfaces[1].create_entities_from_blueprint_string
        {
          string = "0eNq9l9uSojAQht8l12AlIRz0Vba2rIitk1oMVAjjuJbvvsEzazIdb8YrJOHrA52/6SNZNQN0RmlLFkei6lb3ZPHrSHq11bIZ79lDB2RBlIUdSYiWu/Ffb0HuUjuYldJATglReg1fZMFOvxMC2iqr4AI6/zks9bBbgXEbnhCthnQvm8Zhu7Z3j7R6NOgwKctneUIO41U5y0+n5AXEo0CMYZzszoEGamtUnYIGsz2kLidgNrIGj3/iChUu9LUy7sHzohh37sEsO9Ouh+tNers59HLrDDH6+CVkNWw2bq1Xf6dLHlfFI+Rh1Vt5xr/6xu++eRj5nfEB0n4bI+P33FGXu4S4CujASPfWr64mZNeuR5YjNSB7SzwWi6nFTnVeY2xizMMp4zgU41RRnDmGmU8x8FV/SL11K6+sapLFp3LhHi6jd3DAtQJzjTEMkaMIjiEEisgwRIYiBIbgKCLHEGjhsQJDoDXHSgSBEyqEgIcxRwhoLjlamtUNUQUILNBBvinRkP7zWBTHSI9CVXqjtFsLqsudVZzP8m3/sgdrld7248Yray/tRQ3A1M7iRfr/F9HcI6E+F9GD8NDPIhAlfhAohiii338o1WU0IeQDdg4eyh0iPM5B06SX2nGfPWvQvVe92fSVT7u9u1bdFXWDXJi+VpjRaD0Tga8VFq1FIQKP9oEHCFk0IQsQRHQUIR/yaELIhyI6ioAcZmV8dwoQqugoQj7M43uTnyBotPrdwqE/qn1iMjIYx0qt1H/CPTQUKH9z9AiUnohuF/wJ9H6+6Ixm4ZQZ2LWf4E+YeG80OsfpxrbzhLd4GggT8gmmv3ypVkyUc15WxZxm1E0W/wCzIoRF",
          position = {0,0}
        }
        game.camera_alt_info = true
      ]]
    }
  },
}
