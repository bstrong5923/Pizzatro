extends Equipment
class_name John_Green

var multiplier = 2

func on_card_played(ingredient):
	if ingredient.types.has("green"):
		for f in CardFunction.flavors_to_add.size():
			CardFunction.flavors_to_add[f] *= multiplier

func for_description(ingredient):
	if ingredient.types.has("green"):
		for f in CardFunction.flavors_to_add_desc.size():
			CardFunction.flavors_to_add_desc[f] *= multiplier

func upgrade():
	multiplier += .7
	description.replacen(str(multiplier - .7), str(multiplier))
