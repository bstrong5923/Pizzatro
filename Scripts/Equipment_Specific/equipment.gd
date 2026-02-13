extends Node2D

var equipment : Equipment
static var my_equipment : Array

var file = FileAccess.open("res://Assets/common_equipment_list.json", FileAccess.READ)
var raw_text = file.get_as_text()
var data = JSON.parse_string(raw_text)
var common_equip_list = []
static var this_equip
var index = 0
var highlighted = false

#description shyte

@onready var tooltip = $info_sprite 
@onready var tooltiptext = $info_sprite/info
var tooltippos = 0
func _ready():
	# fill common_equip_list
	for e in range(0,data.size()): 
		common_equip_list.push_back(load("res://Assets/equipment/" + data[e] + ".tres"))


func equipment_bought(e):
	print(e)
	print("index is: " + str(e.index))
	my_equipment.append(e)

func get_my_equipment():
	return my_equipment

func generate_random_equipment():
	this_equip = common_equip_list[common_equip_list.size() - 1] # randi_range(0, common_equip_list.size() - 1)
	$shop_equipment.texture = this_equip.texture
	
	#get position for description
	tooltippos = tooltip.position
	#sets text to description
	tooltiptext.text = this_equip.description
	

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if (Score.money >= this_equip.cost):
			this_equip.index = index
			index += 1
			equipment_bought(this_equip)
			if this_equip.bought:
				this_equip.on_bought()
			Score.add_money(this_equip.cost * -1)

func _on_area_2d_mouse_entered() -> void:
	highlighted = true
	tooltip.visible = true
	await get_tree().process_frame
	tooltip.position = tooltippos + Vector2(0, -8)
	print(tooltip.position)

func _on_area_2d_mouse_exited() -> void:
	if highlighted:
		highlighted = false
		tooltip.visible = false
		print("bye")

func set_text(textu):
	$equipment_mini.texture = textu

func change_scale(n):
	$equipment_mini.scale = Vector2(n, n)
