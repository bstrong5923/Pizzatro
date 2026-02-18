extends Equipment
class_name Peeler

var multiplier = 1.5

func on_card_played(ingredient):
	if ingredient.types.find("fruit") + ingredient.types.find("vegetable") > -2:
		for f in CardFunction.flavors_to_add.size():
			CardFunction.flavors_to_add[f] *= multiplier
