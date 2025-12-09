extends Sprite2D

var deck = preload("res://Scenes/deck.tscn")
var numba = []

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		gen_card()
		print("gerb")
		
func gen_card():
	
		
	Deck.add_card(numba)
	
	
