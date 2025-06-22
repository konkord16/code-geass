extends Camera2D

@export var zoom_speed : float
var zoom_target : Vector2
var drag_start_mouse_pos = Vector2.ZERO
var drag_start_camera_pos = Vector2.ZERO
var dragging = false

func _ready() -> void:
	zoom_target = zoom

func _process(delta: float) -> void:
	_pan()
	_zoom(delta)
	

func _pan() -> void:
	if not dragging and Input.is_action_just_pressed("camera_pan"):
		drag_start_mouse_pos = get_viewport().get_mouse_position()
		drag_start_camera_pos = position
		dragging = true
		
	elif dragging and Input.is_action_just_released("camera_pan"):
		dragging = false
		
	if dragging:
		var move_vector = get_viewport().get_mouse_position() - drag_start_mouse_pos
		position = drag_start_camera_pos - move_vector/zoom.x

func _zoom(delta : float) -> void:
	if Input.is_action_just_pressed("camera_zoom_in"):
		zoom_target *= 1.1
	elif Input.is_action_just_pressed("camera_zoom_out"):
		zoom_target *= 0.9
	zoom = zoom.slerp(zoom_target, zoom_speed * delta)
