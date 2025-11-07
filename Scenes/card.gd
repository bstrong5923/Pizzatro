extends Node2D

var ingredient = 0

var play_timer = preload("res://Scenes/card_timer.gd")
func _ready() -> void:
	get_viewport().set_physics_object_picking_sort(true)
	get_viewport().set_physics_object_picking_first_only(true)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void: # on click
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and play_timer.can_play_a_card:
		var hand = get_node("/root/Game/hand_animation") # animation to add the ingredients
		hand.go(ingredient)
		play_timer.cooldown() # wait for animation to finish before you can click another
		discard_self() # discard this one
		Balance.change_balance(-3)
		var checker = get_node("card_function") # do the function
		checker.set_card(ingredient)
		checker.check_function()

func set_ingredient(i):
	ingredient = i
	# get the right logo
	var logo = $ingredient_logo
	logo.set_ingredient(i)
	# get the price
	var pricetag = $price_circle
	pricetag.set_price(3)
	
func get_ingredient():
	return ingredient
	
func discard_self():
	Deck.remove_card(Deck.hand.find(self))
	Deck.fix_hand()
	queue_free()
	
func _on_area_2d_mouse_entered() -> void:
	change_scale(1.05)
 
func _on_area_2d_mouse_exited() -> void:
		change_scale(1)
	
func change_scale(n):
	$price_circle.set_size(n)
	$ingredient_logo.scale = Vector2(5 * n, 5 * n)
	$blank.scale = Vector2(5 * n, 5 * n)
	$Area2D.scale = Vector2(5 * n, 5 * n)
	
