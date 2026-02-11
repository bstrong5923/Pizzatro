extends Equipment
class_name Slicer

func on_card_played(ingredient):
	if ingredient.name == "Basil":
		Deck.draw_card()
	
