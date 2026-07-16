data:extend({
  {
    type = "ammo",
    name = "extinguisher-ammo",
    icon = "__fire-extinguisher-continued__/graphics/icons/extinguisher-canister.png",
    icon_size = 32,
    ammo_category = "extinguisher",
    custom_tooltip_fields =
    {
      {
        name = {"extinguisher-tooltip.extinguishing-radius"},
        value = {"extinguisher-tooltip.tiles", "1"},
        order = 40
      }
    },
    ammo_type =
    {
      target_type = "position",
      clamp_position = true,
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "stream",
          stream = "handheld-extinguisher-stream",
          source_effects =
          {
            {
              type = "script",
              effect_id = "extinguisher-shot"
            }
          }
        }
      }
    },
    magazine_size = 100,
    subgroup = "ammo",
    order = "e[extinguisher]",
    stack_size = 100
  }
})
