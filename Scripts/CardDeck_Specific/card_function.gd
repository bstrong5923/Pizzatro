extends Node2D

var ingredient
var card = preload("res://Scenes/card.tscn")
@onready
var scor = get_node("/root/Game/Labels/Score")

func set_card(i):
	ingredient = i

func check_equipment():
	var my_equipment = Equip.get_my_equipment() 
	for e in my_equipment:
		if e.card_of_type:
			e.effect(scor, ingredient)
	
func run_card_function():
	for f in ingredient.flavors.size():
		scor.add_points(ingredient.flavors[f], f)
	#basil
	if ingredient.name == "Basil":
		Deck.draw_card()
		Deck.draw_card()
		Deck.fix_hand()
