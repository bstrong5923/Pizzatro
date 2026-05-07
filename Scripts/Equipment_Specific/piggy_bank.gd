extends Equipment
class_name Piggy_Bank

func on_card_played(ingredient):
	var price = ingredient.price
	print(price)
	for f in CardFunction.flavors_to_add.size():
		CardFunction.flavors_to_add[f] *= price

func upgrade():
	pass
