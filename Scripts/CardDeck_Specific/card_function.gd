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
	run_card_function()
	

func check_equipment():
	var my_equipment
	my_equipment = Equip.get_my_equipment() 
	for x in range(my_equipment.size()):
		for y in range(ingredient.type.size()):
			if my_equipment[x].type[0] == ingredient.type[y]:
				my_equipment[x].effect(scor, ingredient)
	
	
func run_card_function():
	check_equipment()
	for f in ingredient.flavors.size():
		scor.add_points(ingredient.flavors[f], f)
	#basil
	if ingredient.name == "Basil":
		Deck.draw_card()
		Deck.draw_card()
		Deck.fix_hand()
