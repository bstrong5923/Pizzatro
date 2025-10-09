extends Node

var time_left = 0
var can_play_a_card = true

func confirm():
	print("woohooo!")

func cooldown():
	can_play_a_card = false
	time_left = 76
	

func _process(delta: float) -> void:
	if time_left > 0:
		time_left -= 1
	else:
		can_play_a_card = true
	
