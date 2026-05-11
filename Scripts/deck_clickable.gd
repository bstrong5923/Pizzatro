extends Sprite2D

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	_handle_click(event)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if _is_mouse_over_deck():
			_handle_click(event)

func _is_mouse_over_deck() -> bool:
	if texture == null:
		return false
	return get_rect().has_point(to_local(get_global_mouse_position()))

func _handle_click(event: InputEvent) -> void:
	if !(event is InputEventMouseButton):
		return
	if event.button_index != MOUSE_BUTTON_LEFT or !event.pressed:
		return

	var remove_card_menu = get_node("/root/Game/RemoveCardMenu")
	if remove_card_menu.is_deck_view_open():
		remove_card_menu.close()
		get_viewport().set_input_as_handled()
		return
	if remove_card_menu.is_open():
		get_viewport().set_input_as_handled()
		return
	if get_node("/root/Game").is_playing():
		remove_card_menu.open_deck_view()
		get_viewport().set_input_as_handled()
