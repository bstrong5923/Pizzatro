extends Equipment
class_name John_Green

var multiplier = 2.5

func on_card_played(ingredient):
	if ingredient.types.has("green"):
		for i in range(ingredient.flavors.size()):
			ingredient.flavors[i] *= multiplier
