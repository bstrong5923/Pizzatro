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

func set_description(n):
	get_node("info_sprite/info").text = "[color=000000]" + n + "[/color]"

func _on_mouse_entered() -> void:
	highlighted = true
	tooltip.visible = true
	await get_tree().process_frame
	set_pos_twin()
	print(tooltip.global_position)
	print("MINI HI")


func _on_mouse_exited() -> void:
	set_pos_twin()
	if highlighted:
		highlighted = false
		tooltip.visible = false
