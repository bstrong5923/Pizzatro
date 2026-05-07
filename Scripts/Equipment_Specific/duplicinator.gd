extends Equipment
class_name Duplicinator

var last_played = null

func on_card_played(ingredient):
	last_played = ingredient
	return true

func on_submit():
	if last_played:
		Deck.deck.push_back(last_played)
	last_played = null

func upgrade():
	pass
