extends Equipment
class_name Butcher_Knife

var multiplier = 4

func effect(scor, ingredient):
	if ingredient.types.find("meat") > -1:
		for x in ingredient.flavors.size():
			scor.add_points(ingredient.flavors[x] * (multiplier - 1), x)
