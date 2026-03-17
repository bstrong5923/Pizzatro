extends Node2D

var flavor_values = [0.0, 0.0, 0.0, 0.0, 0.0]
var flavor_vals_to_add = [0.0, 0.0, 0.0, 0.0, 0.0]
var flavor_names = ["Sweet", "Spicy", "Salty", "Sour", "Savory"]
var label_nodes = []
var calculating = false
var done_calculating = true
#variable for calculating total
var i = 0.0
var total = 0.0
var label_nodes_created = false
var steps = [0.0, 0.0, 0.0, 0.0, 0.0]
var totalstep = 0
var add_up_time = 35 # higher means slower
var equip_list
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
	var step = int(flavor_vals_to_add[f] / add_up_time)
	if step == 0:
		step = 1
	steps[f] = step

func calc():
	i = 0
	calculating = true
	print("flavor_values 1: " + str(flavor_values))
	# check equipments
	equip_list = Equip.get_my_equipment()
	for eq in equip_list:
		if eq.submit:
			await eq.on_submit(self)
	print("thing 2")
	# combine flavors
	var totalscore = 0
	for val in flavor_values:
		totalscore += val
	totalstep = int(round(totalscore / add_up_time))
	if totalstep == 0:
		totalstep = 1
	return totalscore

func add_money(i):
	money += i
	get_node("/root/Game/Labels/money/Count").text = Lib.num_to_string(money)

func clear_score():
	flavor_values = [0.0,0.0,0.0,0.0,0.0]
	flavor_vals_to_add = [0.0,0.0,0.0,0.0,0.0]
	for label_node in label_nodes:
		label_node.text = "0"
	total = 0.0
	get_node_or_null("Total/Count").text = "0"

func _process(delta: float) -> void:
	var total_label_node = get_node_or_null("Total/Count")
	
	#calculate total
	if calculating == true:
		done_calculating = false
		if i < 5 and flavor_values[i] >0.0:
			flavor_values[i] -= totalstep
			total += totalstep
			if flavor_values[i] <= 0.0:
				total += flavor_values[i]
				flavor_values[i] = 0.0
				#i += 1
		elif i < 5:
			i += 1
		else:
			calculating = false
		total_label_node.text = Lib.num_to_string(total)
	elif !done_calculating:
		done_calculating = true
		get_node("/root/Game/Round_buttons").next_mode() # when I finish calculating, tell "submit" button to become "shop" button
	
	#add to flavor values 
	if label_nodes:
		for n in 5:
			if flavor_vals_to_add[n] > 0.0:
				flavor_values[n] += steps[n]
				flavor_vals_to_add[n] -= steps[n]
				
				if flavor_vals_to_add[n] < 0.0: # if we take away too much and flavor_vals_to_add goes negative, we fix it here
					flavor_values[n] += flavor_vals_to_add[n]
					flavor_vals_to_add[n] = 0.0

			label_nodes[n].text = Lib.num_to_string(flavor_values[n])
