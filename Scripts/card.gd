extends Sprite2D



func _ready():
	var logo = $ingredient_logo
	# random ingredient logo
	var frames = logo.texture.get_width() / logo.region_rect.size.x
	var random_index = randi_range(0, frames - 1)
	logo.set_ingredient(random_index)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if is_pixel_opaque(get_local_mouse_position()): # was I the thing that was clicked?
			var logo = $ingredient_logo
			var random_index = randi_range(0, 5)
			logo.set_ingredient(random_index)
