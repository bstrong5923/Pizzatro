extends Equipment
class_name Incognito

var multiplier = 2
var pac

func on_bought(pack):
	pac = pack
	pac.incognito(multiplier)
	
func upgrade():
	multiplier += 1
	on_bought(pac)
