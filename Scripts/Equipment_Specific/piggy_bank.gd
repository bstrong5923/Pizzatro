extends Equipment
class_name Piggy_Bank

var minus = -1

func on_card_played(ingredient):
	var mult = ingredient.price + minus
	if mult < 1:
		mult = 1
	for f in CardFunction.flavors_to_add.size():
		CardFunction.flavors_to_add[f] *= mult 
	return true

func upgrade():
	minus += 1
