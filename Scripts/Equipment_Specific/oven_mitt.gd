extends Equipment
class_name Oven_Mitt

var detroit_texture = preload("res://Assets/Sprites/detroitstyle.png")

func on_bought(input):
	var pizza = input.get_node_or_null("pie/pie")
	if pizza == null:
		pizza = input.get_node_or_null("/root/Game/pie/pie")
	if pizza:
		pizza.texture = detroit_texture

	var minis = input.get_node_or_null("pie/minis")
	if minis == null:
		minis = input.get_node_or_null("/root/Game/pie/minis")
	if minis:
		minis.isDetroit = true
