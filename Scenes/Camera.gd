extends Camera2D





func _on_go_to_shop_button_pressed() -> void:
	var target_x := 230.0 
	var tween := get_tree().create_tween()
	tween.tween_property(self, "position:x", target_x, 1.0)
