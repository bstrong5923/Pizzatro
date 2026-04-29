extends Equipment
class_name Italy

func on_cardd_played(test):
	if (Deck.hand.size() == 0):
		Deck.draw_card()
