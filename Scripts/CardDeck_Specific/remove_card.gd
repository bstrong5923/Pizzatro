extends CanvasLayer

@onready var list_container = $CenterContainer/Panel/MarginContainer/ScrollContainer/CardList
@onready var trash_background = $CenterContainer/Panel/Sprite2D

var card_preview_scene = load("res://Scenes/card.tscn")
@export var discard_preview_x_range := Vector2(710, 955)
@export var discard_preview_y_range := Vector2(430, 210)
@export var discard_preview_scale := Vector2.ONE

var is_removing := false
var saved_discards : Array[Dictionary] = []


# Called automatically when the scene loads (for debugging if you want)
func _ready():
	$CenterContainer.visible = false

# Opens the menu
func open():
	if Score.money > 25:
		Score.add_money(-25)
		populate_list()
		get_tree().paused = false
		$CenterContainer.visible = true
		list_container.custom_minimum_size = Vector2(0, 800)
		visible = true  # make sure the layer itself is always visible
		show_saved_discard_previews()

# Closes the menu
func close():
	get_tree().paused = false
	$CenterContainer.visible = false

# Populate the scroll list with all cards in the deck
func populate_list():
	refresh_list()  # clear old previews
	for card_data in Deck.deck:
		var preview = create_preview(card_data)
		list_container.add_child(preview) 

# Creates a single card preview for the remove menu
func create_preview(card_data : Card) -> Control:
	var wrapper = Control.new()
	wrapper.custom_minimum_size = Vector2(130, 150)
	wrapper.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var instance = card_preview_scene.instantiate()
	instance.set_ingredient(card_data, false)
	instance.change_scale(0.65)
	instance.hide_circle()
	instance.shop = true
	instance.set_removal()
	instance.highlighted = false

	# Center the Node2D inside the wrapper
	instance.position = wrapper.custom_minimum_size / 2

	wrapper.add_child(instance)

	# Connect click
	var area = instance.get_node("Area2D")
	area.input_event.connect(
		func(_viewport, event, _shape):
			if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !is_removing:
				handle_card_selected(card_data)
	)
	return wrapper

func handle_card_selected(card_data : Card) -> void:
	is_removing = true
	save_discard_preview(card_data)
	remove_card(card_data)
	close()
	is_removing = false

func show_saved_discard_previews() -> void:
	clear_discard_preview()
	for saved_discard in saved_discards:
		var img = Sprite2D.new()
		img.name = "DiscardedCard"
		img.texture = get_preview_texture(saved_discard["card"])
		img.position = saved_discard["position"]
		img.scale = discard_preview_scale
		img.rotation_degrees = randf_range(0, 360)
		img.z_index = 3
		trash_background.add_child(img)
func clear_discard_preview() -> void:
	for old in trash_background.get_children():
		if old.name == "DiscardedCard":
			old.queue_free()

func get_preview_texture(card_data : Card) -> Texture2D:
	return card_data.texture_retro

func save_discard_preview(card_data : Card) -> void:
	saved_discards.append({
		"card": card_data,
		"position": get_random_discard_position()
	})

func reset_saved_discards() -> void:
	saved_discards.clear()
	clear_discard_preview()

func get_random_discard_position() -> Vector2:
	var random_x = randf_range(
		minf(discard_preview_x_range.x, discard_preview_x_range.y),
		maxf(discard_preview_x_range.x, discard_preview_x_range.y)
	)
	var random_y = randf_range(
		minf(discard_preview_y_range.x, discard_preview_y_range.y),
		maxf(discard_preview_y_range.x, discard_preview_y_range.y)
	)
	return Vector2(
		(random_x - trash_background.position.x) / trash_background.scale.x,
		(random_y - trash_background.position.y) / trash_background.scale.y
	)

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

# Clears all previous card previews
func refresh_list():
	for child in list_container.get_children():
		child.queue_free()
