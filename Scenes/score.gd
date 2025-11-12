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
	flavor_value[f] += i
	var scoreType
	#shitty chain of ifs for now, will find better way to do this in the future
	if (f == 0):
		scoreType = "Sweet"
	elif (f == 1):
		scoreType = "Spicy"
	elif (f == 2):
		scoreType = "Salty"
	elif (f == 3):
		scoreType = "Sour"
	elif (f == 4):
		scoreType = "Savory"
	label_node = get_node_or_null(str(scoreType) + "/Count")
	label_node.text = str(flavor_value[f])

func calc():
	label_node = get_node_or_null("Total/Count")
	var total = 0
	for x in range(0, 5):
		total += flavor_value[x]
	label_node.text = str(total)
