local function init()
  if not script.active_mods["DiscoScience"] then return end
  if not remote.interfaces["DiscoScience"] then return end
  if not remote.interfaces["DiscoScience"]["setIngredientColor"] then return end
  remote.call(
    "DiscoScience",
    "setIngredientColor",
    "ll-space-science-pack",
    { r = 0, g = 0, b = 1 } -- Dark Blue
  )
  remote.call(
    "DiscoScience",
    "setIngredientColor",
    "ll-quantum-science-pack",
    {r = 1, g = 0, b = 1} -- Purple
  )
end

return
{
  init = init
}