extends Equipment
class_name Champagne

var multiplier = 3.0
var inc = .8

func on_submit(input):
	if (Deck.deck_remaining.size() == 0):
		for x in 5:
			CardFunction.flavors_to_add[x] *= multiplier

func upgrade():
	multiplier += inc
	description = description.replacen(str(multiplier - inc), str(multiplier))
