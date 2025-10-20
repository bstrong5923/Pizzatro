extends Node

static var time_left = 0
static var can_play_a_card = true

static func cooldown():
	can_play_a_card = false
	time_left = 76 # time that hand animation takes
	
static func can_play_card_query():
	print("AAAAAAAAAAAAAAAAAAAAHH")
	return can_play_a_card

func _process(delta: float) -> void:
	if time_left > 0:
		time_left -= 1
	else:
		can_play_a_card = true
	
