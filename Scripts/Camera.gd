extends Camera2D

const HEAVY_SHAKE_STRENGTH := 12.0
const HEAVY_SHAKE_DURATION := 0.35

var camera_locked = false
var shake_strength := 0.0
var shake_tween: Tween
var shake_rng := RandomNumberGenerator.new()

func _ready() -> void:
	shake_rng.randomize()

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

func lock_camera():
	camera_locked = true

func unlock_camera():
	camera_locked = false

func shake_heavy() -> void:
	shake_screen(HEAVY_SHAKE_STRENGTH, HEAVY_SHAKE_DURATION)

func shake_screen(strength: float, duration: float) -> void:
	shake_strength = strength
	if shake_tween:
		shake_tween.kill()
	offset = Vector2.ZERO
	shake_tween = get_tree().create_tween()
	shake_tween.tween_method(_apply_shake, 1.0, 0.0, duration)
	shake_tween.finished.connect(_finish_shake)

func _apply_shake(falloff: float) -> void:
	offset = Vector2(
		shake_rng.randf_range(-shake_strength, shake_strength) * falloff,
		shake_rng.randf_range(-shake_strength, shake_strength) * falloff
	)

func _finish_shake() -> void:
	offset = Vector2.ZERO
	shake_tween = null
