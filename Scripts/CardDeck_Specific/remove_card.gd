extends CanvasLayer

@onready var list_container = $CenterContainer/Panel/MarginContainer/ScrollContainer/CardList
var card_preview_scene = preload("res://Scenes/card.tscn")


# Called automatically when the scene loads (for debugging if you want)
func _ready():
	visible = false  # start hidden
	# populate_list()  # don’t auto-populate until menu opens

# Opens the menu
func open():
	$ColorRect.modulate.a = 0
	#$CenterContainer/Panel.position = get_viewport().get_visible_rect().size / 2
	populate_list()
	get_tree().paused = true
	print("OPEN CALLED")
	visible = true
	list_container.custom_minimum_size = Vector2(0, 800)

# Closes the menu
func close():
	get_tree().paused = false
	visible = false

# Populate the scroll list with all cards in the deck
func populate_list():
	refresh_list()  # clear old previews
	for card_data in Deck.deck:
		var preview = create_preview(card_data)
		list_container.add_child(preview)

# Creates a single card preview for the remove menu
func create_preview(card_data : Card) -> Control:
	var wrapper = Control.new()
	wrapper.custom_minimum_size = Vector2(130, 100)
	wrapper.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var instance = card_preview_scene.instantiate()
	
	instance.set_ingredient(card_data, false)
	instance.change_scale(0.5)
	instance.shop = true
	instance.highlighted = false

	# Center the Node2D inside the wrapper
	instance.position = wrapper.custom_minimum_size / 2

	wrapper.add_child(instance)

	# Connect click
	var area = instance.get_node("Area2D")
	area.input_event.connect(
		func(_viewport, event, _shape):
			if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.pressed:
				remove_card(card_data)
	)

	return wrapper

# Remove a card from the deck
func remove_card(card_data : Card):
	Deck.deck.erase(card_data)
	# Create Animation Here
	#var target_x = 98 * 5
	#var target_y = 39 * 5
	#var tween = get_tree().create_tween()
	#tween.tween_property(card_data, "position", Vector2(target_x,target_y), .76)
	#await tween.finished
	populate_list()  # refresh list so it immediately disappears
	close()
# Clears all previous card previews
func refresh_list():
	for child in list_container.get_children():
		child.queue_free()
