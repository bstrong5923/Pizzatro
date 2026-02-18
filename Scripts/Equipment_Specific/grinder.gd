extends Equipment
class_name Grinder

var bonus = 5

func on_card_played(ingredient):
	if ingredient.types.find("spice") > -1:
		for f in CardFunction.flavors_to_add.size():
			CardFunction.flavors_to_add[f] += bonus
