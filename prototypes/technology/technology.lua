data:extend({
  {
    type = "technology",
    name = "extinguisher",
    icon = "__extinguisher__/graphics/technology/extinguisher.png",
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
    prerequisites = {"military-science-pack", "flamethrower"},
    unit =
    {
      count = 20,
      ingredients =
      {
        {"logistic-science-pack", 1},
        {"automation-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 15
    },
    order = "e-c-b"
  }
})
