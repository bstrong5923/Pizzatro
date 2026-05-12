extends Equipment
class_name Butcher_Knife

var multiplier = 2.5
var inc = .5

func on_card_played(ingredient):
	if ingredient.types.has("meat"):
		for f in CardFunction.flavors_to_add.size():
			CardFunction.flavors_to_add[f] *= multiplier
		return true
	return false

func upgrade():
	multiplier += inc
	description = description.replacen(str(multiplier - inc), str(multiplier))
