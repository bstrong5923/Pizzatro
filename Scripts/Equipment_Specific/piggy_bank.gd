extends Equipment
class_name Piggy_Bank

func on_card_played(ingredient):
	var mult = ingredient.price - 1
	if mult < 1:
		mult = 1
	for f in CardFunction.flavors_to_add.size():
		CardFunction.flavors_to_add[f] *= mult 

func upgrade():
	pass
