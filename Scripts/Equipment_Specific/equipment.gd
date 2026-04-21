extends Node2D

var equipment : Equipment
static var my_equipment : Array

var file = FileAccess.open("res://Assets/common_equipment_list.json", FileAccess.READ)
var raw_text = file.get_as_text()
var data = JSON.parse_string(raw_text)
static var common_equip_list = []
var this_equip
static var index = 0
var highlighted = false
var shop_mode = false


#description shyte

var tooltip
var tooltiptext

func fill_common_equip_list():
	# fill common_equip_list
	common_equip_list = []
	for e in range(0,data.size()): 
		common_equip_list.push_back(load("res://Assets/equipment/" + data[e] + ".tres"))

func shop_mode_on():
	shop_mode = true

func wipe_equipment():
	my_equipment.clear()

func equipment_bought(e):
	my_equipment.append(e)

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
	return common_equip_list.pop_at(randi_range(0, common_equip_list.size() - 1))

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void: # when clicked
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if shop_mode and Score.money >= this_equip.cost:
			var s = get_tree().current_scene.get_child(13, true)
			this_equip.index = index
			index += 1
			equipment_bought(this_equip)
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
