extends Equipment
class_name Butcher_Knife

@export var multiplier : int

func effect(context, moreContext):
	var point = moreContext.savory
	print(point)
	context.add_points(0 - point, 4)
	context.add_points(point * multiplier, 4)
	return
