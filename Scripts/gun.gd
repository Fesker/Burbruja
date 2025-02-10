class_name Gun extends Node3D

@export var projectile_prefab: PackedScene
@export var detergent: float;

# Shake parameters
var shake_intensity: float = 0.1  # How strong the shake is
var shake_duration: float = 0.1   # How long the shake lasts
var shake_timer: float = 0.0      # Timer for the shake
var is_shaking: bool = false      # Whether the camera is currently shaking

# Original camera position
var original_position: Vector3

@onready var muzzle: Marker3D = %muzzle
@onready var camera: Camera3D = %Camera
@onready var projectiles_container: Node3D = %ProjectilesContainer

var max_distance = 1000.0
var max_detergent: float = 100

signal s_reduce_detergent(value)
signal s_add_detergent(value)
signal s_no_detergent


func _ready() -> void:
	detergent = max_detergent
	original_position = camera.position

func _process(delta: float) -> void:
	if is_shaking:
		# Update the shake timer
		shake_timer -= delta

		if shake_timer <= 0:
			# Stop shaking and reset the camera position
			is_shaking = false
			camera.position = original_position
		else:
			# Apply random offset to the camera position
			camera.position = original_position + Vector3(
				randf_range(-shake_intensity, shake_intensity),
				randf_range(-shake_intensity, shake_intensity),
				randf_range(-shake_intensity, shake_intensity)
			)

func start_shake():
	# Start the shake effect
	is_shaking = true
	shake_timer = shake_duration

func shoot_projectile():
	if detergent <= 0: return
	
	if not projectile_prefab:
		push_error("No projectile scene assigned!")
		return
	
	# Start shake movement
	start_shake()
	
	var projectile = projectile_prefab.instantiate()
	projectile.position = muzzle.global_position
	
	# Assign Projectile Direction
	projectile.set_direction(-camera.global_transform.basis.z)
	
	# Calculate projectile direction
	var shoot_direction = -camera.global_transform.basis.z
	#projectile.linear_velocity = shoot_direction * projectile_speed
	
	get_parent().add_child(projectile)
	
	reduce_detergent()


func add_detergent(value: float) -> void:
	detergent += value
	#clampf(detergent, 0, max_detergent)
	if detergent > max_detergent:
		detergent = max_detergent
	if detergent <= 0:
		detergent = 0
	s_add_detergent.emit()
	# Llamar de esta forma
	#s_add_detergent.connect(
	#Callable(on_add_detergent)
		#.bind(value))

	
func reduce_detergent() ->void:
	detergent -= 1
	s_reduce_detergent.emit()
	if detergent <= 0:
		s_no_detergent.emit()
		# Llamar de esta forma
		#s_no_detergent.connect(on_add_detergent)
	
	clampf(detergent, 0, max_detergent)
