extends Node2D

var price
var label = Label.new()

func set_price(p):
	price = p
	display_price()

func display_price():
	label.text = "$" + str(price)
	set_size(1)
	add_child(label)
	label.position = Vector2(-18, -25)

func set_size(n):
	label.add_theme_font_size_override("font_size", 36 * n)
	$circle.scale = Vector2(5 * n, 5 * n)
	position = Vector2(11 * 5 * n, -20 * 5 * n) # (11, -20) are the default coordinates
	
