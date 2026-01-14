extends Node2D

var flavor_values = [0, 0, 0, 0, 0]
var flavor_vals_to_add = [0, 0, 0, 0, 0]
var flavor_names = ["Sweet", "Spicy", "Salty", "Sour", "Savory"]
var label_nodes = []
var calculating = false
var done_calculating = true
#variable for calculating total
var i = 0
var total = 0
var label_nodes_created = false

#MONEY
var money = 0

func _ready() -> void:
	fill_label_nodes()

func fill_label_nodes():
	for x in range (0,5):
		var node = get_node_or_null(flavor_names[x] + "/Count")
		if node:
			label_nodes.push_back(node)

func add_points(points, f):
	flavor_vals_to_add[f] += points
	
func calc():
	i = 0
	calculating = true
	var totalscore = 0
	for val in flavor_values:
		totalscore += val
	return totalscore

func add_money(i):
	money += i
	
func clear_score():
	flavor_values = [0, 0, 0, 0, 0]
	flavor_vals_to_add = [0, 0, 0, 0, 0]
	for label_node in label_nodes:
		label_node.text = "0"
	total = 0
	get_node_or_null("Total/Count").text = "0"

func _process(delta: float) -> void:
	var total_label_node = get_node_or_null("Total/Count")
	if calculating == true:
		done_calculating = false
		if i < 5 and flavor_values[i] >0:
			total += 1
			flavor_values[i] -= 1
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
			if flavor_vals_to_add[n] > 0:
				flavor_values[n] += 1
				flavor_vals_to_add[n] -= 1
			if label_nodes[n].text != str(flavor_values[n]):
				label_nodes[n].text = str(flavor_values[n])
