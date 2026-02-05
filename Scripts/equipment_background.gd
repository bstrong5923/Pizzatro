extends Node2D
var pressed = false
var Equipm = preload("res://Scenes/equipment.tscn")
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
			

func generate_equipment_minis():
		var my_equipment
		print("test?")
		my_equipment = Equip.get_my_equipment() 
		for x in range(my_equipment.size()):
			var e = Equipm.instantiate()
			e.set_text(my_equipment[x].texture)
			var xpos
			var ypos
			if (x < 5):
				xpos = 54
			elif (x < 10):
				xpos = 74
			else:
				xpos = 94
			ypos = -120 + ((x % 5) * 20)
			e.position = Vector2(xpos, ypos)
			e.change_scale(.4)
			add_child(e)
			
