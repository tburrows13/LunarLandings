for _, autoplace_control in pairs(data.raw["autoplace-control"]) do
  if autoplace_control.localised_name then
    autoplace_control.localised_name = {"", "[virtual-signal=ll-nauvis] ", autoplace_control.localised_name}
  end
end

data:extend(
{
  {
    type = "autoplace-control",
    name = "ll-moon-rock",
    localised_name = {"", "[virtual-signal=ll-luna] [entity=ll-moon-rock] ", {"entity-name.ll-moon-rock"}},
    richness = true,
    order = "d-a",
    category = "resource"
  },
  {
    type = "autoplace-control",
    name = "ll-ice",
    localised_name = {"", "[virtual-signal=ll-luna] [entity=ll-ice] ", {"entity-name.ll-ice"}},
    richness = true,
    order = "d-b",
    category = "resource"
  },
  {
    type = "autoplace-control",
    name = "ll-rich-moon-rock",
    localised_name = {"", "[virtual-signal=ll-luna] [entity=ll-rich-moon-rock] ", {"entity-name.ll-rich-moon-rock"}},
    richness = true,
    order = "d-c",
    category = "resource"
  },
  {
    type = "autoplace-control",
    name = "ll-astrocrystals",
    localised_name = {"", "[virtual-signal=ll-luna] [entity=ll-astrocrystals] ", {"entity-name.ll-astrocrystals"}},
    richness = true,
    order = "d-d",
    category = "resource",
  },
}
)
