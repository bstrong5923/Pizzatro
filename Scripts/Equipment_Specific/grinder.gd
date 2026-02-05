extends Equipment
class_name Grinder

var multiplier = 4

func effect(scor, ingredient):
	if ingredient.types.find("spice") > -1:
		for x in ingredient.flavors.size():
			scor.add_points(ingredient.flavors[x] * (multiplier - 1), x)
