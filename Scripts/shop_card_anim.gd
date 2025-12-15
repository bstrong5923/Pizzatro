extends Node

static var time_left = 0
static var deleting_card = true

static func cooldown():
	deleting_card = false
	time_left = 76 # time that hand animation takes

func _process(delta: float) -> void:
	if time_left > 0:
		time_left -= 1
	else:
		deleting_card = true
