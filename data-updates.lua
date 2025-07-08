require "__LunarLandings__.prototypes.se-space-trains-updates"
require "__LunarLandings__.compatibility.aai-industry.data-updates"

local luna_robots = {
  ["ll-ion-logistic-robot"] = true,
  ["ll-ion-construction-robot"] = true,
}

local editor_robots = {
  ["ee-super-logistic-robot"] = true,
  ["ee-super-construction-robot"] = true,
}

for _, robot_type in pairs({"logistic-robot", "construction-robot"}) do
  for _, prototype in pairs(data.raw[robot_type]) do
    if editor_robots[prototype.name] then
      goto continue
    end
    local created_effect = prototype.created_effect or {}
    local effect_id = "ll-robot-created"
    if luna_robots[prototype.name] then
      effect_id = "ll-ion-robot-created"
    end
    table.insert(created_effect, {
        type = "direct",
        action_delivery = {
          type = "instant",
          source_effects = {
            {
              type = "script",
              effect_id = effect_id,
            },
          }
        }
      }
    )
    prototype.created_effect = created_effect
    ::continue::
  end
end