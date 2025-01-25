class_name InputComponent extends Node

@export var mouse_sensitivity : float = 0.05
@export var camera : Camera3D
@export var player: CharacterBody3D

@onready var gun: Gun = %Gun


var max_distance = 10

func _ready():
	# Lock and hide the cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	# Handle mouse look
	if event is InputEventMouseMotion:
		player.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		camera.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		player.rotation.x = clamp(player.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _input(event):
	# Handle shooting (example using left mouse button)
	if event.is_action_pressed("shoot"):
		gun.shoot_projectile()
	
	# Escape to release mouse
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	# Handle movement
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()	
	
	# Apply horizontal movement
	if direction:
		player.velocity.x = direction.x * player.current_speed
		player.velocity.z = direction.z * player.current_speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.current_speed)
		player.velocity.z = move_toward(player.velocity.z, 0, player.current_speed)
		
	
	player.move_player(direction)
