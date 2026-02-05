extends Equipment
class_name Grinder

var multiplier = 4

func effect(scor, ingredient):
	if ingredient.types.find("spice") > -1:
		for f in CardFunction.flavors_to_add.size():
			CardFunction.flavors_to_add[f] *= multiplier
