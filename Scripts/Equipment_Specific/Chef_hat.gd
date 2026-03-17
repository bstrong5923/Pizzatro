extends Equipment
class_name Chef_Hat

var multiplier = 1.2


func on_submit(score):
	var top_val = 0
	var top_val_indexes = []
	for f in range(score.flavor_values.size()): # find hgihest flavor
		if score.flavor_values[f] > top_val:
			top_val = score.flavor_values[f]
			top_val_indexes = [f]
		elif score.flavor_values[f] == top_val:
			top_val_indexes.append(f)
	print(top_val_indexes)
	
	for i in top_val_indexes:
		score.flavor_values[i] *= multiplier
	
	print("thing 1")
