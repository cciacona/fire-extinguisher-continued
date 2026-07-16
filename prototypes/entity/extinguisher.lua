local function make_color(r_,g_,b_,a_)
  return { r = r_ * a_, g = g_ * a_, b = b_ * a_, a = a_ }
end

data:extend({
  {
    type = "trivial-smoke",
    name = "extinguisher-smoke",
    hidden = true,
    duration = 300,
    fade_in_duration = 0,
    fade_away_duration = 60,
    spread_duration = 600,
    start_scale = 1,
    end_scale = 2,
    color = make_color(1, 1, 1, 0.1),
    cyclic = true,
    affected_by_wind = true,
    animation =
    {
      width = 152,
      height = 120,
      line_length = 5,
      frame_count = 60,
      shift = {-0.53125, -0.4375},
      priority = "high",
      flags = {"smoke"},
      animation_speed = 0.25,
      filename = "__fire-extinguisher-continued__/graphics/entity/smoke/smoke.png"
    }
  }
})

data:extend({
  {
    type = "stream",
    name = "handheld-extinguisher-stream",
    flags = {"not-on-map"},
    hidden = true,

    smoke_sources =
    {
      {
        name = "extinguisher-smoke",
        frequency = 0.10,
        position = {0.0, 0},
        starting_frame_deviation = 60
      }
    },

    particle_buffer_size = 65,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 1,
    particle_vertical_acceleration = 0.005 * 0.6,
    particle_horizontal_speed = 0.25,
    particle_horizontal_speed_deviation = 0.0035,
    particle_start_alpha = 1,
    particle_end_alpha = 0.8,
    particle_start_scale = 0.1,
    particle_loop_frame_count = 3,
    particle_fade_out_threshold = 0.9,
    particle_loop_exit_threshold = 0.25,
    action =
    {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "script",
              effect_id = "extinguisher-impact"
            }
          }
        }
      }
    },

    spine_animation =
    {
      filename = "__fire-extinguisher-continued__/graphics/entity/extinguisher-stream/extinguisher-stream-spine.png",
      blend_mode = "additive-soft",
      --tint = {r=1, g=1, b=1, a=0.5},
      line_length = 4,
      width = 32,
      height = 18,
      frame_count = 32,
      animation_speed = 1,
      scale = 0.60,
      shift = {0, 0},
    },

    particle =
    {
      filename = "__fire-extinguisher-continued__/graphics/entity/extinguisher-stream/extinguisher-fumes.png",
      priority = "extra-high",
      width = 64,
      height = 64,
      frame_count = 32,
      line_length = 8,
      scale = 1.5,
    },
  }
})
