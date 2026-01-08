extends Node2D

var ingredient : Card
var price
var play_timer = preload("res://Scripts/card_timer.gd")
@onready
var scor = get_node("/root/Game/Labels/Score")
var goingtodeck = preload("res://Scripts/shop_card_anim.gd")
var shop = false
<<<<<<< Updated upstream
var highlighted = false

=======
@onready var cardsprite = $blank
@onready var ingredientsprite = $ingredient_logo
@onready var iconsprite = $icon
@onready var pricecirclesprite = $price_circle
>>>>>>> Stashed changes
func _ready() -> void:
	get_viewport().set_physics_object_picking_sort(true)
	get_viewport().set_physics_object_picking_first_only(true)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, _shape_idx: int) -> void: # on click
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and play_timer.can_play_a_card:
		if shop == false and get_node("/root/Game").is_playing() and get_node("/root/Game/Labels/Energy").get_energy() >= ingredient.price:
			var hand = get_node("/root/Game/hand_animation") # animation to add the ingredients
			hand.go(ingredient)
			play_timer.cooldown() # wait for animation to finish before you can click another
			discard_self() # discard this one
			### call to card function to subtract money
			get_node_or_null("/root/Game/Labels/Energy").change_energy(-price)
			var checker = get_node("card_function") # do the function
			checker.set_card(ingredient)
			checker.run_card_function()
		else: 
			play_timer.cooldown() # wait for animation to finish before you can click another
			discard_self() # discard this one


func set_ingredient(i, t):
	ingredient = i
	price = ingredient.price
			
	# get the right logo
	var logo = $ingredient_logo
	logo.set_ingredient(i)
	$icon.set_ingredient(i)
	
	# get the price
	var pricetag = $price_circle
	pricetag.set_price(price, !t)
	shop = t
	
func get_ingredient():
	return ingredient
	
func discard_self():
	if shop == false:
		Deck.remove_card(Deck.hand.find(self))
		Deck.fix_hand()
		queue_free()
	else:
		Deck.shop_hand.erase(self)
		# Now fix the layout WITHOUT this card in the list
		Deck.fix_shop_hand()
		goingtodeck.cooldown()
		# Now it is safe to free this node

		#do this little animation
		var target_x = 98 *5
		var target_y = 39 * 5
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(target_x,target_y), .76)
		await tween.finished
		queue_free()
		# Add ingredient to deck AFTER it is freed
		Deck.add_card_from_shop(ingredient)
	
func _on_area_2d_mouse_entered():
<<<<<<< Updated upstream
	if get_node("/root/Game").is_playing() or shop == true:
		position.y -= 35
		highlighted = true
 
func _on_area_2d_mouse_exited():
	if highlighted:
		position.y += 35
		highlighted = false
=======
		cardsprite.position.y -= 35
		ingredientsprite.position.y -= 35
		iconsprite.position.y -= 35
		pricecirclesprite.position.y -= 35
 
func _on_area_2d_mouse_exited():
		cardsprite.position.y += 35
		ingredientsprite.position.y += 35
		iconsprite.position.y += 35
		pricecirclesprite.position.y += 35
>>>>>>> Stashed changes
	
func change_scale(n):
	$price_circle.set_size(n, true)
	if shop == true:
		$price_circle.change_pos(0,120)
	$ingredient_logo.scale = Vector2(5 * n, 5 * n)
	$blank.scale = Vector2(5 * n, 5 * n)
	$Area2D.scale = Vector2(5 * n, 5 * n)
	$icon.change_scale(n)
	
