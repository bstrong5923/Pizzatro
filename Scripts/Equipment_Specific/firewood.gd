extends Equipment
class_name Firewood

var multiplier = 2
var inc = .5

func on_submit(a):
	Score.flavor_values[4] *= multiplier

func upgrade():
	multiplier += inc
	description = description.replacen(str(multiplier - inc), str(multiplier))
