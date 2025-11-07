extends Node2D

var score
var flavor_value = [0, 0, 0, 0, 0]
# index of different flavors
# 0 = sweet
# 1 = spicy
# 2 = salty
# 3 = sour
# 4 = savory
# flavor_value[2] += 5
func get_score():
	return score

func add_points(i, f):
	score = score + i
