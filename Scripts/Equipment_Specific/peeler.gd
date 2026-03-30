extends Equipment
class_name Peeler

var multiplier = 1.5

func on_card_played(ingredient):
	if ingredient.types.has("fruit") or ingredient.types.has("vegetable"):
		for f in CardFunction.flavors_to_add.size():
			CardFunction.flavors_to_add[f] *= multiplier
