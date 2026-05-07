extends Equipment
class_name Ranch

var multiplier = 2
var inc = .5

func on_submit():
	Score.flavor_values[3] *= multiplier

func upgrade():
	multiplier += inc
