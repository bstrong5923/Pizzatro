extends Equipment
class_name Red_Bull

var bonus = 6

func on_round_start(game):
	game.starting_energy += bonus

func upgrade():
	bonus += 2
	description = description.replacen(str(bonus - 2), str(bonus))
