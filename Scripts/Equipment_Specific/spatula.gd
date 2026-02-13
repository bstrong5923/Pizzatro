extends Equipment
class_name Spatula

var multiplier = 3

func on_card_played(ingredient):
	CardFunction.flavors_to_add[0] *= multiplier
