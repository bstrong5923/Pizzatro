extends Equipment
class_name Meat_Hook

var multiplier = 4.0
var done = false

func on_card_played(ingredient):
	if !done and ingredient.types.has("meat"):
		for f in CardFunction.flavors_to_add.size():
			CardFunction.flavors_to_add[f] *= multiplier
		done = true
		return true
	return false

func on_submit():
	done = false

func upgrade():
	multiplier += 0.5
