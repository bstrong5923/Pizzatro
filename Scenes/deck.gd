extends Node2D

var card = preload("res://Scenes/card.tscn")
# starting deck which isn't changed during gameplay
@export var deck2 : Array[Card] = []

var deck : Array[Card] = [
	load("res://Assets/cards/Basil.tres"),
	load("res://Assets/cards/Jalapeno.tres"),
	load("res://Assets/cards/Mushroom.tres"),
	load("res://Assets/cards/Pepperoni.tres"),
	load("res://Assets/cards/Pineapple.tres"),
	load("res://Assets/cards/Tomato.tres"),
	load("res://Assets/cards/Basil.tres"),
	load("res://Assets/cards/Jalapeno.tres"),
	load("res://Assets/cards/Mushroom.tres"),
	load("res://Assets/cards/Pepperoni.tres"),
	load("res://Assets/cards/Pineapple.tres"),
	load("res://Assets/cards/Tomato.tres"),
]

# undrawn cards
var deck_remaining : Array[Card] = []

var hand = []
var discard_pile = [] #not usin this rn
var card_highlighted = 0

<<<<<<< Updated upstream
func fill_initial_deck(): # ONLY CALLED ONCE at beginning of a run (to fill the default deck)
	deck = []
	for ingredient in range(0,6):
		for x in range(0,4):
=======
func go():
	z_index = -999
	fill_initial_deck()
	for x in range(2):
		add_card()
	fix_hand()

func fill_initial_deck():
	for ingredient in range(0,6):
>>>>>>> Stashed changes
			deck.push_back(ingredient)

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
		instance.set_ingredient(pick_card())
		instance.position = Vector2(0, 39)
		instance.change_scale(1)
		add_child(instance)
		hand.push_back(instance)
		fix_hand()

func pick_card():
	var card_drawn = deck_remaining[randi_range(0, deck_remaining.size() - 1)]
	deck_remaining.erase(card_drawn)
	return card_drawn

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
<<<<<<< Updated upstream
		
		Deck.draw_card()
=======
	
		Deck.add_card()
>>>>>>> Stashed changes
		Deck.fix_hand()
		print(Deck.deck_remaining.size())
		if Deck.deck_remaining.size() <= 0:
			visible = false
<<<<<<< Updated upstream
			
=======
>>>>>>> Stashed changes
