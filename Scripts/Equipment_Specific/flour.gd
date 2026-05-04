extends Equipment
class_name Flour
var multiplier = .1

func on_bought(g):
	RoundButtons.apply_flour_bonus(multiplier)
	


func upgrade():
	multiplier += .1
	description.replacen(str(.9 + multiplier), str(1 + multiplier))
