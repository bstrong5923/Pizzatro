extends Equipment
class_name Butcher_Knife

var multiplier = 2.5

func on_card_played(ingredient):
	if ingredient.types.find("meat") > -1:
		for f in CardFunction.flavors_to_add.size():
			CardFunction.flavors_to_add[f] *= multiplier
