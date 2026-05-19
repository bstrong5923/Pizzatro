extends Equipment
class_name White_Guy

var multiplier = 2
var inc = .5

func on_card_played(ingredient):
	for f in CardFunction.flavors_to_add.size():
			CardFunction.flavors_to_add[f] *= multiplier
	CardFunction.flavors_to_add[1] *= -3

func upgrade():
	multiplier += inc
	description = description.replacen(str(multiplier - inc), str(multiplier))
	description = description.replacen(str((multiplier - inc) * 3), str(multiplier * 3))
