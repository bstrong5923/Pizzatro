extends Node2D

var equipment : Equipment
static var my_equipment : Array

var file = FileAccess.open("res://Assets/card_list.json", FileAccess.READ)
var raw_text = file.get_as_text()
var data = JSON.parse_string(raw_text)

func equipment_bought(e):
	print(e)
	my_equipment.append(e)

func get_my_equipment():
	print("brochacho")
	print(my_equipment.size())
	return my_equipment

func generate_random_equipment():
	pass
	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("yo!")
		var spatula = load("res://Assets/equipment/Spatula.tres")
		equipment_bought(spatula)
