extends Equipment
class_name Spirt

var lemons = 0
var limes = 0

func on_round_start(a):
	Score.flavor_values[0] += 20

func on_card_played(ingredient):
	if ingredient.name == "Lime":
		for f in CardFunction.flavors_to_add.size():
			CardFunction.flavors_to_add[f] *= pow(2,lemons)
		limes += 1
	elif ingredient.name == "Lemon":
		for f in CardFunction.flavors_to_add.size():
			CardFunction.flavors_to_add[f] *= pow(2,limes)
		lemons += 1

func on_submit(a):
	lemons = 0
	limes = 0
