extends Equipment
class_name Grinder

@export var multiplier : int
#context is the score node
#moreContext is the ingredient object that triggered the equipment
func effect(context, moreContext):
	print("grinder trig")
	for x in moreContext.flavors.size():
		context.add_points(moreContext.flavors[x], x)
	return
