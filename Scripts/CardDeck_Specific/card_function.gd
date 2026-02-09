extends Node2D

var ingredient
var card = preload("res://Scenes/card.tscn")
@onready
var scor = get_node("/root/Game/Labels/Score")

static var flavors_to_add = [0,0,0,0,0]

func set_card(i):
	ingredient = i
	run_card_function()
	

func check_equipment():
	var my_equipment = Equip.get_my_equipment() 
	for e in my_equipment:
		if e.card_of_type:
			await e.effect(scor, ingredient)
	
	
func run_card_function():
	flavors_to_add = ingredient.flavors.duplicate(true)
	await check_equipment()
	for f in ingredient.flavors.size():
		scor.add_points(flavors_to_add[f], f)
	#basil
	if ingredient.name == "Basil":
		Deck.draw_card()
		Deck.draw_card()
		Deck.fix_hand()
