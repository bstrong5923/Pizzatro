extends Equipment
class_name Scale

var minus = -10

func on_submit(score):
	var min_val_index = 0
	for f in range(1, score.flavor_values.size()): # find lower flavor
		if score.flavor_values[f] < score.flavor_values[min_val_index]:
			min_val_index = f
	
	for f in score.flavor_values.size():
    if f != min_val_index:
		  score.flavor_values[f] *= score.flavor_values[min_value_index] + minus
    score.flavor_values[min_value_index] = 0
	
func upgrade():
	minus += 10
