extends Sprite2D

var original = true
func dont_clone():
	original = false

func scatter(ingredient):
	for m in range(0, randi_range(4,7)): # create between 4 and 6 minis
		# clone it
		var mynode = preload("res://Scenes/minis.tscn")
		var instance = mynode.instantiate()
		# get the correct spritesheet
		instance.texture = load("res://Assets/Sprites/ingredient_minis/" + str(ingredient) + ".png")
		# random position in the pizza
		var x = 200
		var y = 200
		while pow(x, 2) + pow(y, 2) >= pow(102, 2): # while it is not in the pizza, try again
			x = randi_range(-17, 18) * -6 - 3 # position is relative to current position
			y = randi_range(-17, 18) * -6
		instance.position = Vector2(x, y)
		# random mini of the ingredient
		instance.region_rect.position.x = randi_range(0,4) * 5 
		# random rotation
		instance.rotation_degrees = randi_range(0,3) * 90
		instance.scale.x = 6
		instance.scale.y = 6
		instance.dont_clone()
		add_child(instance)

	
