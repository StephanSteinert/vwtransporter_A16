require("electric.lib")
require("remote")

local function on_init()
	global.vehicles = global.vehicles or { }
	global.transformers = global.transformers or { }
	global.vehicle_data = global.vehicle_data or { }
	register_transformer{ name = "electric-vehicles-lo-voltage-transformer"}
end

local function on_load()
	global.vehicles = global.vehicles or { }
	global.transformers = global.transformers or { }
	global.vehicle_data = global.vehicle_data or { }
 	rebuild_caches()
end

local function on_configuration_changed(data)
	if next(global.vehicles) == nil then
		global.vehicles = game.players[1].surface.find_entities_filtered{name="Electric-Van"}
		table.insert(global.vehicles, game.players[1].surface.find_entities_filtered{name="vwtransportercargo"})
		
		validate_prototypes()
		validate_entities()
	end
	
end

script.on_init(on_init)
script.on_load(on_load)
script.on_configuration_changed(on_configuration_changed)

script.on_event(defines.events.on_built_entity, on_built_entity)
script.on_event(defines.events.on_entity_died, on_entity_died)
script.on_event(defines.events.on_player_placed_equipment, on_player_placed_equipment)
script.on_event(defines.events.on_player_removed_equipment, on_player_removed_equipment)
script.on_event(defines.events.on_pre_player_mined_item, on_preplayer_mined_item)
script.on_event(defines.events.on_robot_pre_mined, on_robot_pre_mined)
script.on_event(defines.events.on_tick, on_tick)
script.on_event(defines.events.on_train_changed_state, on_train_changed_state)