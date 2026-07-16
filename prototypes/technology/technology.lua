data:extend({
  {
    type = "technology",
    name = "extinguisher",
    icon = "__fire-extinguisher-continued__/graphics/technology/extinguisher.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "extinguisher"
      },
      {
        type = "unlock-recipe",
        recipe = "extinguisher-ammo"
      }
    },
    prerequisites = {"military-science-pack", "flamethrower", "sulfur-processing"},
    unit =
    {
      count = 20,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 15
    },
    order = "e-c-b"
  }
})
