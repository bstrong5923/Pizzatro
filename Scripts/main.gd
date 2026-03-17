extends Node
@onready var game = preload("res://Scenes/Game.tscn")

var suffixes = ["","K","M","B","T","Q"]

func _ready() -> void:
	var game_scene = game.instantiate()

func cleannum(v):
	var result
	
	if v == float(int(v)) or v >= 1000: # 3.0 --> 3,   1000.5 --> 1000
		result = int(v)
	
	elif v < 100: # 33.3333333 --> 33.33
		result = snapped(v, 0.01)
		if float(int(result)) == result: # make sure its not like 0.0, or 1.99999 doesnt become 2.0
			if v < result:
				result -= .01
			else:
				result += .01
				
	else:  # 333.3333333 --> 333.3
		result = snapped(v, 0.1)
	return result

func num_to_string(val):
	var v = float(val)
	var suffix_index = 0
	var epower = ""
	
	if v >= 1000000000000000000: # past 1 quintillion we just return like 2.71e+18
		var power = int(log(v)/log(10))
		epower = "e+" + str(power)
		v = cleannum(v / pow(10,power))
	
	elif v >= 100000: # 1,000,000 become 1M, 97,345,352,345 becomes 97.34B, etc
		while v >= 1000.0:
			suffix_index += 1
			v /= 1000.0
			
	var result = str(cleannum(v)) + epower + suffixes[suffix_index]
	return result
			
	
