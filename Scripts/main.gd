extends Node
@onready var game = preload("res://Scenes/Game.tscn")

func _ready() -> void:
	var game_scene = game.instantiate()

func cleannum(v):
	var result
	if v == float(int(v)) or v >= 1000: # 3.0 --> 3,   1000.5 --> 1000
		result = int(v)
	elif v < 100: # 33.3333333 --> 33.33
		result = snapped(v, 0.01)
	else:  # 333.3333333 --> 333.3
		result = snapped(v, 0.1)
	return result
