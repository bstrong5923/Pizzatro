extends Sprite2D

var step
var ingredient

func go(ing):
	ingredient = ing
	region_rect.position.x = 0
	position.x = 30
	position.y = -334
	step = 1

func _process(delta: float) -> void:
	if step == 1:
		position.y += 10
		if position.y >= -74:
			step = 2
	elif step == 2:
		region_rect.position.x += 50
		if region_rect.position.x >= 100:
			# scatter the mini ingredients
			var minis = get_node("/root/Game/minis")
			minis.scatter(ingredient)
			step = 3
	elif step == 3:
		position.y -= 10
		if position.y <= -554:
			step = 0
