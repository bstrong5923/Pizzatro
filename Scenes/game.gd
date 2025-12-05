extends Node2D

var level 

func _ready() -> void:
	print()
	level = 0
	Deck.fill_initial_deck()
	new_round()

func new_round():
	level += 1
	Deck.fill_deck_remaining()
	Deck.fix_hand()
	$Labels/Balance.set_balance(45)
	
