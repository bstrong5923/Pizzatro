extends Node2D

var card = preload("res://Scenes/card.tscn")

var deck : Array[Card] = []
var file = FileAccess.open("res://Assets/card_list.json", FileAccess.READ)
var raw_text = file.get_as_text()
var data = JSON.parse_string(raw_text)
# undrawn cards😩😩
var deck_remaining : Array[Card] = []
var hand = []
var discard_pile = [] #not usin this rn 🥀
var card_highlighted = 0
var shop_hand = []
var card_list = []
var minimum = 0

var texture_mode = 'default'

func toggle_texture_mode():
	if texture_mode == 'default':
		texture_mode = 'retro'
	else:
		texture_mode = 'default'

func set_minimum(v):
	minimum = v
	get_node("/root/Game/Labels/minimum/Count").text = str(minimum)

func fill_initial_deck(): # ONLY CALLED ONCE at beginning of a run (to fill the default deck)
	deck = []
	for ingredient in data.size():
		card_list.push_back(load("res://Assets/cards/" + data[ingredient] + ".tres"))
	for ingredient in range(0,6):
		for x in range(0,4): # num of copies of each card
			deck.push_back(load("res://Assets/cards/" + data[ingredient] + ".tres"))
	
func fill_deck_remaining(): # called at beginning of each round
	deck_remaining = []
	for x in range(0, deck.size()):
		deck_remaining.push_back(deck[x])
		
func draw_hand():
	clear_hand()
	for x in range(0,7): # <---- starting hand size
		draw_card()

func clear_hand():
	var c = hand.size() - 1
	while hand.size() > 0:
		hand[c].discard_self()
		c -= 1
	
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
	
func draw_shop_hand():
	clear_shop_hand()
	for x in range(0,5):
		draw_shop_card()
	fix_shop_hand()

func clear_shop_hand():
	var s = shop_hand.size() - 1
	while shop_hand.size() > 0:
		shop_hand[s].discard_self()
		s -= 1
	
func draw_shop_card():
	var instance = card.instantiate()
	var random_index = randi_range(0, card_list.size() - 1)
	instance.set_ingredient(card_list[random_index], true)
	instance.position = Vector2(0, 39)
	instance.change_scale(1)
	add_child(instance)
	shop_hand.push_back(instance)


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
		shop_hand[i].position.x =  900+ ( 150 * i)
		shop_hand[i].position.y =  -50
		
func remove_card(index):
	discard_pile.push_back(hand.pop_at(index))
	#click on the deck
	
	
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if get_node("/root/Game").is_playing() and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#Deck.draw_card()
		pass
func add_card_from_shop(i):
	deck.push_back(i)
