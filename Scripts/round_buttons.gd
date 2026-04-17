extends Node2D

@onready var container = $Container
var mode = 0
var labels = ["Submit", "Shop", "Done"]
var clickable = true
var cooldown = false
@onready
var equipment = load("res://Scenes/equipment.tscn")
var flour_count: float = 1.0
var money_threshholds = [0, 1.0, 1.6, 2.0, 2.5, 3.0, 5.0]
func apply_flour_bonus(amount: float = 0.1) -> void:
	flour_count += amount

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and clickable and !cooldown:
		clickable = false
		
		if mode == 0 and get_node("/root/Game").is_playing(): # SUBMIT mode
			get_node("/root/Game").playing_off()
			#money shit
			if (get_node("/root/Game/Labels/Score").calc() >= Deck.minimum):
				var score_ratio = get_node("/root/Game/Labels/Score").calc() / Deck.minimum
				var thresh_index = 0
				for x in range(money_threshholds.size()):
					if score_ratio > money_threshholds[x]:
						thresh_index = x
				var base_money = thresh_index * 8
				print("Threshold index: " + str(thresh_index))
				Score.money += base_money * flour_count
				get_node("/root/Game/Labels/money/Count").text = Lib.num_to_string(Score.money)
				
				cooldown = true
				await get_tree().create_timer(0.25).timeout
				cooldown = false
			else:
				get_node("/root/Game").game_over()
			
		elif !get_node("/root/Game/Camera2D").camera_locked: 
			if mode == 1:# SHOP mode
				get_node("/root/Game/Camera2D").go_to_shop()
				await get_tree().create_timer(0.25).timeout # wait until I am offscreen and then teleport to shop
				position = Vector2(235.6,30)
				
				var locations  = [Vector2(-320, -350), Vector2(-146, -350), Vector2(-320, -170), Vector2(-146, -170)]
				# equipments in shop
				for i in range(0,4):
					var equip_instance = equipment.instantiate()
					equip_instance.scale = Vector2(4,4)
					equip_instance.position = locations[i]
					print(Equip.common_equip_list)
					equip_instance.set_equipment(await Equip.generate_random_equipment())
					equip_instance.shop_mode_on()
					container.add_child(equip_instance)
				
				
				
			else: # DONE mode
				get_node("/root/Game").new_round()
				get_node("/root/Game/Camera2D").go_to_game()
				get_node("/root/Game/Pack").visible = true
				await get_tree().create_timer(0.35).timeout # wait until I am offscreen and then teleport to game
				position = Vector2(-94.6,25)
				clear_shop_equipment()
			
			next_mode()

func next_mode():
	mode += 1
	if mode == 3:
		mode = 0
	$button.region_rect.position.y = mode * 10
	$Label.text = labels[mode]
	clickable = true

func clear_shop_equipment():
	for child in container.get_children():
		Equip.common_equip_list.push_back(child.this_equip) # put equipment back into common_equip_list bc we removed it
		child.queue_free()
