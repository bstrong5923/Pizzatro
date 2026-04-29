extends Sprite2D

var price = 10
var pricetag

func _ready() -> void:
	pricetag = get_node("price_circle")
	pricetag.set_price(price, true)
	pricetag.equipment_set_size(1)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if get_node("/root/Game/RemoveCardMenu").is_open():
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#this works twins dont even fuck with me
		if (Deck.shop_hand.size() >= 0 and Score.money >= price):
			Deck.draw_shop_hand()
			Score.add_money( -1 * price)
			

func incognito(amt):
	price = 10 - amt
	pricetag.set_price(price, true)
