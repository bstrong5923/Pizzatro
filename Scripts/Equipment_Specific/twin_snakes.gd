extends Equipment
class_name Twin_Snakes

func on_submit(score):
	var digits = 0
	var neg = 1
	if score.flavor_values[0] < 0:
		neg = -1
	while abs(score.flavor_values[0]) >= pow(10, digits):
		digits += 1
	score.flavor_values[3] *= digits * neg
	if score.flavor_values[0] != 0:
		return true
