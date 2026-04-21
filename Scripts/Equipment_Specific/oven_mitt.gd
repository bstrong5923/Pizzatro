extends Equipment
class_name Oven_Mitt

signal detroit

func on_bought(input):
	detroit.emit()
