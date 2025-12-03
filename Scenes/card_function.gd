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
	
func check_function():
	# pepperoni
	scor.add_points(ingredient.sweet, 0)
	scor.add_points(ingredient.spicy, 1)
	scor.add_points(ingredient.salty, 2)
	scor.add_points(ingredient.sour, 3)
	scor.add_points(ingredient.savory, 4)
	#basil
<<<<<<< Updated upstream
	elif ingredient == 5:
		Deck.draw_card()
		Deck.draw_card()
=======
	if ingredient.name == "Basil":
		for x in range(2):
			var a = randi_range(0, 5)
			# turn a into random card
			
			Deck.add_card()
		Deck.fix_hand()
>>>>>>> Stashed changes
		
