extends Sprite2D


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed):
		get_node("/root/Game/RemoveCardMenu").open()
