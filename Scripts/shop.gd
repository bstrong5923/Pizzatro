extends Node2D

var card = preload("res://Scenes/shop_card.tscn")

@export var deck2 : Array[Card] = []

var shop_deck : Array[Card] = [
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

var card_highlighted = 0
var shop_deck_remaining : Array[Card] = []
var shop_hand = []




func fill_initial_deck(): # ONLY CALLED ONCE at beginning of a run (to fill the default deck)
	print("smile")
	#shop_deck = []
	#for ingredient in range(0,6):
		#for x in range(0,4):
			#shop_deck.push_back(ingredient)

func fill_deck_remaining(): # called at beginning of each round
	shop_deck_remaining = []
	for x in range(0, shop_deck.size()):
		shop_deck_remaining.push_back(shop_deck[x])
		
func draw_hand():
	for x in range(0,5):
		draw_card()
	fix_hand()

func draw_card():
	if shop_deck_remaining.size() > 0:
		var instance = card.instantiate()
		instance.set_ingredient(pick_card())
		instance.position = Vector2(0, 39)
		instance.change_scale(1)
		add_child(instance)
		shop_hand.push_back(instance)
		fix_hand()

func pick_card():
	var card_drawn = shop_deck_remaining[randi_range(0, shop_deck_remaining.size() - 1)]
	shop_deck_remaining.erase(card_drawn)
	return card_drawn

#adds specfic card with region value i
func draw_spec_card(i):
	var instance = card.instantiate()
	
	instance.set_ingredient(load("res://Assets/cards/" + str(i) + ".tres"))
	instance.position = Vector2(0, 39)
	instance.change_scale(1)
	add_child(instance)
	shop_hand.push_back(instance)
	fix_hand()


#fan out code
#where fix hand used to be
func fix_hand():
	
	var h = shop_hand.size()

	for i in range(0, h):
		@warning_ignore("integer_division")
		shop_hand[i].position.x =  750+ (150 * i)
		shop_hand[i].position.y =  -190
		
