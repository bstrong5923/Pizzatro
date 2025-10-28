extends Node2D

var card = preload("res://Scenes/card.tscn")

var deck = []
var deck_remaining = []
var hand = []
var discard_pile = [] #not usin this rn

func go():
	fill_initial_deck()
	for x in range(0, 1):
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
#adds specfic card with region value i
func add_spec_card(i):
	var instance = card.instantiate()
	instance.set_ingredient(i)
	instance.position = Vector2(0, 39)
	add_child(instance)
	hand.push_back(instance)
	
func pick_card():
	var card_drawn = deck_remaining[randi_range(0, deck_remaining.size() - 1)]
	deck_remaining.erase(card_drawn)
	return card_drawn
	
func fix_hand():
	var center_index = (hand.size()-1)/2.0
	var max_rotate = hand.size() * .07
	if (hand.size() > 6):
		max_rotate = .5
	for c in range(0, hand.size()):
		@warning_ignore("integer_division")
		if (hand.size()-1) % 2 == 0 :
			hand[c].position.x = (30 * clamp(1.0 - (hand.size() -1) * .05 , .3 ,1.0)) * (hand.size() / (-2.0) + 0.5 * ((hand.size() + 1) % 2) + c) + (15 - clamp(c, 0, 15))
		else:
			hand[c].position.x = (30 * clamp(1.0 - (hand.size() -1) * .05 , .3 ,1.0)) * (hand.size() / (-2.0) + 0.5 * ((hand.size() + 1) % 2) + c) 
		
		hand[c].position.y = 37+ (2*abs((- 1* hand.size() /2.0) + c))
		hand[c].rotation = max_rotate * (c - center_index) / center_index if center_index != 0 else 0
	
func remove_card(index):
	discard_pile.push_back(hand.pop_at(index))
	

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		
		Deck.add_card()
		Deck.fix_hand()
