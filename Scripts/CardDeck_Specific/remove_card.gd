extends CanvasLayer

@onready var list_container = $Panel/MarginContainer/ScrollContainer/CardList
var card_preview_scene = preload("res://Scenes/card.tscn")

# Called automatically when the scene loads (for debugging if you want)
func _ready():
	visible = false  # start hidden
	# populate_list()  # don’t auto-populate until menu opens

# Opens the menu
func open():
	visible = true
	get_tree().paused = true
	populate_list()

# Closes the menu
func close():
	visible = false
	get_tree().paused = false

# Populate the scroll list with all cards in the deck
func populate_list():
	refresh_list()  # clear old previews
	for card_data in Deck.deck:
		var preview = create_preview(card_data)
		list_container.add_child(preview)

# Creates a single card preview for the remove menu
func create_preview(card_data : Card) -> Node2D:
	var instance = card_preview_scene.instantiate()

	# Setup visuals
	instance.set_ingredient(card_data, false)
	instance.change_scale(0.6)

	# Disable gameplay clicking logic
	instance.shop = true
	instance.highlighted = false

	# Connect click on this card to remove it from deck
	var area = instance.get_node("Area2D")
	area.input_event.connect(
		func(_viewport, event, _shape):
			if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.pressed:
				remove_card(card_data)
	)

	return instance

# Remove a card from the deck
func remove_card(card_data : Card):
	Deck.deck.erase(card_data)
	populate_list()  # refresh list so it immediately disappears

# Clears all previous card previews
func refresh_list():
	for child in list_container.get_children():
		child.queue_free()
