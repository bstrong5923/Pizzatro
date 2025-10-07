extends Sprite2D

var ingredient

func _ready():
	# random ingredient logo
	var logo = $ingredient_logo
	var frames = logo.texture.get_width() / logo.region_rect.size.x
	var random_index = randi_range(0, frames - 1)
	set_ingredient(random_index)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if is_pixel_opaque(get_local_mouse_position()): # was I the thing that was clicked?
			# scatter the mini ingredients
			print("clicked!")

func set_ingredient(i):
	ingredient = i;
	
	# make the ingredient logo show the right ingredient
	var logo = $ingredient_logo
	logo.show_ingredient(ingredient)
