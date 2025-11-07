extends Node2D

var label_node

var score = 0
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
	print("add points called")
	score = score + i
	label_node = get_node_or_null("Salty/Count")
	if label_node:
		print("Hello!")
	else:
		print("nah")
	$Salty/Count.text = "Hello!"
	if label_node:
		label_node.text = str(score)
	#get_node("Salty/Count").text = "Hello!"
