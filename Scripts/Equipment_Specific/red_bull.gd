extends Equipment
class_name Red_Bull

var bonus = 1

func on_round_start(game):
	game.starting_energy += bonus
