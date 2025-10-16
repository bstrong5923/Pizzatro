extends Sprite2D

var ingredient = 0

var play_timer

func _ready():
	# random ingredient logo
	var frames = texture.get_width() / region_rect.size.x * texture.get_height() / region_rect.size.y
	ingredient = randi_range(0, frames -1)
	print(frames)
	ingredient = randi_range(0, frames - 1)
	set_ingredient(ingredient)
	play_timer = get_node("/root/Game/card_timer")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and play_timer.can_play_a_card:
		if is_pixel_opaque(get_local_mouse_position()): # was I the thing that was clicked?
			# animation to add the ingredients
			var hand = get_node("/root/Game/hand_animation")
			hand.go(ingredient)
			play_timer.cooldown()

func set_ingredient(i):
	region_rect.position.x = i * region_rect.size.x
	while region_rect.position.x >= texture.get_width():
		region_rect.position.x -= texture.get_width()
		region_rect.position.y += region_rect.size.y
