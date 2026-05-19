extends Equipment
class_name Champagne

var multiplier = 3.0
var inc = .8

func on_submit(score):
	if (Deck.deck_remaining.size() == 0):
		for f in range(score.flavor_values.size()):
			score.flavor_values[f] = score.flavor_values * multiplier

func upgrade():
	multiplier += inc
	description = description.replacen(str(multiplier - inc), str(multiplier))
