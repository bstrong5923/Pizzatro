extends Equipment
class_name Butcher_Knife

var multiplier = 2.5

func on_card_played(ingredient):
	if ingredient.types.has("meat"):
		for f in CardFunction.flavors_to_add.size():
			CardFunction.flavors_to_add[f] *= multiplier

func for_description(ingredient):
	if ingredient.types.has("meat"):
		for f in CardFunction.flavors_to_add_desc.size():
			CardFunction.flavors_to_add_desc[f] *= multiplier

func upgrade():
	multiplier += .4
