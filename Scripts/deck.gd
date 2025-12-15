extends Node2D

var card = preload("res://Scenes/card.tscn")
@export var deck2 : Array[Card] = []

var deck : Array[Card] = []
var file = FileAccess.open("res://Assets/card_list.json", FileAccess.READ)
var raw_text = file.get_as_text()
var data = JSON.parse_string(raw_text)
# undrawn cards
var deck_remaining : Array[Card] = []
var hand = []
var discard_pile = [] #not usin this rn
var card_highlighted = 0

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

func draw_card():
	if deck_remaining.size() > 0:
		var instance = card.instantiate()
		var random_index = randi_range(0, deck_remaining.size() - 1)
		instance.set_ingredient(deck_remaining[random_index])
		instance.position = Vector2(0, 39)
		instance.change_scale(1)
		add_child(instance)
		hand.push_back(instance)
		fix_hand()
		deck_remaining.remove_at(random_index)
		
func generate_random():
	var a : Card = "res://Assets/cards/" + data[randi_range(0, data.size() - 1)] + ".tres"
	
#adds specfic card with region value i
func draw_spec_card(i):
	var instance = card.instantiate()
	
	instance.set_ingredient(load("res://Assets/cards/" + str(i) + ".tres"))
	instance.position = Vector2(0, 39)
	instance.change_scale(1)
	add_child(instance)
	hand.push_back(instance)
	fix_hand()

#fan out code
func fix_hand():
	var h = hand.size()
	var max_rotate = 0.5 - 0.5 / h
	
	for x in range(0, h):
		@warning_ignore("integer_division")
		if (h-1) % 2 == 0 :
			hand[x].position.x = 6 * ((30 * clamp(1.0 - (h -1) * .05 , .3 ,1.0)) * (h / (-2.0) + 0.5 * ((h + 1) % 2) + x) + (15 - clamp(x, 0, 15)))
			hand[x].z_index = x
		else:
			hand[x].position.x = 6 * ((30 * clamp(1.0 - (h -1) * .05 , .3 ,1.0)) * (h / (-2.0) + 0.5 * ((h + 1) % 2) + x))
			hand[x].z_index = x
		if x!= 0 and x!= h-1:
			hand[x].position.y = 6 * (37 + (2 * abs(x + 0.5 - h / 2.0))) 
		else:
			hand[x].position.y = (6 * (37 + (2 * abs(x + 0.5 - h / 2.0)))) + 25
		hand[x].rotation = 2 * max_rotate * (x + 0.5 - h / 2.0) / (h - 1) if h != 1 else 0
		
func remove_card(index):
	discard_pile.push_back(hand.pop_at(index))
	#click on the deck
	
	
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Deck.draw_card()
		Deck.fix_hand()
		

		
func add_card_from_shop(i):
	deck_remaining.push_back(i)
	print("discarding")
	print(i)
