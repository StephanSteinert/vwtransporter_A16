if not data.raw.item["electric-vehicles-lo-voltage-transformer"] then

	-- Technology -----------
		data.raw["technology"]["electric-vehicles-lo-voltage-transformer"] = 
		{
			type = "technology",
			name = "electric-vehicles-lo-voltage-transformer",
			icon = "__vwtransporter_A16__/graphics/technology/electric-vehicles-lo-voltage-transformer.png",
			icon_size = 128,
			effects =
			{
			  {
				type = "unlock-recipe",
				recipe = "electric-vehicles-lo-voltage-transformer"
			  },
			},
			prerequisites = {"vwtransporter"},
			unit =
			{
			  count = 20,
			  ingredients =
			  {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1}
			  },
			  time = 20
			},
			order = "e-c-d"
		}

		-- Equipment -----------
		data.raw["battery-equipment"]["electric-vehicles-lo-voltage-transformer"] = 
		  {
			type = "battery-equipment",
			name = "electric-vehicles-lo-voltage-transformer",
			sprite =
			{
			  filename = "__vwtransporter_A16__/graphics/equipment/electric-vehicles-lo-voltage-transformer.png",
			  width = 32,
			  height = 32,
			  priority = "medium"
			},
			shape =
			{
			  width = 1,
			  height = 1,
			  type = "full"
			},
			energy_source =
			{
			  type = "electric",
			  buffer_capacity = math.ceil(150 / 60) .. "kJ",
			  input_flow_limit = 150 .. "kW",
			  output_flow_limit = "0W",
			  usage_priority = "primary-input"
			},
			categories = {"electric-vehicles-equipment"},
		  }
		  
		  -- Recipe -------
		data.raw["recipe"]["electric-vehicles-lo-voltage-transformer"] = 
		  {
			type = "recipe",
			name = "electric-vehicles-lo-voltage-transformer",
			enabled = false,
			ingredients =
			{
			  {"iron-plate", 10},
			  {"copper-cable", 50},
			  {"battery", 1},
			},
			result = "electric-vehicles-lo-voltage-transformer",
		  }

		-- Item --------
		data.raw["item"]["electric-vehicles-lo-voltage-transformer"] = 
		  {
			type = "item",
			name = "electric-vehicles-lo-voltage-transformer",
			icon = "__vwtransporter_A16__/graphics/equipment/Icon_electric-vehicles-lo-voltage-transformer.png",
			icon_size = 32,
			placed_as_equipment_result = "electric-vehicles-lo-voltage-transformer",
			subgroup = "electric-vehicles-equipment",
			order = "c",
			stack_size = 10,
		  }

		
end