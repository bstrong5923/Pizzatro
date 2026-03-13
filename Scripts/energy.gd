extends Label

var energy = 0.0

func set_energy(v):
	energy = float(v)
	display_energy()

func change_energy(v):
	energy += float(v)
	display_energy()

func display_energy():
	text = Lib.num_to_string(energy)

func get_energy():
	return energy
