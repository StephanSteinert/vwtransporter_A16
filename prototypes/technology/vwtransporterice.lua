data:extend({
--Technology

{
    type = "technology",
    name = "vwtransporterice",
    icon = "__vwtransporter_A16__/graphics/technology/vwtransporterice.png",
	icon_size = 128,
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "vwtransporterice"
      },
    },
    prerequisites = {"vwtransporter"},
    unit =
    {
      count = 30,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1}
      },
      time = 20
    },
    order = "e-c-d"
  },

})