extends Equipment
class_name Italy

func on_cardd_played(test):
	print("i should probably draw a card now!")
	if (Deck.hand.size() == 1):
		Deck.draw_card()
