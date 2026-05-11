extends Area2D

@onready var tooltip = $info_sprite 
@onready var tooltiptext = $info_sprite/info
var highlighted = false
var equipment_data : Equipment
var base_scale := Vector2.ONE
var reaction_tween : Tween

func _ready() -> void:
	add_to_group("equipment_mini")
	base_scale = get_equipment_sprite().scale
	set_pos_twin()

func get_equipment_sprite() -> Sprite2D:
	return get_node("equipment_mini") as Sprite2D

#this just sets stuff for description dont even fuck with me twin✌️
func set_pos_twin():
	tooltip.set_global_position(Vector2(-25,-315),false)
	tooltip.size= Vector2(215,tooltiptext.size.y)


func set_text(textu):
	get_equipment_sprite().texture = textu

func change_scale(n):
	base_scale = Vector2(n, n)
	get_equipment_sprite().scale = base_scale

func set_equipment_data(equipment: Equipment):
	equipment_data = equipment

func react_to_equipment(equipment: Equipment, effect_name := "spin") -> void:
	if not matches_equipment(equipment):
		return
	play_trigger_effect(effect_name)

func matches_equipment(equipment: Equipment) -> bool:
	if equipment_data == null or equipment == null:
		return false
	if equipment_data == equipment:
		return true
	return equipment_data.name == equipment.name and equipment_data.index == equipment.index

func play_trigger_effect(effect_name := "spin") -> void:
	match effect_name:
		"spin":
			play_spin_effect()
		_:
			play_spin_effect()

func play_spin_effect() -> void:
	var equipment_sprite = get_equipment_sprite()
	if reaction_tween:
		reaction_tween.kill()

	equipment_sprite.rotation_degrees = 0.0
	equipment_sprite.scale = base_scale
	for _i in range(25):
		spawn_flake(Color.RED)

	reaction_tween = create_tween()
	reaction_tween.tween_property(equipment_sprite, "rotation_degrees", 360.0, 0.35).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	reaction_tween.parallel().tween_property(equipment_sprite, "scale", base_scale * 1.2, 0.14).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	reaction_tween.tween_property(equipment_sprite, "scale", base_scale, 0.18).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	reaction_tween.finished.connect(_on_reaction_finished)

func _on_reaction_finished() -> void:
	var equipment_sprite = get_equipment_sprite()
	equipment_sprite.rotation_degrees = 0.0
	equipment_sprite.scale = base_scale
	reaction_tween = null
	


func set_description(descrip, name):
	var label = get_node("info_sprite/info")
	var display_name = name
	if name is Equipment:
		display_name = name.get_display_name()
	var text = "[b]" + display_name + "[/b]" + "\n"
	text += descrip
	
	text = text.replacen("Sweet", "[color=d900d9]Sweet[/color] ")
	text = text.replacen("Spicy", "[color=c85c00]Spicy[/color] ")
	text = text.replacen("Salty", "[color=fae100]Salty[/color] ")
	text = text.replacen("Sour", "[color=1ac200]Sour[/color] ")
	text = text.replacen("Savory", "[color=0006a6]Savory[/color] ")
	text = text.replacen("Energy", "[color=ffd900]Energy[/color] ")
	label.text = text
	#spicy c85c00 salty fae100 sour 1ac200 savory 0006a6 energy ffd900 sweet d900d9

func spawn_flake(color: Color = Color.WHITE) -> void:
	var particle = ColorRect.new()
	particle.size = Vector2(3, 3)  # pixel size, tweak as you like
	particle.color = color
	particle.position = global_position  # spawns at this object's position
	get_tree().root.add_child(particle)

	var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	var speed = randf_range(40, 120)
	var lifetime = randf_range(0.3, 0.8)

	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(particle, "position", particle.position + direction * speed * lifetime, lifetime)
	tween.tween_property(particle, "modulate:a", 0.0, lifetime)  # fade out
	tween.chain().tween_callback(particle.queue_free)

func _on_mouse_entered() -> void:
	highlighted = true
	tooltip.visible = true
	await get_tree().process_frame
	set_pos_twin()
	for i in range(100):
		spawn_flake(Color.RED)


func _on_mouse_exited() -> void:
	set_pos_twin()
	if highlighted:
		highlighted = false
		tooltip.visible = false
