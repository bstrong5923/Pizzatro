extends Sprite2D

var price

func set_price(p):
	price = p
	display_price()

func display_price():
	var label = Label.new()
	label.text = "$" + str(price)
	label.add_theme_font_size_override("font_size", 6)
	add_child(label)
	label.position = Vector2(-3,-5)
