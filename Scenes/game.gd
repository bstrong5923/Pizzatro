extends Node2D


func _ready() -> void:
	Deck.go()
	$Labels/Balance.set_balance(3000)
