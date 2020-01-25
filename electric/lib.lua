local abs = math.abs
local floor = math.floor
local max = math.max
local min = math.min
local sort = table.sort

local vehicle_types =
{
  ["locomotive"] = true,
  ["cargo-wagon"] = true,
  ["car"] = true,
}
local train_types =
{
  ["locomotive"] = true,
  ["cargo-wagon"] = true,
}
local default_masses =
{
  ["locomotive"] = LOCOMOTIVE_MASS,
  ["cargo-wagon"] = CARGO_WAGON_MASS,
  ["car"] = CAR_MASS,
}

-- Local function prototypes
local cache_equipment
local cars_tick
local charge_tick
local fuel_tick
local on_entity_removed
local read_equipment
local recover_energy
local update_equipment

-- Table utils
-------------------------------------------------------------------------------
-- These utilities assume the table is an array and each value is unique

local function insert_unique_f(tbl, x, f)
  for k, v in pairs(tbl) do
    if(f(v)) then
      return false
    end
  end
  tbl[#tbl + 1] = x
  return true
end

local function erase_f(tbl, f)
  for k, v in pairs(tbl) do
    if(f(v)) then
      tbl[k] = nil
      return k
    end
  end
  return nil
end

-- Local caches
-------------------------------------------------------------------------------

-- Dictionary of only those vehicles that have a transformer
-- [unit-number] = transformer index
local transformer_for_unit = { }

-- Remember entities which were invalid in on_load to remove in the first on_tick
local invalid_entities = { }

function rebuild_caches()
  equipment_cache = { }
  transformer_for_unit = { }
  
  for unit, entity in pairs(global.vehicles) do
   if(entity.valid) then
      local grid = entity.grid
      if(grid and grid.valid) then
        cache_equipment(unit, read_equipment(unit, grid))
      else
        invalid_entities[#invalid_entities + 1] = unit
      end
    else
      invalid_entities[#invalid_entities + 1] = unit
    end
  end
end

function validate_prototypes()
  -- Stop doing anything involving a no longer present prototypes
  local equipment = game.equipment_prototypes
  local entities = game.entity_prototypes
  for tbl, exists in pairs{[global.transformers] = equipment} do
    for name in pairs(tbl) do
      if(not exists[name]) then
        tbl[name] = nil
      end
    end
  end
end

function validate_entities()
  -- If any units were deleted stop processing them
  for unit, entity in pairs(global.vehicles) do
    if(not entity.valid or not entity.grid) then
      global.vehicles[unit] = nil
    else
     -- In case equipment was deleted
      update_equipment(unit, entity.grid)
    end
  end
end

-- Equipment handling
-------------------------------------------------------------------------------

read_equipment = function(unit, grid)
  local equipment = grid.equipment
  local known_transformers = global.transformers
  local transformers = { }
  for i = 1, #equipment do
    local item = equipment[i]
    if(known_transformers[item.name] and item.prototype.energy_source) then
      transformers[#transformers + 1] = i
    end
  end
  sort(transformers, function(a, b) return equipment[a].prototype.energy_source.input_flow_limit >
                                           equipment[b].prototype.energy_source.input_flow_limit end)
  return transformers
end

cache_equipment = function(unit, transformers)
  transformer_for_unit[unit] = transformers[1]
end

function update_equipment(unit, grid)
  local transformers = read_equipment(unit, grid)
  
  local entity = global.vehicles[unit]
  cache_equipment(unit, transformers)
end

-- on_tick actions
-------------------------------------------------------------------------------

fuel_tick = function()
  local vehicles = global.vehicles
  for unit, equipment in pairs(transformer_for_unit) do
    local entity = vehicles[unit]
    local transformer = entity.grid.equipment[equipment]
    local available_energy = transformer.energy
    local current_energy = entity.energy
    entity.energy = current_energy + available_energy
    -- The burner energy buffer is kinda weird so we have to check how much energy we actually inserted
    local used = entity.energy - current_energy
    transformer.energy = available_energy - used
  end
end

-- Entity management
-------------------------------------------------------------------------------

on_entity_removed = function(entity)
  if(vehicle_types[entity.type]) then
    local unit = entity.unit_number
    global.vehicles[unit] = nil
    transformer_for_unit[unit] = nil
  end
end

-- Event entry points
-------------------------------------------------------------------------------

function on_built_entity(event)
  local entity = event.created_entity
  if(vehicle_types[entity.type] and entity.grid) then
    global.vehicles[entity.unit_number] = entity
    update_equipment(entity.unit_number, entity.grid)
  end
end

function on_entity_died(event)
  on_entity_removed(event.entity)
end

function on_player_placed_equipment(event)
  for unit, entity in pairs(global.vehicles) do
    if(entity.valid and entity.grid == event.grid) then
      update_equipment(unit, event.grid)
      break
    end
  end
end

function on_player_removed_equipment(event)
  for unit, entity in pairs(global.vehicles) do
    if(entity.valid and entity.grid == event.grid) then
      update_equipment(unit, event.grid)
      break
    end
  end
end

function on_preplayer_mined_item(event)
  on_entity_removed(event.entity)
end

function on_robot_pre_mined(event)
  on_entity_removed(event.entity)
end

function on_tick(event)
  function real_on_tick(event)
    fuel_tick()
  end
  
  for _, unit in pairs(invalid_entities) do
    local unit = invalid_entities[i]
    if global.vehicles[unit] ~= nil then global.vehicles[unit] = nil end
  end
  invalid_entities = { }
  script.on_event(defines.events.on_tick, real_on_tick)
  real_on_tick(event)
end

-- Remote interface
-------------------------------------------------------------------------------

function register_transformer(data)
  assert(type(data.name) == "string", "'name' must be a string")
  local prototype = game.equipment_prototypes[data.name]
  assert(prototype, string.format("%s is not a valid equipment prototype", data.name))
  assert(prototype.energy_source, string.format("%s has no energy_source", data.name))
  global.transformers[data.name] =
  {
    [1] = data.name,
    [2] = prototype.energy_source.input_flow_limit,
  }
end