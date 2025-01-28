class_name Dorothy extends CharacterBody3D

#@export var mouse_sensitivity : float = 0.05
@export var walk_speed : float = 5.0
@export var sprint_speed : float = 8.0

var current_speed : float = walk_speed

var has_key := false
@onready var camera: Camera3D = %Camera


func move_player(direction) -> void:
	# Apply horizontal movement
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
		
	move_and_slide()


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()
