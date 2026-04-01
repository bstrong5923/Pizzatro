extends Sprite2D

const REMOVE_BUTTON_PRESSED_TEXTURE := preload("res://Assets/Sprites/game scene items/remove_button_pressed.png")


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed):
		texture = REMOVE_BUTTON_PRESSED_TEXTURE
		await get_tree().create_timer(0.5).timeout
		texture = null
		get_node("/root/Game/RemoveCardMenu").open()
