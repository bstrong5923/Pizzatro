extends Node2D

var level 

func _ready() -> void:
	level = 0 
	Deck.fill_initial_deck()
	new_round()

func new_round():
	level += 1
	Deck.fill_deck_remaining()
	Deck.fix_hand()
	$Labels/Balance.set_balance(45)
	
	

func _on_area_2d_mouse_shape_entered(shape_idx: int) -> void:
	pass # Replace with function body.
