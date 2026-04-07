extends Sprite2D

const REMOVE_BUTTON_PRESSED_TEXTURE := preload("res://Assets/Sprites/game scene items/remove_button_pressed.png")
const REMOVE_BUTTON_TEXTURE := preload("res://Assets/Sprites/game scene items/remove_button.png")

func _ready():
	var pricetag = get_node("price_circle")
	pricetag.set_price(25, true)
	pricetag.equipment_set_size(1)

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed):
		texture = REMOVE_BUTTON_PRESSED_TEXTURE
		await get_tree().create_timer(0.5).timeout
		texture = REMOVE_BUTTON_TEXTURE
		get_node("/root/Game/RemoveCardMenu").open()
