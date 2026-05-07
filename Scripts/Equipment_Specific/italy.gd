extends Equipment
class_name Italy

func on_card_played(test):
	print("i should probably draw a card now!")
	if Deck.hand.size() == 1:
		Deck.draw_card()
		return true
	return false
