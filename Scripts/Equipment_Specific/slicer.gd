extends Equipment
class_name Slicer

var basil_resource = load("res://Assets/cards/Basil.tres")
var multiplier = 1
var plurality = false
func on_bought(g):
	basil_resource.price /= 2.0
	update_existing_basils()

func on_card_played(ingredient):
	if ingredient.name == "Basil":
		for i in range(0, multiplier):
			Deck.draw_card()
	
func on_sold():
	basil_resource.price *= 2.0
	update_existing_basils()
	
func update_existing_basils():
	for c in Deck.deck:
		if c.name == "Basil":
			c.price = basil_resource.price

func upgrade():
	multiplier += 1
	if plurality == false:
		description = description.replacen("card", "cards")
		plurality = true
	description = description.replacen(str(multiplier - 1), str(multiplier))
