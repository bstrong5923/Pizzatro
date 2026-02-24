extends Equipment
class_name Chef_Hat

var multiplier = 1.2


func on_points_add():
	print(str(Score.flavor_values))
	var top_val = 0
	var top_val_index = 0
	##for f in Score.flavor_values.size():
		#if Score.flavor_values[f] > top_val:
			#top_val = Score.flavor_values[f]
			#top_val_index = f
	
	Score.flavor_values[top_val_index] *= multiplier
	
