extends Equipment
class_name Butcher_Knife

@export var multiplier : int

func effect(context, moreContext):
	print("butcher trig")
	for x in moreContext.flavors.size():
		context.add_points(moreContext.flavors[x] * multiplier, x)
	return
