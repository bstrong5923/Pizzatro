extends Node2D

var score
var flavor_value = [0, 0, 0, 0, 0]
# index of different flavors
# 0 = sweet
# 1 = savory
# 2 = sour
# 3 = spicy
# 4 = salty
# flavor_value[2] += 5
func get_score():
	return score

func add_points(i, f):
	score = score + i
