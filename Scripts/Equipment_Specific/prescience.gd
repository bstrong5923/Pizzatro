extends Equipment
class_name Prescience

func on_card_played(ingredient):
	if ingredient.types.has("spice"):
		Deck.draw_card()
