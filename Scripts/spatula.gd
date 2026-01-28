extends Equipment
class_name Spatula

@export var multiplier : int

func effect(context, moreContext):
	var point = moreContext.sweet 
	print(point)
	context.add_points(point * multiplier, 0)
	return
