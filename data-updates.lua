require "__LunarLandings__.prototypes.se-space-trains-updates"
require "__LunarLandings__.compatibility.aai-industry.data-updates"

local luna_robots = {
  ["ll-ion-robot"] = true,
  ["ll-ion-construction-robot"] = true,
}

for _, robot_type in pairs({"logistic-robot", "construction-robot"}) do
  for _, prototype in pairs(data.raw[robot_type]) do
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
  end
end