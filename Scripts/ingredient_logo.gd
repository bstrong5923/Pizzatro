extends Sprite2D

var ingredient = 0

func set_ingredient(i):
	ingredient = i
	region_rect.position.x = ingredient * region_rect.size.x
	
