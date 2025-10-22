extends Node2D

var card = preload("res://Scenes/card.tscn")

var deck = []
var deck_remaining = []
var hand = []
var discard_pile = [] #not usin this rn

func go():
	fill_initial_deck()
	for x in range(0,4):
		add_card()
	fix_hand()

func fill_initial_deck():
	deck = []
	for ingredient in range(0,6):
		for x in range(0,4):
			deck.push_back(ingredient)
	deck_remaining = deck

func add_card():
	var instance = card.instantiate()
	instance.set_ingredient(pick_card())
	instance.position = Vector2(0, 39)
	add_child(instance)
	hand.push_back(instance)
	
func pick_card():
	print(deck_remaining)
	var card_drawn = deck_remaining[randi_range(0, deck_remaining.size() - 1)]
	deck_remaining.erase(card_drawn)
	return card_drawn
	
func fix_hand():
	for c in range(0, hand.size()):
		@warning_ignore("integer_division")
		hand[c].position.x = 30 * (hand.size() / (-2) + 0.5 * ((hand.size() + 1) % 2) + c)
		
func remove_card(index):
	discard_pile.push_back(hand.pop_at(index))
	
#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#generate_card()

func generate_card():
	add_card()
	fix_hand()
	
