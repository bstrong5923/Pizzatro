extends Equipment
class_name Spatula

@export var multiplier : int

func effect(context, moreContext):
	var point = moreContext.flavors[0]
	print(point)
	context.add_points(0 - point, 0)
	context.add_points(point * multiplier, 0)
	return
