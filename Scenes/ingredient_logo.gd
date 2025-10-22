extends Sprite2D

func set_ingredient(i):
	region_rect.position.x = i * region_rect.size.x
	while region_rect.position.x >= texture.get_width():
		region_rect.position.x -= texture.get_width()
		region_rect.position.y += region_rect.size.y
