extends Equipment
class_name Sacrifice

var done = false
var multiplier = 5
var inc = 5

func on_card_played(ingredient):
	if !done and ingredient.name != "Basil":
		for f in CardFunction.flavors_to_add.size():
			CardFunction.flavors_to_add[f] *= multiplier
		Deck.deck.remove_at(Deck.deck.find(ingredient))
		done = true
		return true
	return false

func on_submit(a):
	done = false

func upgrade():
	multiplier += inc
	description = description.replacen(str(multiplier - inc), str(multiplier))
