
local vanilla_category_names = {
  "game-interaction",
  "inserters",
  "electric-network",
  "copy-paste",
  "drag-building",
  "trains",
  "logistic-network",
  "ghost-building",
  "fast-replace",

  "quality",

  "space-age",
  "space-platform",
  "spoilables",
}
local is_vanilla_category = {}
for _, name in pairs(vanilla_category_names) do
  is_vanilla_category[name] = true
end

if not mods["FreightForwarding"] then
  for _, category_name in pairs(vanilla_category_names) do
    local category = data.raw["tips-and-tricks-item-category"][category_name]
    if category then
      local order = category.order or ""
      order = "zzz-[vanilla]-" .. order
      category.order = order
    end
  end

  for _, tip in pairs(data.raw["tips-and-tricks-item"]) do
    if tip.category and is_vanilla_category[tip.category] then
      tip.indent = (tip.indent or 0) + 1
      tip.starting_status = "unlocked"
    end
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
    order = "---a-[lunar-landings]",
  },
  {
    type = "tips-and-tricks-item",
    name = "ll-introduction",
    --tag = "[entity=rocket-silo]",
    category = "lunar-landings",
    is_title = true,
    order = "a",
    starting_status = "suggested",
  },
  {
    type = "tips-and-tricks-item",
    name = "ll-nauvis",
    tag = "[virtual-signal=ll-nauvis]",
    category = "lunar-landings",
    indent = 1,
    order = "b",
    starting_status = "completed",
  },
  {
    type = "tips-and-tricks-item",
    name = "ll-luna",
    tag = "[virtual-signal=ll-luna]",
    category = "lunar-landings",
    indent = 1,
    order = "c",
    starting_status = "unlocked",
    trigger =
    {
      type = "research",
      technology = "ll-luna-exploration"
    },
  },
  {
    type = "tips-and-tricks-item",
    name = "ll-lunar-logistics",
    tag = "[entity=rocket-silo]",
    category = "lunar-landings",
    indent = 1,
    order = "d",
    starting_status = "unlocked",
    trigger =
    {
      type = "change-surface",
      surface = "luna"
    },
  },
  {
    type = "tips-and-tricks-item",
    name = "ll-oxygen",
    tag = "[fluid=ll-oxygen]",
    category = "lunar-landings",
    indent = 1,
    order = "e",
    starting_status = "unlocked",
    trigger =
    {
      type = "change-surface",
      surface = "luna"
    },
    simulation = {
      mods = {"LunarLandings"},
      init_update_count = 700,
      init =
      [[
        local function fill_tiles(left_top, right_bottom, tile)
          local tiles = {}
          for i = left_top[1], right_bottom[1] do
            for j = left_top[2], right_bottom[2] do
              table.insert(tiles, {position = {i, j-1}, name = tile})
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
          string = "0eNrNmt1yozoMgN+Fa7xjG8xPX+VMJ0PAyXqWAMdA25xO3/0YsglNYwfJzc7sXnUD+SzJkiUreg+29Sg7rZoheHoPVNk2ffD0z3vQq31T1NNnTXGQwVOwK/qBDLpo+q7VA9nKegg+wkA1lXwLnthHaPlOXZO6fSV7XbyQou/lYVurZk8ORflTNfLT1/nHcxjIZlCDkqf15/8cN8142Ept+OGZ2Q9tI8lrUddBGHRtb77SNtOaBkNY/EOEwXH6K/khPiahvoD4BaSanWrMI1L+lP1ggaVXrPDyhU0vh8Ho0U8vanloX+RmNM/qQWpZbdQgD+bRrqh7GQanj086LVbpVT2Z2ixatuNkekZpGBzaanpeDKSWxSzSxbrPNl0iuC7ib9clhusSf0uXQY/SJoAAeRjjaw6WXDjbsf5FVNNLbQS461/CjkrDe8F3DxjPhqmUluXphdiCz5D4xI3PLPgcbAixZghGwaz4irUqJGNIIwi3ERi3LcCRC8RXC9iIS9jL2qytVUlkI/X+aOxijLIrSnnLTc9e+8Um04uvUm863VbjWRG6/AuNxXc780Kv/pNXj2yiLVHcj9t+KGbebRCxizA2iPD2ywi05Yk3n4P4qfeOR44dz7yJ3EHMfXyIRGc5/6QTcXqbCjrV2eShX3bGmgmWTNW+Hfdy9kepS7NqsZdzZWESg/mkGEYtT+73NXlZCwkG8/WLyWwM7u2KDOKKPPLmUxA/9nZM5ijPhDeROohLuK96kUuoFI5wSZGBM9hlD3IHKr82ESQZ5pDdjJbA68ZDd0/NHEBb4mOKNa12495iuuiMzGYRDXKy8FPQjKWJPU12o6yJNjeUtpR9b2I6OL+0+XcsarPi9HKrD+biYZOCQ40lnLay5vVoCa01H02dZFtVFsVgcIIDCzA4x4ETMDjDgdNPmcC1b1PQojYuA0vLKE7cHHyHWa4R+QOvMPESwCs37zt1bXJzVHyKyiUMyWjkxcVizMKbZEwqtduNvfX0op9FsvHwsZ1C9jH2CO0U5HuxR2wDyR7BDSR7RDeQjAvv270LAxMfWqtKbkz9Vf46l5e2tXyiHqiGT9inD+3CVLKr5SArMhrd1Hg4Zc1Szh2Mc1fmUtbKt6Ic6uNqS0bQq7KHDK05TwysuherjkurWGL/9jgi0Z26IL6uC4rqpWhKo2qpdDlijyCBLLjzaylWSh4RQYu8xasF5EQSyDqbUafcVhcWwpcParKIxCNCxEMjpGw7c8UjZbGt5RIT3KdTKVJ8MwrUmBDZ2jVDfObZCDmY4GgMJNT3/uUCMvBtJUJZK8HenTkOj706R2uGiH3l5aAYToTHaQ1qaCXYhhlzWtouObZhRpH8DOqCbsFtp3KS4+RGip2Cm94RajtTBuUKlDlSDuXGOHmRkZgizYyMywSJF54VBxCPjM0MiU/xFQ0HOUuGB8O8MPctZRw5NaO+QJB3Z8yjNooeWht1tdFLlWRb6G/+iJtxD2X4Q5U5/ZzRNkaf5YbwnXIvi8A1laP3m8VggqMBnfl3xR3AL8eGKROkPpULq+UIuz05wmA4zrezdhy6cbDdvLLUt55ioJMqy+A9eodNcjDBsdE5xVqVQYyqGodNc+SP10iT5sgKmyPxyLwukHhkXo+ReOFZlQDxiWdVAsSnnlUJEJ95ViVAfI4vHiikeJiTnl+yh0nOKPNdgLpGY3xyLv27cy6jEXgG4Hws0NUJgH6sd+M06VCUqlqZAuDAKQBGY/S0AvWeVZgJrmmF08Y5pBSYwRxmZyTIGUzXNAtNvzF8wv/o/BLNQHYi7LcsVobXbM1v00c3P3E8Ur1Pc3SgIcd5B5+Nrxqfmw7by6hwGLyYM2D+hkh4Hue5EFwkETeu8z9Smojb",
          position = {0,-1}
        }
        game.simulation.camera_alt_info = true
        game.forces.player.research_all_technologies()
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
    starting_status = "unlocked",
    trigger =
    {
      type = "change-surface",
      surface = "luna"
    },
    simulation = {
      mods = {"LunarLandings"},
      init_update_count = 500,
      init =
      [[
        game.surfaces[1].create_entities_from_blueprint_string
        {
          string = "0eNq9l8GSoyAQht+Fs04Bool5la2tFDGdDLWKLuJksinffYmJ0ezINLnsnDJCf91/0zRwIbuyg8YobcnmQlRR65ZsflxIq45altdvWlZANqS1IKvYdmanNJA+Ikrv4ZNsWP8zIqCtsgpupsM/563uqh0YNyGaELWG+CTLkkSkqVtnUuurC4eJWfKWRuR8/9X30RcQDwLhnOTBgRIKa1QRgwZzPMcuC2AOsoCF+Pgdyp30vTLOcBhcX2eewGwbU++7+0c6fuxaeXSOGJ3+IrLrDgc31qo/z0MLoYpJcrdrrRzwX2Kjj9AWEOkD8Q7SfiuR8TF1mctcRCxUDRjp1vweaESqen9FOVAJsrVkwWH27LBRzaIvNve1gFmFYSiCWQdhcoSSB1HWCIXRIMwKw7BnDHwW71If3dBXVjZfz1nZiiXutME8kQkssgQjJBhBYASOEVKMgFUeyzACVnRshRBQwBoBoBpyBIAtBKcIAFsHzhAAVkwcLcdsJAgPYSpHpQ9KuzFvH3nI4cNWGedvW7BW6WM7OwlP0t72GpjCebx1+H+7ZbrQK5dCROt9apTcoxIveIoh0IrPMQJW8VNz9BGwkp/6oo+QBxeM72ZAgwmeGJL5bWd+YfqmFfqCmeq/LOMbzV3P9qDbpVZPnwvYdfqrgsF2tLpByDi4/d3J0nl0k3RtKnfbW4oiCRUkMD0iuK1SDyEN7Yo+QHBnZx7AKhTgiyC0sfsCyAPtPf4FDRXgWUXBQgGeHSJ4oAJfAEmgvc+/CD4URiXivx4JIp2/c4xjxVbqX/4TOPUIzV58eHnOYbEKTZiYgV7PF32jiT9lBqr6A5YTtn7tYTjodI9W5Xw5m+kBHJEPMO1gkWY8F3mepjzNEs76/i8Z6NSv",
          position = {0,0}
        }
        game.simulation.camera_alt_info = true
      ]]
    }
  },
}
