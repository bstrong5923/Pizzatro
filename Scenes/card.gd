extends Sprite2D

var ingredient = 0

var play_timer = preload("res://Scenes/card_timer.gd")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and play_timer.can_play_a_card: # on click
		if is_pixel_opaque(get_local_mouse_position()): # was I the thing that was clicked?
			# animation to add the ingredients
			var hand = get_node("/root/Game/hand_animation")
			print(ingredient)
			hand.go(ingredient)
			queue_free()
			Deck.fix_hand()
			play_timer.cooldown()

func set_ingredient(i):
	ingredient = i
	region_rect.position.x = i * region_rect.size.x
	while region_rect.position.x >= texture.get_width():
		region_rect.position.x -= texture.get_width()
		region_rect.position.y += region_rect.size.y
