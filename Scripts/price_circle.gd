extends Node2D

var price
var label = Label.new()
#defaultpos should be only be false if you dont want the price circle to be at the top right of the card
func set_price(p, defaultpos):
	price = p
	display_price(defaultpos)

func display_price(defaultpos):
	# format the text
	if float(int(price)) == price:
		price = int(price)
	else:
		price = snapped(price, .01) # round to two decimal places
	label.text = str(price)
	
	add_child(label)
	# wait until the label has been loaded
	await label.ready
	await get_tree().process_frame
	# scale it right
	set_size(1, defaultpos)

func set_size(n, defaultpos):
	# get the right label font
	var fontsize = 20
	if label.text.length() > 3:
		fontsize = 20 * pow(0.8, label.text.length() - 3)
	label.add_theme_font_size_override("font_size", fontsize * n)
	label.add_theme_color_override("color", Color(10,0,0))
	var f = FontFile.new()
	f.font_data = load("res://Assets/fonts/main.ttf")
	label.add_theme_font_override("font", f)
	# scale the circle up
	$circle.scale = Vector2(5 * n, 5 * n)
	if defaultpos == true:
		position = Vector2(10 * 5 * n, -15 * 5 * n)
	# Resets size to fit text + font
	label.reset_size()
	label.queue_redraw()
	# move the label to the right spot
	label.position = -label.size / 2
	label.position.x += n * 3
	label.position.y += n * 3

#doesnt work unless you have defaultpos be passed as false
func change_pos(x, y):
	position = Vector2(x, y)

#yes i made this it works if you want to clean up the code dont even talk with me twin 👀
func equipment_set_size(n):
	# get the right label font
	var fontsize = 4
	label.add_theme_font_size_override("font_size", fontsize)
	label.add_theme_color_override("color", Color(10,0,0))
	label.autowrap_mode = true
	var f = FontFile.new()
	f.font_data = load("res://Assets/fonts/main.ttf")
	label.add_theme_font_override("font", f)
	# scale the circle up
	$circle.scale = Vector2(n, n)
	# Resets size to fit text + font
	label.reset_size()
	label.size.x = 24
	label.queue_redraw()
	# move the label to the right spot
	label.position = Vector2(-2.5,-2)
