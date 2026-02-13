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
	var label = get_node("info_sprite/info")
	var text = n

	text = text.replacen("Sweet", "[color=d900d9]Sweet[/color] ")
	text = text.replacen("Spicy", "[color=c85c00]Spicy[/color] ")
	text = text.replacen("Salty", "[color=fae100]Salty[/color] ")
	text = text.replacen("Sour", "[color=1ac200]Sour[/color] ")
	text = text.replacen("Savory", "[color=0006a6]Savory[/color] ")
	text = text.replacen("Energy", "[color=ffd900]Energy[/color] ")
	label.text = text
	#spicy c85c00 salty fae100 sour 1ac200 savory 0006a6 energy ffd900 sweet d900d9

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
