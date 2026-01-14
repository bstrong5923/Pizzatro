extends Sprite2D

func set_ingredient(i):
	if Deck.texture_mode == 'default':
		texture = i.texture
	else:
		texture = i.texture_retro
