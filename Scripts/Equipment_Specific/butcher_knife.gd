extends Equipment
class_name Butcher_Knife

var multiplier = 2.5

func on_card_played(ingredient):
	if ingredient.types.has("meat"):
#		for f in CardFunction.flavors_to_add.size():
#			CardFunction.flavors_to_add[f] *= multiplier
	#	for i in range(ingredient.flavors.size()):
		#	ingredient.flavors[i] *= multiplier
			var new_flavors = ingredient.flavors.duplicate()
			for i in range(new_flavors.size()):
				new_flavors[i] *= multiplier
			ingredient.flavors = new_flavors
