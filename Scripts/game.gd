extends Node2D

var level 
var minimums = [25, 42, 66, 91, 120, 180]
var playing = false

func _ready() -> void:
	level = 0
	Deck.fill_initial_deck()
	new_round()

func new_round():
	level += 1
	Deck.set_minimum(minimums[level - 1])
	Deck.fill_deck_remaining()
	Deck.draw_hand()
	$Labels/Energy.set_energy(20)
	$Labels/Score.clear_score()
	Deck.draw_shop_hand()
	playing = true

func playing_off():
	playing = false
	
func is_playing():
	return playing
