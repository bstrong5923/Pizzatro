extends Equipment
class_name Spatula

var multiplier = 3

func effect(scor, ingredient):
	scor.add_points(ingredient.flavors[0] * (multiplier - 1), 0) # multiplies sweet
