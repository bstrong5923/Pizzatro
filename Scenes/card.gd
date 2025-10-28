extends Node2D

var ingredient = 0

var play_timer = preload("res://Scenes/card_timer.gd")

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# animation to add the ingredients
		var hand = get_node("/root/Game/hand_animation")
		discard_self()
		hand.go(ingredient)
		play_timer.cooldown()

func set_ingredient(i):
	ingredient = i
	# get the right logo
	var logo = $ingredient_logo
	logo.set_ingredient(i)
	# get the price
	var pricetag = $price_circle
	pricetag.set_price(3)

func discard_self():
	Deck.remove_card(Deck.hand.find(self))
	Deck.fix_hand()
	queue_free()
	
func _on_area_2d_mouse_entered() -> void:
	change_scale(1.1)
 
func _on_area_2d_mouse_exited() -> void:
	change_scale(1)
	
func change_scale(n):
	$price_circle.set_size(n)
	$ingredient_logo.scale = Vector2(5 * n, 5 * n)
	$blank.scale = Vector2(5 * n, 5 * n)
	$Area2D.scale = Vector2(5 * n, 5 * n)
	
