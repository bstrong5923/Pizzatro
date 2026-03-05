extends Node2D

var flavor_values = [0.0, 0.0, 0.0, 0.0, 0.0]
var flavor_vals_to_add = [0.0, 0.0, 0.0, 0.0, 0.0]
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
<<<<<<< Updated upstream
	print(flavor_values)

=======
	
>>>>>>> Stashed changes

func calc():
	i = 0
	calculating = true
	var totalscore = 0
	for val in flavor_values:
		totalscore += val
	return totalscore

func add_money(i):
	money += i
	get_node("/root/Game/Labels/money/Count").text = str(money)

func clear_score():
	flavor_values = [0, 0, 0, 0, 0]
	flavor_vals_to_add = [0, 0, 0, 0, 0]
	for label_node in label_nodes:
		label_node.text = "0"
	total = 0
	get_node_or_null("Total/Count").text = "0"

func equipment_multiplication(f, amt):
	flavor_values[f] *= amt

func _process(delta: float) -> void:
	var total_label_node = get_node_or_null("Total/Count")
	
	#calculate total
	if calculating == true:
		print(Score.flavor_values)
		done_calculating = false
		if i < 5 and flavor_values[i] >0:
			var min_step = 0.01
			if flavor_values[i] < min_step:
				total += flavor_values[i]
				flavor_values[i] = 0.0
				return
			var minuser = pow(2.0, 35) * min_step #you can change with the pow to mess around with how fast it sells.
			while minuser > flavor_values[i]:
				minuser /= 2.0
			total += minuser
			flavor_values[i] -= minuser
			total = snapped(total, min_step)
			flavor_values[i] = snapped(flavor_values[i], min_step)
		elif i < 5:
			i += 1
		else:
			calculating = false
		total_label_node.text = str(total)
	elif !done_calculating:
		done_calculating = true
		get_node("/root/Game/Round_buttons").next_mode() # when I finish calculating, tell "submit" button to become "shop" button
	
	#add to flavor values 
	if label_nodes:
		for n in 5:
			if flavor_vals_to_add[n] > 0:
				#bigger speedofadd = slower. i think 32 is pretty good
				#😮😘😁☆*: ｡ o≧▽≦)o ｡:*☆*/ω┬┬﹏┬┬)ಥ_ಥ〃￣︶￣)人￣︶￣〃)￣y▽￣)╭ Ohohoho○ ＾皿＾)っ Hehehe…（*＾＾*）`*>﹏<*)′´▽`ʃ♡ƪ)o゜▽゜)o☆p≧w≦q)ƪ˘⌣˘)ʃ~~~///^v^)\\\~~~づ￣ 3￣)づ￣o￣)  z Z（づ￣3￣）づ╭❤️～\@^0^@)/☆⌒*＾゜)vヾ^▽^*)))d=====￣▽￣*)b＜（＾－＾）＞ﾉ◕ヮ◕)ﾉ*:･ﾟ✧￣y▽,￣)╭ o|o) ❤️ ω ❤️)༼ つ ◕_◕ ༽つ⊙_⊙)？⊙ˍ⊙)⊙_⊙_⊙)_⊙)⊙o⊙)●__●)•ˋ _ ˊ•)⚆_⚆＼*)●◡●)❁´◡`❁)╰*°▽°*)╯^///^)£©²°¥•€é→—–←
				var speedofadd = 32
				var step = flavor_vals_to_add[n]/speedofadd
				var min_step = .01
				step= max(step,min_step)
				var adder = min_step
				while adder * 2.0 <= step:
					adder *= 2.0
				flavor_values[n] += adder
				flavor_vals_to_add[n] -= adder
				flavor_values[n] = snapped(flavor_values[n], min_step)
				flavor_vals_to_add[n] = snapped(flavor_vals_to_add[n], min_step)
			if label_nodes[n].text != str(flavor_values[n]):
				label_nodes[n].text = str(flavor_values[n])
