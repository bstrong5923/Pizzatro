extends Equipment
class_name Salt_Chips

var multiplier = 1.5
var inc = .25

func on_card_played(ingredient):
	if ingredient.name == "Salt":
		Score.flavor_values[2] *= multiplier

func upgrade():
	multiplier += inc
	description = description.replacen(str(multiplier - inc), str(multiplier))
