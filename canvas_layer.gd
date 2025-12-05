extends CanvasLayer

@export var default_tex: Texture2D
@export var click_tex: Texture2D
@export var click_duration := 0.1

@onready var cursor_sprite := $CursorSprite
var click_timer: Timer

func _ready():
	click_timer = Timer.new()
	click_timer.one_shot = true
	click_timer.wait_time = click_duration
	click_timer.connect("timeout", Callable(self, "_on_click_timeout"))
	add_child(click_timer)
	cursor_sprite.texture = default_tex
	cursor_sprite.centered = false
	
func _notification(what):
	if what == NOTIFICATION_WM_MOUSE_ENTER:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	elif what == NOTIFICATION_WM_MOUSE_EXIT:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta):
	cursor_sprite.position = get_viewport().get_mouse_position()


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		cursor_sprite.texture = click_tex
		click_timer.start()


func _on_click_timeout():
	cursor_sprite.texture = default_tex
