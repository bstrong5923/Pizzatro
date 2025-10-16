extends Node2D

var deck = []
var deck_remaining = []

func _ready() -> void:
	fill_initial_deck()

func fill_initial_deck():
	deck = []
	for ingredient in range(0,6):
		for x in range(0,4):
			deck.push_back(ingredient)
	deck_remaining = deck

func draw_card():
	var card_drawn = deck[randi_range(0, deck.size())]
	deck_remaining.erase(card_drawn)
	return card_drawn
