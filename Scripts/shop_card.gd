extends Node2D

var ingredient : Card
var price
var play_timer = preload("res://Scripts/card_timer.gd")
@onready
var scor = get_node("/root/Game/Labels/Score")
func _ready() -> void:
	get_viewport().set_physics_object_picking_sort(true)
	get_viewport().set_physics_object_picking_first_only(true)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void: # on click
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and play_timer.can_play_a_card:
		play_timer.cooldown() # wait for animation to finish before you can click another
		discard_self() # discard this one
		### call to card function to subtract money



func set_ingredient(i):
	ingredient = i
	price = ingredient.price
			
	# get the right logo
	var logo = $ingredient_logo
	logo.set_ingredient(i)
	
	# get the price
	var pricetag = $price_circle
	pricetag.set_price(price)
	
func get_ingredient():
	return ingredient
	
func discard_self():
	Shop.shop_hand.erase(self)
	# Now fix the layout WITHOUT this card in the list
	Shop.fix_hand()

	# Now it is safe to free this node
	queue_free()
	print("discarding")
	# Add ingredient to deck AFTER it is freed
	Deck.add_card_from_shop(ingredient)


	
func _on_area_2d_mouse_entered() -> void:
	change_scale(1.05)
 
func _on_area_2d_mouse_exited() -> void:
		change_scale(1)
	
func change_scale(n):
	$price_circle.set_size(n)
	$ingredient_logo.scale = Vector2(5 * n, 5 * n)
	$blank.scale = Vector2(5 * n, 5 * n)
	$Area2D.scale = Vector2(5 * n, 5 * n)
