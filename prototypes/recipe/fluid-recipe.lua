data:extend(
{
  {
    type = "recipe",
    name = "extinguisher-ammo",
    categories = {"chemistry"},
    auto_recycle = false,
    enabled = false,
    energy_required = 3,
    ingredients =
    {
      {type = "item", name = "iron-plate", amount = 5},
      {type = "item", name = "copper-plate", amount = 1},
      {type = "item", name = "stone", amount = 5},
      {type = "fluid", name = "sulfuric-acid", amount = 1},
      {type = "fluid", name = "water", amount = 5}
    },
    results = {{type = "item", name = "extinguisher-ammo", amount = 1}}
  }
})
