extends Equipment
class_name Slicer

var basil_resource = load("res://Assets/cards/Basil.tres")
var multiplier = 1
func on_bought(g):
	basil_resource.price /= 2.0
	for c in Deck.deck:
		if c.name == "Basil":
			c.price = basil_resource.price

func on_card_played(ingredient):
	if ingredient.name == "Basil":
		for i in range(0, multiplier):
			Deck.draw_card()
	
func upgrade():
	multiplier += 1
