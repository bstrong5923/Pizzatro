extends Node2D

var level 
var minimums = [12, 20, 30, 42, 65, 80, 100]
var playing = false
var starting_energy
var n = 1
func _ready() -> void:
	level = 0
	Deck.fill_initial_deck()
	Equip.fill_common_equip_list()
	new_round()
	n = 1

func new_round():
	level += 1
	starting_energy = 20
	# check equipments
	for e in Equip.get_my_equipment():
		if e.round_start:
			await e.on_round_start(self)
			
	if level <= minimums.size():
		Deck.set_minimum(minimums[level - 1])
	else:
		n *= 2
		Deck.set_minimum(100 * n)
	Deck.fill_deck_remaining()
	Deck.draw_hand()
	$Labels/Energy.set_energy(starting_energy)
	$Labels/Score.clear_score()
	$pie/minis.clear_minis()
	Deck.clear_shop_hand()
	$drawer.sort_equipments()
	playing = true
	await get_tree().create_timer(0.45).timeout # wait for shop to be offscreen
	

func playing_off():
	playing = false
	
func is_playing():
	return playing

func get_level():
	return level
	
func game_over():
	$RemoveCardMenu.reset_saved_discards()
	Equip.wipe_equipment()
	Score.reset_money()
	n = 1 
	#change to game over screen eventually
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
