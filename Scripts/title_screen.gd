extends Node2D

func _on_ready() -> void:
	preload("res://Scenes/Game.tscn")


func _on_start_button_pressed() -> void:
	print("playing")
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

	

func _on_load_button_pressed() -> void:
	print("you cant load yet bro")
	Deck.toggle_texture_mode()
	print("texture mode set to " + Deck.texture_mode)
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	print("quitting")
	get_tree().quit()
