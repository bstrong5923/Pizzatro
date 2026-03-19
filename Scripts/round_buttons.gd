extends Node2D

var mode = 0
var labels = ["Submit", "Shop", "Done"]
var clickable = true
var cooldown = false
@onready
var equipment = get_node("/root/Game/equipment")
var flour_count: float = 1.0
var money_threshholds = [1.0, 1.6, 2.0, 2.5, 3.0, 5.0]
func apply_flour_bonus(amount: float = 0.1) -> void:
	flour_count += amount

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and clickable and !cooldown:
		clickable = false
		if mode == 0 and get_node("/root/Game").is_playing():
			get_node("/root/Game").playing_off()
			#money shit
			if (get_node("/root/Game/Labels/Score").calc() >= Deck.minimum):
				var score_ratio = get_node("/root/Game/Labels/Score").calc() / Deck.minimum
				var thresh_index = 0
				for x in money_threshholds:
					if score_ratio > money_threshholds[x]:
						thresh_index = x
				var base_money = thresh_index * 4
				print("Threshold index: " + str(thresh_index))
				Score.money += base_money * flour_count
				get_node("/root/Game/Labels/money/Count").text = Lib.num_to_string(Score.money)
				
				cooldown = true
				await get_tree().create_timer(0.25).timeout
				cooldown = false
			else:
				get_node("/root/Game").game_over()
			
		elif !get_node("/root/Game/Camera2D").camera_locked:
			if mode == 1:
				get_node("/root/Game/Camera2D").go_to_shop()
				await get_tree().create_timer(0.25).timeout # wait until I am offscreen and then teleport to shop
				equipment.generate_random_equipment()
				position = Vector2(235.6,30)
			else:
				get_node("/root/Game").new_round()
				get_node("/root/Game/Camera2D").go_to_game()
				await get_tree().create_timer(0.25).timeout # wait until I am offscreen and then teleport to game
				position = Vector2(-94.6,25)
			
			next_mode()
		
		
func next_mode():
	mode += 1
	if mode == 3:
		mode = 0
	$button.region_rect.position.y = mode * 10
	$Label.text = labels[mode]
	clickable = true


func _process(delta: float) -> void:
	pass
