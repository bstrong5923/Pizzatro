extends Sprite2D

var equipment = load("res://Scenes/equipment.tscn")

func sort_equipments():
	position = Vector2(0,0)
	for e in Equip.my_equipment:
		var equip_instance = equipment.instantiate()
		equip_instance.set_equipment(e)
		get_node("/root/Game/drawer").add_child(equip_instance)
		equip_instance.position = Vector2(0,0)
		equip_instance.z_index = 1
