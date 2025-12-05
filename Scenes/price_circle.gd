extends Node2D

var price
var label = Label.new()

func set_price(p):
	price = p
	display_price()

func display_price():
	label.text = "$" + str(price)
	add_child(label)
	# wait until the label has been loaded
	await label.ready
	await get_tree().process_frame
	# scale it right
	set_size(1)

func set_size(n):
	# get the right label font
	label.add_theme_font_size_override("font_size", 20 * n)
	label.add_theme_color_override("color", Color(10,0,0))
	var f = FontFile.new()
	f.font_data = load("res://Assets/fonts/main.ttf")
	label.add_theme_font_override("font", f)
	# scale the circle up
	$circle.scale = Vector2(5 * n, 5 * n)
	position = Vector2(11 * 5 * n, -20 * 5 * n) # (11, -20) are the default coordinates
	# Resets size to fit text + font
	label.reset_size()
	label.queue_redraw()
	# move the label to the right spot
	label.position = -label.size / 2
	label.position.x += n * 3
	label.position.y += n * 3

	
