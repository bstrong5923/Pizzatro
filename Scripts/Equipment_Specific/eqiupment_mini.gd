extends Area2D

@onready var tooltip = $info_sprite 
@onready var tooltiptext = $info_sprite/info
var highlighted = false

func _ready() -> void:
	set_pos_twin()

#this just sets stuff for description dont even fuck with me twin✌️
func set_pos_twin():
	tooltip.set_global_position(Vector2(-25,-315),false)
	tooltip.size= Vector2(215,tooltiptext.size.y)


func set_text(textu):
	$equipment_mini.texture = textu

func change_scale(n):
	$equipment_mini.scale = Vector2(n, n)
	


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
