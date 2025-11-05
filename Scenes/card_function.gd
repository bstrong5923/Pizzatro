extends Node2D

var this_card = 0
var card = preload("res://Scenes/card.tscn")
## add functions for different cards
# i value legend:
# 0 = pepperoni
# 1 = pineapple
# 2 = mushroom
# 3 = tomato
# 4 = jalapeno
# 5 = basil

func set_card(i):
	this_card = i
func check_function():
	
	if this_card == 1:
		Deck.add_spec_card(2)
		Deck.add_spec_card(2)
		Deck.fix_hand()
