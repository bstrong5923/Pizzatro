extends Equipment
class_name John_Green

var multiplier = 6.5

func on_card_played(ingredient):
	if ingredient.types.has("green"):
		for f in CardFunction.flavors_to_add.size():
			CardFunction.flavors_to_add[f] *= multiplier
