extends Camera2D



var camera_locked = false

func go_to_shop():
	lock_camera()
	var target_x := 235.0 
	var tween := get_tree().create_tween()
	tween.tween_property(self, "position:x", target_x, .5)
	tween.finished.connect(self.unlock_camera)
	
func go_to_game():
	lock_camera()
	var target_x := 0.0 
	var tween := get_tree().create_tween()
	tween.tween_property(self, "position:x", target_x, .5)
	tween.finished.connect(self.unlock_camera)

func _on_go_to_shop_button_pressed() -> void:
	go_to_shop()

func _on_go_to_game_button_pressed() -> void:
	go_to_game()

func lock_camera():
	camera_locked = true

func unlock_camera():
	camera_locked = false
