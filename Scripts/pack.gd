extends Sprite2D



func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#this works twins dont even fuck with me
		if Deck.shop_hand.size() == 0 and Score.money > 10:
			Deck.draw_shop_hand()
			Score.money -= 10
			get_node("/root/Game/Labels/money/Count").text = str(Score.money)
		elif Deck.shop_hand.size() > 0 and Score.money > 10:
			Deck.draw_shop_hand()
			Score.money -= 10
			get_node("/root/Game/Labels/money/Count").text = str(Score.money)
