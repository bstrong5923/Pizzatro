extends Node2D

var ingredient = 0
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
	if ingredient == 0:
		scor.add_points(5, 2)
		scor.add_points(2, 4)

	# pineapple
	elif ingredient == 1:
		scor.add_points(5, 0)
		
	# mushroom
	elif ingredient == 2:
		scor.add_points(4, 4)
	# tomater
	elif ingredient == 3:
		scor.add_points(2, 3)
		scor.add_points(1, 0)
	#jalapeno
	elif ingredient == 4:
		scor.add_points(6, 1)
	#basil
	elif ingredient == 5:
		for x in range(2):
			var a = randi_range(0, 5)
			Deck.add_spec_card(a)
		Deck.fix_hand()
		
