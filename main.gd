extends Node
@onready var game = preload("res://Scenes/Game.tscn")

func _ready() -> void:
	print("yo")
	var game_scene = game.instantiate()
