extends Equipment
class_name Flour
var multiplier = .1

func get_money_multiplier_per_remaining_ingredient() -> float:
	return 1.0 + multiplier

func upgrade():
	multiplier += .1
	description = description.replacen(str(.9 + multiplier), str(1 + multiplier))
