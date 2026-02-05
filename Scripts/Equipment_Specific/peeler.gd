extends Equipment
class_name Peeler

var multiplier = 3

func effect(scor, ingredient):
	if ingredient.types.find("fruit") + ingredient.types.find("vegetable") > -2:
		for x in ingredient.flavors.size():
			scor.add_points(ingredient.flavors[x] * (multiplier - 1), x)
