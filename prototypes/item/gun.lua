data:extend(
{
  {
    type = "gun",
    name = "extinguisher",
    icon = "__fire-extinguisher-continued__/graphics/icons/extinguisher.png",
    icon_size = 32,
    subgroup = "gun",
    order = "e[extinguisher]",
    custom_tooltip_fields =
    {
      {
        name = {"extinguisher-tooltip.maximum-range"},
        value = {"extinguisher-tooltip.tiles", "15"},
        order = 40
      }
    },
    attack_parameters =
    {
      type = "stream",
      ammo_category = "extinguisher",
      cooldown = 1,
      movement_slow_down_factor = 0.6,
      gun_barrel_length = 0.8,
      gun_center_shift = { 0, -1 },
      range = 15,
      min_range = 1,
      cyclic_sound =
      {
        begin_sound =
        {
          {
            filename = "__fire-extinguisher-continued__/sound/extinguisher-start.ogg",
            volume = 0.85
          }
        },
        middle_sound =
        {
          {
            filename = "__fire-extinguisher-continued__/sound/extinguisher-loop.ogg",
            volume = 0.85
          }
        },
        end_sound =
        {
          {
            filename = "__fire-extinguisher-continued__/sound/extinguisher-end.ogg",
            volume = 0.85
          }
        }
      }
    },
    stack_size = 5
  }
})
