extends Node2D

var level 

func _ready() -> void:
	print("gerb")
	level = 0
	Deck.fill_initial_deck()
	new_round()

func new_round():
	level += 1
	Deck.fill_deck_remaining()
	Deck.draw_hand()
	$Labels/Energy.set_energy(45)
	Deck.draw_shop_hand()
