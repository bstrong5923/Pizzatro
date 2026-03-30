extends Equipment
class_name Grinder

var bonus = 5

func on_card_played(ingredient):
	if ingredient.types.has("spice"):
		for f in CardFunction.flavors_to_add.size():
			if CardFunction.flavors_to_add[f] != 0:
				CardFunction.flavors_to_add[f] += bonus
