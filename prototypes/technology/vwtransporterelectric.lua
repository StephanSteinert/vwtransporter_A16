data:extend({
--Technology

{
	type = "technology",
	name = "Electric-Van",
	icon = "__vwtransporter_A16__/graphics/technology/vwtransporterelectric.png",
	icon_size = 128,
	effects =
	{
	  {
		type = "unlock-recipe",
		recipe = "Electric-Van"
	  },
	},
	prerequisites = {"vwtransporter"},
	unit =
	{
	  count = 40,
	  ingredients =
	  {
		{"automation-science-pack", 1},
		{"logistic-science-pack", 1}
	  },
	  time = 20
	},
	order = "e-c-d"
},

})