extends Equipment
class_name Spatula

var multiplier = 3

func effect(scor, ingredient):
	CardFunction.flavors_to_add[0] *= multiplier
