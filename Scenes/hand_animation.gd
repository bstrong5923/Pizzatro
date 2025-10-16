extends Sprite2D

var step
var ingredient

func go(ing):
	ingredient = ing
	region_rect.position.x = 0
	position.x = 6
	position.y = -67
	step = 1
	print(Deck.deck)

func _process(delta: float) -> void:
	if step == 1:
		position.y += scale.x
		if position.y >= -17:
			step = 2
	elif step == 2:
		region_rect.position.x += 50
		if region_rect.position.x >= 100:
			# scatter the mini ingredients
			var minis = get_node("/root/Game/minis")
			minis.scatter(ingredient)
			step = 3
	elif step == 3:
		position.y -= scale.x
		if position.y <= -111:
			step = 0
		
