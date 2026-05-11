extends CanvasLayer

@onready var list_container = $CenterContainer/Panel/MarginContainer/ScrollContainer/CardList
@onready var background_sprite = $CenterContainer/Panel/Sprite2D
@onready var trash_background = background_sprite
@onready var title_label = $CenterContainer/Panel/Label
@onready var panel = $CenterContainer/Panel
@onready var margin_container = $CenterContainer/Panel/MarginContainer
@onready var close_button = $CenterContainer/Panel/CloseButton

var card_preview_scene = load("res://Scenes/card.tscn")
@export var remove_mode_background: Texture2D
@export var deck_view_background: Texture2D
@export var discard_preview_x_range := Vector2(710, 955)
@export var discard_preview_y_range := Vector2(430, 210)
@export var discard_preview_scale := Vector2(4,4)
@export var discard_preview_placement_tries := 6
@export var discard_preview_avoid_radius := 18.0

var is_removing := false
var saved_discards : Array[Dictionary] = []
var current_mode := "remove"

const REMOVE_TITLE := "Select a Card to Remove"
const DECK_VIEW_TITLE := "Cards Left Outside Your Hand"
const REMOVE_LAYOUT_OFFSETS := {
	"left": -490.0,
	"top": -254.0,
	"right": -65.0,
	"bottom": 226.0,
	"columns": 3,
	"list_height": 800.0
}
const DECK_VIEW_LAYOUT_OFFSETS := {
	"left": -505.0,
	"top": -254.0,
	"right": 505.0,
	"bottom": 226.0,
	"columns": 7,
	"list_height": 0.0
}


# Called automatically when the scene loads (for debugging if you want)
func _ready():
	if remove_mode_background == null:
		remove_mode_background = background_sprite.texture
	if deck_view_background == null:
		deck_view_background = remove_mode_background
	$CenterContainer.visible = false
	visible = false

# Opens the menu
func open():
	open_remove_menu()

func open_remove_menu():
	if Score.money > 10:
		Score.add_money(-10)
		current_mode = "remove"
		apply_background()
		apply_layout()
		populate_list()
		get_tree().paused = false
		$CenterContainer.visible = true
		visible = true  # make sure the layer itself is always visible
		show_saved_discard_previews()

func open_deck_view():
	current_mode = "deck_view"
	apply_background()
	apply_layout()
	populate_list()
	get_tree().paused = false
	$CenterContainer.visible = true
	visible = true
	show_saved_discard_previews()

# Closes the menu
func close():
	get_tree().paused = false
	$CenterContainer.visible = false
	visible = false

func is_open() -> bool:
	return $CenterContainer.visible

func is_deck_view_open() -> bool:
	return is_open() and current_mode == "deck_view"

# Populate the scroll list with all cards in the deck
func populate_list():
	refresh_list()  # clear old previews
	for card_data in get_cards_to_display():
		var preview = create_preview(card_data)
		list_container.add_child(preview) 

# Creates a single card preview for the remove menu
func create_preview(card_data : Card) -> Control:
	var wrapper = Control.new()
	wrapper.custom_minimum_size = Vector2(130, 150)
	wrapper.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var instance = card_preview_scene.instantiate()
	instance.set_ingredient(card_data, true)
	instance.change_scale(0.65)
	instance.hide_circle()
	instance.shop = true
	instance.set_preview_only()
	if current_mode == "remove":
		instance.set_removal()
	instance.highlighted = false

	# Center the Node2D inside the wrapper
	instance.position = wrapper.custom_minimum_size / 2

	wrapper.add_child(instance)

	# Connect click
	if current_mode == "remove":
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
		img.scale = get_discard_preview_scale()
		img.rotation_degrees = randf_range(0, 360)
		img.z_index = 3
		trash_background.add_child(img)

func clear_discard_preview() -> void:
	for old in trash_background.get_children():
		if old.name == "DiscardedCard":
			old.queue_free()

func get_preview_texture(card_data : Card) -> Texture2D:
	if Deck.texture_mode == "default":
		return card_data.texture
	return card_data.texture_retro

func save_discard_preview(card_data : Card) -> void:
	saved_discards.append({
		"card": card_data,
		"position": get_smart_discard_position()
	})

func reset_saved_discards() -> void:
	saved_discards.clear()
	clear_discard_preview()

func get_discard_preview_scale() -> Vector2:
	return Vector2(
		discard_preview_scale.x / trash_background.scale.x,
		discard_preview_scale.y / trash_background.scale.y
	)

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

func get_smart_discard_position() -> Vector2:
	var best_position = get_random_discard_position()
	var best_score = score_discard_position(best_position)

	for _i in range(discard_preview_placement_tries - 1):
		var candidate = get_random_discard_position()
		var score = score_discard_position(candidate)
		if score > best_score:
			best_score = score
			best_position = candidate

	return best_position

func score_discard_position(candidate : Vector2) -> float:
	if saved_discards.is_empty():
		return discard_preview_avoid_radius + randf()

	var closest_distance = INF
	for saved_discard in saved_discards:
		var distance_to_other = candidate.distance_to(saved_discard["position"])
		closest_distance = minf(closest_distance, distance_to_other)

	if closest_distance >= discard_preview_avoid_radius:
		return discard_preview_avoid_radius + randf()

	return closest_distance + randf()

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

func get_cards_to_display() -> Array[Card]:
	if current_mode == "deck_view":
		return Deck.get_cards_not_in_hand()
	return Deck.deck

func apply_layout() -> void:
	var layout = REMOVE_LAYOUT_OFFSETS
	if current_mode == "deck_view":
		layout = DECK_VIEW_LAYOUT_OFFSETS

	margin_container.offset_left = layout["left"]
	margin_container.offset_top = layout["top"]
	margin_container.offset_right = layout["right"]
	margin_container.offset_bottom = layout["bottom"]
	list_container.columns = layout["columns"]
	list_container.custom_minimum_size = Vector2(0, layout["list_height"])

	if current_mode == "deck_view":
		var cards_to_display = get_cards_to_display().size()
		title_label.text = DECK_VIEW_TITLE + " (" + str(cards_to_display) + ")"
		close_button.visible = true
	else:
		title_label.text = REMOVE_TITLE
		close_button.visible = false

func apply_background() -> void:
	if current_mode == "deck_view":
		background_sprite.texture = deck_view_background
	else:
		background_sprite.texture = remove_mode_background

func _unhandled_input(event: InputEvent) -> void:
	if !is_open():
		return
	if current_mode == "deck_view" and event.is_action_pressed("ui_cancel"):
		close()

func _on_close_button_pressed() -> void:
	close()
