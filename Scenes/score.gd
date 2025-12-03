extends Node2D

var flavor_value = [0, 0, 0, 0, 0]
var flavor_names = ["Sweet", "Spicy", "Salty", "Sour", "Savory"]
var label_nodes = []

<<<<<<< Updated upstream
func _ready() -> void:
	fill_label_nodes()

func fill_label_nodes():
	for x in range (0,5):
		label_nodes.push_back(get_node_or_null(flavor_names[x] + "/Count"))

func add_points(points, f):
	flavor_value[f] += points
	label_nodes[f].text = str(flavor_value[f])
=======
func add_points(i, f):
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
>>>>>>> Stashed changes

func calc():
	var total_label_node = get_node_or_null("Total/Count")
	var total = 0
	for x in range(0, 5):
		total += flavor_value[x]
	total_label_node.text = str(total)
	
func clear_score():
	flavor_value = [0, 0, 0, 0, 0]
	for label_node in label_nodes:
		label_node.text = "0"
		
