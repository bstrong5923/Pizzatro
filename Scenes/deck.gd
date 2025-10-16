extends Node2D

signal left_mouse_button_clicked
signal left_mouse_button_released

var deck = ["mushroom", "tomato", "jalapeno"]

func _ready() -> void:
	pass 

func draw_card():
	var card_drawn = deck[0]
	deck.erase(card_drawn)
