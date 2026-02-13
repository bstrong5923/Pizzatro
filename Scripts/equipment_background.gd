extends Node2D
var pressed = false
var Equipm = preload("res://Scenes/equipment.tscn")
@onready
var minis_container = $minis_container
#func _on_area_2d_mouse_entered() -> void:
	#$equipment_button.texture = load("res://Assets/Sprites/equipment/open_close_pressed.png")
	#
#func _on_area_2d_mouse_exited() -> void:
	#$equipment_button.texture = load("res://Assets/Sprites/equipment/open_close_button.png")


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if (pressed == true):
			var target_y = 0
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position:y", target_y , .2)
			pressed = false
			
		elif (pressed == false):
			var target_y = 67
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position:y", target_y , .2)
			generate_equipment_minis()
			pressed = true
			
var d
func generate_equipment_minis():
	var my_equipment
	my_equipment = Equip.get_my_equipment()
	if (d == 1):
		for child in minis_container.get_children():
			child.queue_free()
		
	for x in range(my_equipment.size()):
		var e = Equipm.instantiate()
		e.set_text(my_equipment[x].texture)
		var xpos
		var ypos
		## formatting if there is less than 9
		if(my_equipment.size() < 9):	
			if (x < 3):
				xpos = 54
			elif (x < 6):
				xpos = 74
			else:
				xpos = 94
			ypos = -120 + ((x % 3) * 20)
			e.position = Vector2(xpos, ypos)
			e.change_scale(.4)
			minis_container.add_child(e)
			var d = 1
		else:
			if (x < 5):
				xpos = 54
			elif (x < 10):
				xpos = 74
			else:
				xpos = 94
			ypos = -120 + ((x % 5) * 10)
			e.position = Vector2(xpos, ypos)
			e.change_scale(.2)
			
			minis_container.add_child(e)
			var d = 1
		
