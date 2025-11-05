extends Node2D

var this_card = 0
var card = preload("res://Scenes/card.tscn")

## add functions for different cards
# i value legend:
# 0 = pep
# 1 = pineapple
# 2 = mushroom
# 3 = tomato
# 4 = jalapeno
# 5 = basil


# index of different flavors
# 0 = sweet
# 1 = savory
# 2 = sour
# 3 = spicy
# 4 = salty


func set_card(i):
	this_card = i
	
func check_function():
	
	# pepperoni
	if this_card == 0:
		Score.add_points(3, 1)
		Score.add_points(2, 4)
		
	# pineapple
	if this_card == 1:
		Deck.fix_hand()
		
	# mushroom
	if this_card == 2:
		Deck.fix_hand()
