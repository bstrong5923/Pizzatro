extends Node2D

var flavor_value = [0, 0, 0, 0, 0]
var flavor_vals_for_adding = [0, 0, 0, 0, 0]
var flavor_names = ["Sweet", "Spicy", "Salty", "Sour", "Savory"]
var label_nodes = []
var calculating = false
#variable for calculating total
var i = 0
var total = 0

func _ready() -> void:
	fill_label_nodes()

func fill_label_nodes():
	for x in range (0,5):
		label_nodes.push_back(get_node_or_null(flavor_names[x] + "/Count"))

func add_points(points, f):
	flavor_vals_for_adding[f] += points
	
func calc():
	calculating = true
	
func clear_score():
	flavor_value = [0, 0, 0, 0, 0]
	flavor_vals_for_adding = [0, 0, 0, 0, 0]
	for label_node in label_nodes:
		label_node.text = "0"

func _process(delta: float) -> void:
	var total_label_node = get_node_or_null("Total/Count")
	if calculating == true:
			if i < 5 and flavor_vals_for_adding[i] >0:
				total += 1
				add_points(-1, i)
			elif i < 5:
				i += 1
			else:
				calculating = false
			total_label_node.text = str(total)
	for n in 5:
		if flavor_value[n] < flavor_vals_for_adding[n]:

			flavor_value[n] += 1
			label_nodes[n].text = str(flavor_value[n])
