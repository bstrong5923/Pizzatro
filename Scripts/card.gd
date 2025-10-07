extends Sprite2D

var logo = $ingredient_logo

func _ready():
	# random ingredient logo
	var frames = logo.texture.get_width() / logo.region_rect.size.x
	var random_index = randi_range(0, frames - 1)
	logo.set_ingredient(random_index)

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		logo.set_ingredient(4)
