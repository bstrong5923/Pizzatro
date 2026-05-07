extends Equipment
class_name Prescience

var upgraded = false

func on_card_played(ingredient):
	if ingredient.types.has("spice"):
		Deck.draw_card()
		if upgraded:
			Deck.draw_card()
		return true
	return false

func upgrade():
	upgraded = true
	description = description.replacen("draw a card", "draw two cards")
