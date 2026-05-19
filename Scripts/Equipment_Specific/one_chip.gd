extends Equipment
class_name One_Chip

var multiplier = 500

func on_card_played(_ingredient):
	var remaining_hand := Deck.hand.duplicate()
	var cleared_hand := remaining_hand.size() > 0

	for card_in_hand in remaining_hand:
		if is_instance_valid(card_in_hand):
			card_in_hand.discard_self()

	var spicy_before = CardFunction.flavors_to_add[1]
	CardFunction.flavors_to_add[1] *= multiplier

	return cleared_hand or CardFunction.flavors_to_add[1] != spicy_before

func upgrade():
	pass
