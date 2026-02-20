extends Equipment
class_name Chef_Hat

var multiplier = 1.2


func on_round_end(input):
	var top_val = 0
	var top_val_index = 0
	for f in CardFunction.flavors_to_add.size():
		if CardFunction.flavors_to_add[f] > top_val:
			top_val = CardFunction.flavors_to_add[f]
			top_val_index = f
	print("here we go!" + str(CardFunction.flavors_to_add[top_val_index]))
	CardFunction.flavors_to_add[top_val_index] *= multiplier
	
