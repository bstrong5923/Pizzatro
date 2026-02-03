extends Node2D
var pressed = false
func _on_area_2d_mouse_entered() -> void:
	$equipment_button.texture = load("res://Assets/Sprites/equipment/open_close_pressed.png")
	
func _on_area_2d_mouse_exited() -> void:
	$equipment_button.texture = load("res://Assets/Sprites/equipment/open_close_button.png")


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if (pressed == true):
			var target_y = 0
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position:y", target_y , .2)
			pressed = false
			
		elif (pressed == false):
			var target_y = 20
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position:y", target_y , .2)
			pressed = true
