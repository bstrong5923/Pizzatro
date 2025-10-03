extends Sprite2D


func get_ingredient(i):
	region_rect.position.x = i * region_rect.size.x
	
