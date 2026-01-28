extends Equipment
class_name Grinder

@export var multiplier : int
#context is the score node
#moreContext is the ingredient object that triggered the equipment
func effect(context, moreContext):
	var point = moreContext.savory
	print(point)
	context.add_points(0 - point, 4)
	context.add_points(point * multiplier, 4)
	return
