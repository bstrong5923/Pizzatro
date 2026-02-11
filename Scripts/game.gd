extends Node2D

var level 
var minimums = [12, 20, 66, 91, 120, 180]
var playing = false

func _ready() -> void:
	level = 0
	Deck.fill_initial_deck()
	new_round()

func new_round():
	level += 1
	if level <= minimums.size():
		Deck.set_minimum(minimums[level - 1])
	else:
		Deck.set_minimum(250)
	Deck.fill_deck_remaining()
	Deck.draw_hand()
	$Labels/Energy.set_energy(20)
	$Labels/Score.clear_score()
	$pie/minis.clear_minis()
	Deck.clear_shop_hand()
	playing = true
	await get_tree().create_timer(0.45).timeout # wait for shop to be offscreen
	

func playing_off():
	playing = false
	
func is_playing():
	return playing

func get_level():
	return level
	
func game_over():
	print("GAME OVER")
	EquipmentBackground.kill_children()
	#change to game over screen eventually
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
