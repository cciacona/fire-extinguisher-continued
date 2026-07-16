local SHOT_EFFECT_ID = "extinguisher-shot"
local IMPACT_EFFECT_ID = "extinguisher-impact"
local FIRE_STICKER_NAME = "fire-sticker"
local BASE_EFFECT_RADIUS = 1
local RADIUS_PER_QUALITY_LEVEL = 0.15
local SHOT_RECORD_LIFETIME = 600

local function get_shooter(event)
  local shooter = event.cause_entity

  if shooter and shooter.valid and shooter.type == "character" then
    return shooter
  end

  shooter = event.source_entity

  if shooter and shooter.valid and shooter.type == "character" then
    return shooter
  end
end

local function get_ammo_quality(shooter)
  if not shooter then
    return nil
  end

  local ammo_inventory = shooter.get_inventory(defines.inventory.character_ammo)
  local gun_index = shooter.selected_gun_index
  local ammo_stack = ammo_inventory and gun_index and ammo_inventory[gun_index]

  if ammo_stack and ammo_stack.valid_for_read and ammo_stack.name == "extinguisher-ammo" then
    return ammo_stack.quality.name
  end
end

local function remove_expired_shots(queue, tick)
  local first_valid_index = 1

  while queue[first_valid_index] and tick - queue[first_valid_index].tick > SHOT_RECORD_LIFETIME do
    first_valid_index = first_valid_index + 1
  end

  for _ = 2, first_valid_index do
    table.remove(queue, 1)
  end
end

local function record_shot(event)
  local shooter = get_shooter(event)
  local shooter_id = shooter and shooter.unit_number

  if not shooter_id then
    return
  end

  local shooting_state = shooter.shooting_state
  local target_position = shooting_state and shooting_state.position

  if not target_position then
    return
  end

  storage.extinguisher_shots = storage.extinguisher_shots or {}
  storage.extinguisher_last_ammo_quality = storage.extinguisher_last_ammo_quality or {}

  local quality_name = get_ammo_quality(shooter)
  if quality_name then
    storage.extinguisher_last_ammo_quality[shooter_id] = quality_name
  else
    quality_name = storage.extinguisher_last_ammo_quality[shooter_id] or event.quality or "normal"
  end

  local queue = storage.extinguisher_shots[shooter_id] or {}
  storage.extinguisher_shots[shooter_id] = queue
  remove_expired_shots(queue, event.tick)

  queue[#queue + 1] = {
    tick = event.tick,
    target_position = {x = target_position.x, y = target_position.y},
    quality_name = quality_name
  }
end

local function get_shot_quality(event)
  local shooter = get_shooter(event)
  local shooter_id = shooter and shooter.unit_number
  local queues = storage.extinguisher_shots
  local queue = shooter_id and queues and queues[shooter_id]

  if queue and #queue > 0 then
    remove_expired_shots(queue, event.tick)

    if #queue == 0 then
      return get_ammo_quality(shooter) or event.quality or "normal"
    end

    local impact_position = event.target_position or event.source_position
    local best_index = 1
    local best_distance = math.huge

    if impact_position then
      for index, shot in ipairs(queue) do
        local dx = shot.target_position.x - impact_position.x
        local dy = shot.target_position.y - impact_position.y
        local distance = dx * dx + dy * dy

        if distance < best_distance then
          best_index = index
          best_distance = distance
        end
      end
    end

    local shot = table.remove(queue, best_index)
    return shot.quality_name
  end

  return get_ammo_quality(shooter) or event.quality or "normal"
end

local function get_effect_radius(quality_name)
  local quality = prototypes.quality[quality_name or "normal"]
  local quality_level = quality and quality.level or 0

  return BASE_EFFECT_RADIUS * (1 + RADIUS_PER_QUALITY_LEVEL * quality_level)
end

local function remove_fire_stickers(entity)
  if not entity or not entity.valid then
    return
  end

  for _, sticker in pairs(entity.stickers or {}) do
    if sticker.valid and sticker.name == FIRE_STICKER_NAME then
      sticker.destroy()
    end
  end
end

local function extinguish_fire(event)
  if event.effect_id == SHOT_EFFECT_ID then
    record_shot(event)
    return
  end

  if event.effect_id ~= IMPACT_EFFECT_ID then
    return
  end

  local position = event.target_position or event.source_position
  local surface = game.get_surface(event.surface_index)

  if not position or not surface then
    return
  end

  local radius = get_effect_radius(get_shot_quality(event))
  local search_filter = {position = position, radius = radius}

  for _, fire in pairs(surface.find_entities_filtered{
    position = position,
    radius = radius,
    type = "fire"
  }) do
    if fire.valid then
      fire.destroy()
    end
  end

  -- The entity hit by the stream can be larger than the search radius, so
  -- always inspect it directly as well as nearby entity centres.
  remove_fire_stickers(event.target_entity)

  for _, entity in pairs(surface.find_entities_filtered(search_filter)) do
    remove_fire_stickers(entity)
  end
end

script.on_event(defines.events.on_script_trigger_effect, extinguish_fire)
