data:extend({
-- Item
  {
    type = "item",
    name = "vwtransporter",
    icon = "__vwtransporter_A16__/graphics/entity/vwtransporter/icon_vwtransporter.png",
    icon_size = 32,
    subgroup = "transport",
    order = "b[personal-transport]-v[vwtransporter]",
    place_result = "vwtransporter",
    stack_size = 10
  },

--Recipe
  {
    type = "recipe",
    name = "vwtransporter",
    enabled = false,
    ingredients =
    {
      {"engine-unit", 10},
      {"iron-plate", 20},
      {"steel-plate", 20},
    },
	  energy_required = 15,
    result = "vwtransporter"
  },

--Entity
  {
    type = "car",
    name = "vwtransporter",
    icon_size = 32,
    icon = "__vwtransporter_A16__/graphics/entity/vwtransporter/icon_vwtransporter.png",
	  flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
    minable = {mining_time = 1, result = "vwtransporter"},
    max_health = 1000,
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    energy_per_hit_point = 1,
    equipment_grid = "large-equipment-grid",
    resistances =
    {
      {
        type = "fire",
        decrease = 15,
        percent = 50
      },
      {
        type = "physical",
        decrease = 15,
        percent = 30
      },
      {
        type = "impact",
        decrease = 50,
        percent = 60
      },
      {
        type = "explosion",
        decrease = 15,
        percent = 30
      },
      {
        type = "acid",
        decrease = 10,
        percent = 20
      }
    },
    collision_box = {{-0.9, -1.3}, {0.9, 1.3}},
    selection_box = {{-0.9, -1.3}, {0.9, 1.3}},
    effectivity = 0.6,
    braking_power = "180kW", 
	  burner =
    {
      effectivity = 0.75,
      fuel_inventory_size = 2,
      smoke =
      {
        {
          name = "tank-smoke",
          deviation = {0.25, 0.25},
          frequency = 50,
          position = {0, 2.5},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },	
	  consumption = "110kW",
    terrain_friction_modifier = 0.2,
    friction = 0.002,
    light =
    {
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "medium",
          scale = 3,
          width = 200,
          height = 200
        },
		shift = {0, -21},
        size = 2,
        intensity = 0.8
      },
    },
    animation =
    {
      layers =
      {
        {
          width = 192,
          height = 192,
          frame_count = 1,
          direction_count = 160,
          shift = {0, 0},
          animation_speed = 8,
          max_advance = 0.2,
          stripes =
          {
            {
             filename = "__vwtransporter_A16__/graphics/entity/vwtransporter/vwtransporter1.png",
             width_in_frames = 10,
             height_in_frames = 8,
            },
            {
             filename = "__vwtransporter_A16__/graphics/entity/vwtransporter/vwtransporter2.png",
             width_in_frames = 10,
             height_in_frames = 8,
            },
          }
        },
        {
          width = 192,
          height = 192,
          frame_count = 1,
          draw_as_shadow = true,
          direction_count = 160,
          shift = {0, 0},
          max_advance = 0.2,
          stripes = 
          {
            {
             filename = "__vwtransporter_A16__/graphics/entity/vwtransporter/vwtransporter_shadow1.png",
             width_in_frames = 10,
             height_in_frames = 8,
            },
            {
             filename = "__vwtransporter_A16__/graphics/entity/vwtransporter/vwtransporter_shadow2.png",
             width_in_frames = 10,
             height_in_frames = 8,
            },
          }
        } 
      }
    },
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/car-no-fuel-1.ogg",
        volume = 0.6
      },
    },
    stop_trigger_speed = 0.2,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.6
          },
        }
      },
    },
    sound_minimum_speed = 0.2;
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/car-engine.ogg",
        volume = 0.6
      },
      activate_sound =
      {
        filename = "__base__/sound/car-engine-start.ogg",
        volume = 0.6
      },
      deactivate_sound =
      {
        filename = "__base__/sound/car-engine-stop.ogg",
        volume = 0.6
      },
      match_speed_to_activity = true,
    },
    open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.7 },
    close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.7 },
    rotation_speed = 0.010,
    weight = 3000,
    inventory_size = 30
  },
})