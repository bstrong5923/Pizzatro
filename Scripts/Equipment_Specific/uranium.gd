extends Equipment
class_name Uranium

var multiplier = 1.5

func on_round_start(game):
	game.starting_energy *= multiplier
