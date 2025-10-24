extends Sprite2D

var price

func set_price(p):
	price = p
	display_price()

func display_price():
	var label = Label.new()
	label.text = "$" + str(price)
	print(label.get_theme_font_size(label.text))
	add_child(label)
	label.position = position
