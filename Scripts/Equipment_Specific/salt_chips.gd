extends Equipment
class_name Salt_Chips

func on_card_played(ingredient):
	if ingredient.name == "Salt":
		Score.flavor_values[2] *= 1.5
