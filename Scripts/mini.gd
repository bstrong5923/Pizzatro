extends Sprite2D

var is_a_clone = false
func dont_clone():
	is_a_clone = true

func scatter(ingredient):
	texture = load("res://Assets/Sprites/ingredient_minis/" + str(ingredient) + ".png") # get the correct spritesheet
		region_rect.position.x = randi_range(0,4) * 5 # random mini of the ingredient
		# random position in the pizza
		var x = 200
		var y = 200
		while pow(x, 2) + pow(y + 111, 2) >= pow(108, 2): # while it is not in the pizza, try again
			x = randi_range(-17, 18) * 6
			y = randi_range(1, 35) * -6 - 3
			print("x: " + str(x) + ", y: " + str(y))
		position = Vector2(x, y)
		# random rotation
		rotation_degrees = randi_range(0,3) * 90
		# clone it
		
		
		#var newnode = Sprite2D.new()
		#newnode.texture = texture
		#newnode.position = position
		#var instance = newnode.instantiate()
		#addchild(instance)
		print("cloned.")
		
func create_clones(ingredient):
	for m in range(0, randi_range(4,7)): # create between 4 and 6 minis
		var mynode = preload("res://Scenes/mini.tscn")
		var instance = mynode.instantiate()
		instance.scatter(ingredient)
		add_child(instance)

func _ready() -> void:
	if is_a_clone:
		create_clones(3)
