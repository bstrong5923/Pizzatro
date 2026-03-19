extends Equipment
class_name Peeler

var multiplier = 1.5

func on_card_played(ingredient):
	if ingredient.types.has("fruit") or ingredient.types.has("vegetable"):
		for i in range(ingredient.flavors.size()):
			CardFunction.flavors_to_add[i] *= multiplier

func for_description(ingredient):
	if ingredient.types.has("fruit") or ingredient.types.has("vegetable"):
		for i in range(ingredient.flavors.size()):
			CardFunction.flavors_to_add_desc[i] += ingredient.flavors[i] * multiplier
