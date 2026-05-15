extends Equipment
class_name Himalayas

var multiplier = 2
var inc = .5

func on_card_played(ingredient):
	CardFunction.flavors_to_add[2] *= multiplier
	if CardFunction.flavors_to_add[2]> 0:
		return true

func upgrade():
	multiplier += inc
	description = description.replacen(str(multiplier - inc), str(multiplier))
