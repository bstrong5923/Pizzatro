extends Sprite2D

var equipment_mini = preload("res://Scenes/eqiupment_mini.tscn")
const COLUMN_X := [-18.0, 0.0, 18.0]
const START_Y := -18.0
const ROW_SPACING := 18.0

func sort_equipments():
	for child in get_children():
		child.queue_free()

	for i in range(Equip.my_equipment.size()):
		var equipment_data = Equip.my_equipment[i]
		var equip_instance = equipment_mini.instantiate()
		var column_index = mini(int(i / 3), COLUMN_X.size() - 1)
		equip_instance.set_text(equipment_data.texture)
		equip_instance.set_description(equipment_data.description, equipment_data)
		equip_instance.change_scale(0.5)
		equip_instance.position = Vector2(
			COLUMN_X[column_index],
			START_Y + ((i % 3) * ROW_SPACING)
		)
		equip_instance.z_index = 10
		add_child(equip_instance)
