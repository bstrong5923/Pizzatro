extends Equipment
class_name Flour

func get_multiplier(flour_count: int) -> float:
	# 1 Flour = 1.1x, 2 Flour = 1.2x, etc.
	return 1.0 + (float(flour_count) / 10.0)

#yahoo (adding this to e able to make a commit)
