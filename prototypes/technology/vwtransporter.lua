data:extend({
--Technology

{
    type = "technology",
    name = "vwtransporter",
    icon = "__vwtransporter_A16__/graphics/technology/vwtransporter.png",
	icon_size = 128,
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "vwtransporter"
      },
    },
    prerequisites = {"automobilism"},
    unit =
    {
      count = 30,
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