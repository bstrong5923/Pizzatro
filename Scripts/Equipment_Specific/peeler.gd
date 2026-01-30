extends Equipment
class_name Peeler

@export var multiplier : int
#context is the score node
#moreContext is the ingredient object that triggered the equipment
func effect(context, moreContext):
	print("peeler trig")
	for x in moreContext.flavors.size():
		context.add_points(moreContext.flavors[x] * multiplier, x)
	return
