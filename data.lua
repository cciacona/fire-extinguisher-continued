require("prototypes.categories.ammo-category")
require("prototypes.entity.extinguisher")
require("prototypes.item.gun")
require("prototypes.item.ammo")
require("prototypes.recipe.recipe")
require("prototypes.recipe.fluid-recipe")
require("prototypes.technology.technology")

if mods["quality"] then
  local gun_tooltip = data.raw.gun["extinguisher"].custom_tooltip_fields[1]
  gun_tooltip.quality_values =
  {
    uncommon = {"extinguisher-tooltip.tiles", "16.5"},
    rare = {"extinguisher-tooltip.tiles", "18"},
    epic = {"extinguisher-tooltip.tiles", "19.5"},
    legendary = {"extinguisher-tooltip.tiles", "22.5"}
  }

  local ammo_tooltip = data.raw.ammo["extinguisher-ammo"].custom_tooltip_fields[1]
  ammo_tooltip.quality_values =
  {
    uncommon = {"extinguisher-tooltip.tiles", "1.15"},
    rare = {"extinguisher-tooltip.tiles", "1.3"},
    epic = {"extinguisher-tooltip.tiles", "1.45"},
    legendary = {"extinguisher-tooltip.tiles", "1.75"}
  }
end
