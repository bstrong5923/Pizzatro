extends Node2D

var ingredient
var card = preload("res://Scenes/card.tscn")
@onready
var scor = get_node("/root/Game/Labels/Score")

static var flavors_to_add: Array[float] = [0.0, 0.0, 0.0, 0.0, 0.0]

func set_card(i):
	ingredient = i
	run_card_function()
	

func check_equipment():
	var my_equipment = Equip.get_my_equipment() 
	for e in my_equipment:
		if e.card_played:
			await e.on_card_played(ingredient)
	
	
func run_card_function():
	get_node_or_null("/root/Game/Labels/Energy").change_energy(-ingredient.price)
	for f in range(ingredient.flavors.size()):
		flavors_to_add[f] = float(ingredient.flavors[f])
	await check_equipment()
	for f in ingredient.flavors.size():
		scor.add_points(flavors_to_add[f], f)
	#basil
	if ingredient.name == "Basil":
		Deck.draw_card()
		Deck.draw_card()
		Deck.fix_hand()
