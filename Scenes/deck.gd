extends Node2D

var card = preload("res://Scenes/card.tscn")

var deck = []
var deck_remaining = []

func go():
	fill_initial_deck()
	add_card()

func fill_initial_deck():
	deck = []
	for ingredient in range(0,6):
		for x in range(0,4):
			deck.push_back(ingredient)
	deck_remaining = deck

func add_card():
	var instance = card.instantiate()
	instance.set_ingredient(pick_card())
	instance.position = Vector2(-30, 0)
	add_child(instance)

func pick_card():
	var card_drawn = deck_remaining[randi_range(0, deck.size() - 1)]
	deck_remaining.erase(card_drawn)
	return card_drawn
