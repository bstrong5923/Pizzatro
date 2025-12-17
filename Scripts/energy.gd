extends Label

var energy = 0

func set_energy(v):
	energy = v
	display_energy()

func change_energy(v):
	energy += v
	display_energy()

func display_energy():
	text = str(energy)

func get_energy():
	return energy
