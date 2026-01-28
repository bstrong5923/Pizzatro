extends Node2D

var mode = 0
var labels = ["Submit", "Shop", "Done"]
var clickable = true
var cooldown = false
@onready
var equipment = get_node("/root/Game/equipment")

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and clickable and !cooldown:
		clickable = false
		if mode == 0 and get_node("/root/Game").is_playing():
			get_node("/root/Game").playing_off()
			#money shit
			if (get_node("/root/Game/Labels/Score").calc() > Deck.minimum):
				Score.money += get_node("/root/Game/Labels/Score").calc() - Deck.minimum
				get_node("/root/Game/Labels/money/Count").text = str(Score.money)
				
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
