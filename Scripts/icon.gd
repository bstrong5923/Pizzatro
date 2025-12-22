extends Sprite2D

func set_ingredient(i):
	texture = i.minis
	region_rect.size.x = 5
	region_rect.size.y = 5
	scale.x = 5
	scale.y = 5
	position.x = 5 * -8
	position.y = 5 * -13

func change_scale(v):
	scale.x = 5 * v
	scale.y = 5 * v
	position.x = 5 * -8 * v
	position.y = 5 * -13 * v
