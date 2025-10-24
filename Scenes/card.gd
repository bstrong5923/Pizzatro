extends Sprite2D

var ingredient = 0

var play_timer = preload("res://Scenes/card_timer.gd")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and play_timer.can_play_a_card: # on click
		if is_pixel_opaque(get_local_mouse_position()): # was I the thing that was clicked?
			# animation to add the ingredients
			var hand = get_node("/root/Game/hand_animation")
			discard_self()
			hand.go(ingredient)
			play_timer.cooldown()

func set_ingredient(i):
	ingredient = i
	var logo = $ingredient_logo
	logo.set_ingredient(i)

func discard_self():
	Deck.remove_card(Deck.hand.find(self))
	Deck.fix_hand()
	queue_free()
	
func on_hovered_card():
	print("hi")
	
func off_hovered_card():
	print("bye")
	
func _on_area_2d_mouse_entered() -> void:
	self.scale = Vector2(1.05,1.05)
	pass # Replace with function body.
 

func _on_area_2d_mouse_exited() -> void:
	self.scale = Vector2(1,1)
	pass # Replace with function body.
