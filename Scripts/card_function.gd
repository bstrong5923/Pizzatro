extends Node2D

var ingredient
var card = preload("res://Scenes/card.tscn")
@onready
var scor = get_node("/root/Game/Labels/Score")
## add functions for different cards
# i value legend:
# 0 = pepperoni
# 1 = pineapple
# 2 = mushroom
# 3 = tomato
# 4 = jalapeno
# 5 = basil

# index of different flavors
# 0 = sweet
# 1 = spicy
# 2 = salty
# 3 = sour
# 4 = savory


func set_card(i):
	ingredient = i
	
func run_card_function():
	
	scor.add_points(ingredient.sweet, 0)
	scor.add_points(ingredient.spicy, 1)
	scor.add_points(ingredient.salty, 2)
	scor.add_points(ingredient.sour, 3)
	scor.add_points(ingredient.savory, 4)
	#basil
	if ingredient.name == "Basil":
		Deck.draw_card()
		Deck.draw_card()
		Deck.fix_hand()
