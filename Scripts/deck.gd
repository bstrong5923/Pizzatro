extends Node2D

var card = preload("res://Scenes/card.tscn")

var deck : Array[Card] = []
var file = FileAccess.open("res://Assets/card_list.json", FileAccess.READ)
var raw_text = file.get_as_text()
var data = JSON.parse_string(raw_text)
# undrawn cards
var deck_remaining : Array[Card] = []
var hand = []
var discard_pile = [] #not usin this rn
var card_highlighted = 0
var shop_hand = []

func fill_initial_deck(): # ONLY CALLED ONCE at beginning of a run (to fill the default deck)
	print("smile")
	#deck = []
	for ingredient in range(0,data.size()):
		for x in range(0,2):
			deck.push_back(load("res://Assets/cards/" + data[ingredient] + ".tres"))
			
func fill_deck_remaining(): # called at beginning of each round
	deck_remaining = []
	for x in range(0, deck.size()):
		deck_remaining.push_back(deck[x])
		
func draw_hand():
	for x in range(0,2):
		draw_card()
	fix_hand()
	
func draw_shop_hand():
	for x in range(0,5):
		draw_shop_card()
	fix_shop_hand()
	
func draw_shop_card():
	var instance = card.instantiate()
	var random_index = randi_range(0, deck_remaining.size() - 1)
	instance.set_ingredient(deck_remaining[random_index], true)
	instance.position = Vector2(0, 39)
	instance.change_scale(1)
	add_child(instance)
	shop_hand.push_back(instance)
	fix_hand()
	
	

func draw_card():
	if deck_remaining.size() > 0:
		var instance = card.instantiate()
		var random_index = randi_range(0, deck_remaining.size() - 1)
		instance.set_ingredient(deck_remaining[random_index], false)
		instance.position = Vector2(0, 39)
		instance.change_scale(1)
		add_child(instance)
		hand.push_back(instance)
		fix_hand()
		deck_remaining.remove_at(random_index)
		
func generate_random():
	var a : Card = "res://Assets/cards/" + data[randi_range(0, data.size() - 1)] + ".tres"
	
#adds specfic card with region value i
#never used as of right now, prolly needs to be changed with the times
func draw_spec_card(i):
	var instance = card.instantiate()
	
	instance.set_ingredient(load("res://Assets/cards/" + str(i) + ".tres"), false)
	instance.position = Vector2(0, 39)
	instance.change_scale(1)
	add_child(instance)
	hand.push_back(instance)
	fix_hand()

#fan out code
func fix_hand():
	var h = hand.size()
	var step = 580.0 / h
	if step > 150:
		step = 150
	var middle_index = (h - 1) / 2.0
	
	for x in range(0, h):
		hand[x].position.x = step * (x - middle_index)
		hand[x].position.y = 205
		hand[x].rotation = 0
		
func fix_shop_hand():
	
	var h = shop_hand.size()

	for i in range(0, h):
		shop_hand[i].position.x =  750+ (150 * i)
		shop_hand[i].position.y =  -190
		
func remove_card(index):
	discard_pile.push_back(hand.pop_at(index))
	#click on the deck
	
	
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Deck.draw_card()
		Deck.fix_hand()
		
func add_card_from_shop(i):
	deck_remaining.push_back(i)
