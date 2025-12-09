extends Node
@onready var game = preload("res://Scenes/Game.tscn")

func _ready() -> void:
	var game_scene = game.instantiate()
