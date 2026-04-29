extends Node2D

const maxequip := 9

var equipment : Equipment
static var my_equipment : Array


static var common_equip_list = []
static var rare_equip_list = []
static var exotic_equip_list = []
var this_equip
static var index = 0
var highlighted = false
var shop_mode = false


#description shyte

var tooltip
var tooltiptext

var level

func fill_equip_lists():
	# loops through all equip lists and fills them
	var types = ["common", "rare", "exotic"]
	var raw_text
	var data
	for type in types:
		var file = FileAccess.open("res://Assets/" + type + "_equipment_list.json", FileAccess.READ)
		raw_text = file.get_as_text()
		data = JSON.parse_string(raw_text)
		for e in range(0,data.size()):
			if type == "common": 
				common_equip_list.push_back(load("res://Assets/equipment/" + data[e] + ".tres"))
			if type == "rare":
				rare_equip_list.push_back(load("res://Assets/equipment/" + data[e] + ".tres"))
			if type == "exotic":
				exotic_equip_list.push_back(load("res://Assets/equipment/" + data[e] + ".tres"))

func shop_mode_on():
	shop_mode = true

func wipe_equipment():
	my_equipment.clear()

func can_buy_more_equipment() -> bool:
	return my_equipment.size() < maxequip

func get_equipment_limit() -> int:
	return maxequip

func equipment_bought(e) -> bool:
	print("WORKING")
	if !can_buy_more_equipment():
		return false
	var runner = false
	for x in my_equipment:
		if x.name == e.name:
			x.upgrade()
			runner = true
	if (!runner):
		my_equipment.append(e)
	return true

func get_my_equipment():
	return my_equipment

func set_equipment(equip):
	this_equip = equip
	tooltip = $info_sprite 
	tooltiptext = $info_sprite/info
	$shop_equipment.texture = this_equip.texture
	set_description_and_tooltip()
	
func set_description_and_tooltip():
	#sets text to description
	var text = this_equip.description
	#highlight keywords
	text = text.replacen("Sweet", "[color=d900d9]Sweet[/color]")
	text = text.replacen("Spicy", "[color=c85c00]Spicy[/color]")
	text = text.replacen("Salty", "[color=fae100]Salty[/color]")
	text = text.replacen("Sour", "[color=1ac200]Sour[/color]")
	text = text.replacen("Savory", "[color=0006a6]Savory[/color]")
	text = text.replacen("Energy", "[color=ffd900]Energy[/color]")
	tooltiptext.text = text 
	change_pricetag_scale(0.2)

func generate_random_equipment():
	var rarity = randi_range(0, 100)
	if (rarity > 95):
		return exotic_equip_list[randi_range(0, exotic_equip_list.size() - 1)]
	elif (rarity > 77):
		return rare_equip_list[randi_range(0, rare_equip_list.size() - 1)]
	else:
		return common_equip_list[randi_range(0, common_equip_list.size() - 1)]

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void: # when clicked
	if get_node("/root/Game/RemoveCardMenu").is_open():
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if shop_mode and Score.money >= this_equip.cost and can_buy_more_equipment():
			var s = get_tree().current_scene.get_child(13, true)
			this_equip.index = index
			index += 1
			if !equipment_bought(this_equip):
				return
			if this_equip.bought and (this_equip.name == "Incognito"):
				await this_equip.on_bought(s) #call pack scene which is impossible for some reason bruh i wanna kms
			elif this_equip.bought:
				await this_equip.on_bought("hi mom")
			Score.add_money(this_equip.cost * -1)
			queue_free()

func _on_area_2d_mouse_entered() -> void:
	highlighted = true
	tooltip.visible = true
	await get_tree().process_frame
	tooltip.position = Vector2(121.0,0)

func _on_area_2d_mouse_exited() -> void:
	if highlighted:
		highlighted = false
		tooltip.visible = false

func set_text(textu):
	$equipment_mini.texture = textu

func change_scale(n):
	$equipment_mini.scale = Vector2(n, n)
	
func change_pricetag_scale(n):
	var pricetag = $price_circle
	pricetag.set_price(this_equip.cost,false)
	$price_circle.scale = Vector2(n,n)
	$price_circle.position = Vector2(159,31) # i dont fucking know man
