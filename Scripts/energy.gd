extends Label

var energy = 0.0

func set_energy(v):
	energy = float(v)
	display_energy()

func change_energy(v):
	energy += float(v)
	display_energy()

func display_energy():
	if float(int(energy)) == energy:
		energy = int(energy)
	else:
		energy = snapped(energy, .01)
	text = str(energy)

func get_energy():
	return energy
