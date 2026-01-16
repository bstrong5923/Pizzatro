extends Node2D

var flavor_value = [0, 0, 0, 0, 0]
var flavor_vals_for_adding = [0, 0, 0, 0, 0]
var flavor_names = ["Sweet", "Spicy", "Salty", "Sour", "Savory"]
var label_nodes = []
var calculating = false
var done_calculating = true
#variable for calculating total
var i = 0
var total = 0
var label_nodes_created = false

func _ready() -> void:
	fill_label_nodes()

func fill_label_nodes():
	for x in range (0,5):
		var node = get_node_or_null(flavor_names[x] + "/Count")
		if node:
			label_nodes.push_back(node)

func add_points(points, f):
	flavor_vals_for_adding[f] += points
	
func calc():
	i = 0
	calculating = true
	
func clear_score():
	flavor_value = [0, 0, 0, 0, 0]
	flavor_vals_for_adding = [0, 0, 0, 0, 0]
	for label_node in label_nodes:
		label_node.text = "0"
	total = 0
	get_node_or_null("Total/Count").text = "0"

func equipment_multiplication(f, amt):
	flavor_value[f] *= amt

func _process(delta: float) -> void:
	var total_label_node = get_node_or_null("Total/Count")
	if calculating == true:
		done_calculating = false
		if i < 5 and flavor_value[i] >0:
			total += 1
			flavor_value[i] -= 1
		elif i < 5:
			i += 1
		else:
			calculating = false
		total_label_node.text = str(total)
	elif !done_calculating:
		done_calculating = true
		get_node("/root/Game/Round_buttons").next_mode() # when I finish calculating, tell "submit" button to become "shop" button
	if label_nodes:
		for n in 5:
			if flavor_value[n] < flavor_vals_for_adding[n]:
				flavor_value[n] += 1
				flavor_vals_for_adding[n] -= 1
			if label_nodes[n].text != str(flavor_value[n]):
				label_nodes[n].text = str(flavor_value[n])
