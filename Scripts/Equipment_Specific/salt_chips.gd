extends Equipment
class_name Salt_Chips

func on_card_played(ingredient):
	if ingredient.name == "Salt":
		print(Score.flavor_values[2])
		Score.flavor_values[2] *= 1.5
		print(Score.flavor_values[2])
