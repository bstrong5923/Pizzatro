extends Sprite2D



func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Deck.clear_shop_hand()
		visible = false
		get_node("/root/Game/Pack").visible = true
