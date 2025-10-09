extends Sprite2D

var original = true
func dont_clone():
	original = false

func scatter(ingredient):
	var init_angle = randi_range(0,359)
	var num_of_minis = randi_range(5,7)
	for m in range(0, num_of_minis): # create between 5 and 7 minis
		
		# clone it
		var mynode = preload("res://Scenes/minis.tscn")
		var instance = mynode.instantiate()
		
		# get the correct spritesheet
		instance.texture = load("res://Assets/Sprites/ingredient_minis/" + str(ingredient) + ".png")
		# random mini of the ingredient
		instance.region_rect.position.x = randi_range(0,4) * 5
		
		# random position in the pizza
		var angle = init_angle + (360 / num_of_minis) * m + randi_range(-5,5) # each one has an evenly spaced angle (0, 90, 180, 270 if there were four minis)
		var radius = pow(randi_range(36, 10404), 0.5) # random radius from the middle of the pizza to the edge, further out is more common
		var x = int(radius * cos(deg_to_rad(angle))) # get the x and y
		x -= x % 6
		var y = int(radius * sin(deg_to_rad(angle)))
		y -= 1 + y % 6
		instance.position = Vector2(x, y)
		 
		# random rotation, then scale it and tell it it isn't the original
		instance.rotation_degrees = randi_range(0,3) * 90
		instance.scale.x = 6
		instance.scale.y = 6
		instance.dont_clone()
		add_child(instance)

	
