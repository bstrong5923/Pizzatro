extends Sprite2D

func set_ingredient(i):
	texture = i.minis
	region_rect.size.x = 5
	region_rect.size.y = 5
	texture.scale.x = 1
	texture.scale.y = 1
