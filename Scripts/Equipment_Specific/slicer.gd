extends Equipment
class_name Slicer

var basil_resource = load("res://Assets/cards/Basil.tres")

func on_bought():
	basil_resource.price /= 2.0
	for c in Deck.deck:
		if c.name == "Basil":
			c.price = basil_resource.price

func on_card_played(ingredient):
	if ingredient.name == "Basil":
		Deck.draw_card()
	
