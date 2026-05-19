extends Sprite2D


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if get_node("/root/Game/RemoveCardMenu").is_open():
			return
		var round_buttons = get_node_or_null("/root/Game/Round_buttons")
		if round_buttons and round_buttons.has_method("toggle_sell_equipment"):
			round_buttons.toggle_sell_equipment()
