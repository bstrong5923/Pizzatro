extends Equipment
class_name Salt_Chips

var multiplier = 1.5

func on_card_played(ingredient):
	if ingredient.name == "Salt":
		Score.flavor_values[2] *= multiplier

func upgrade():
	multiplier += .3
