extends Equipment
class_name Chef_Hat

var multiplier = 1.2


func on_round_end(Score):
	var top_val = 0
	var top_val_index = 0
	for I in Score.flavor_values.size():
		if Score.flavor_values[I] > top_val:
			top_val = Score.flavor_values[I]
			top_val_index = I
	print("here we go!" + str(Score.flavor_values[top_val_index]))
	Score.flavor_values[top_val_index] *= multiplier
	print(Score.flavor_values[top_val_index])
	
