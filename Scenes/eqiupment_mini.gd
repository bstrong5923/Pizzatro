extends Area2D

@onready var tooltip = $info_sprite 
@onready var tooltiptext = $info_sprite/info
var highlighted = false

func _ready() -> void:
	tooltip.set_global_position(Vector2(-200,-50),false) 


func set_text(textu):
	$equipment_mini.texture = textu

func change_scale(n):
	$equipment_mini.scale = Vector2(n, n)

func set_description(n):
	get_node("info_sprite/info").text = n

func _on_mouse_entered() -> void:
	highlighted = true
	tooltip.visible = true
	await get_tree().process_frame
	tooltip.set_global_position(Vector2(-40,-10),false) 
	print(tooltip.global_position)
	print("MINI HI")


func _on_mouse_exited() -> void:
	tooltip.set_global_position(Vector2(-40,-10),false) 
	if highlighted:
		highlighted = false
		tooltip.visible = false
