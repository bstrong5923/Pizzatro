extends Node2D

var equipment : Equipment
static var my_equipment : Array

var file = FileAccess.open("res://Assets/common_equipment_list.json", FileAccess.READ)
var raw_text = file.get_as_text()
var data = JSON.parse_string(raw_text)
var common_equip_list = []
static var this_equip
static var index = 0

func _ready() -> void:
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
	this_equip = common_equip_list[randi_range(0, common_equip_list.size() - 1)]
	$shop_equipment.texture = this_equip.texture

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		equipment_bought(this_equip)
		this_equip.index = index
		index += 1

func _on_area_2d_mouse_entered() -> void:
	$equipment_background.texture = load("res://Assets/Sprites/equipment/open_close_pressed.png")
	
func _on_area_2d_mouse_exited() -> void:
	$equipment_background.texture = load("res://Assets/Sprites/equipment/open_close_button.png")
