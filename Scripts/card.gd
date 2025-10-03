extends Sprite2D


func _ready():
	# random ingredient logo
	var logo = $ingredient_logo
	var frames = logo.texture.get_width() / logo.region_rect.size.x
	var random_index = randi_range(0, frames - 1)
	logo.get_ingredient(random_index)
