class_name Gun extends Node3D

@export var projectile_prefab: PackedScene
@export var detergent: float;

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


func shoot_projectile():
	if detergent <= 0: return
	
	if not projectile_prefab:
		push_error("No projectile scene assigned!")
		return
	
	var projectile = projectile_prefab.instantiate()
	projectile.global_position = muzzle.global_position
	
	# Assign Projectile Direction
	projectile.set_direction(-camera.global_transform.basis.z)
	
	# Calculate projectile direction
	var shoot_direction = -camera.global_transform.basis.z
	#projectile.linear_velocity = shoot_direction * projectile_speed
	
	get_parent().add_child(projectile)
	
	reduce_detergent()
	print(detergent)


func add_detergent(value: float) -> void:
	detergent += value
	clampf(detergent, 0, max_detergent)
	s_add_detergent.emit()
	# Llamar de esta forma
	#s_add_detergent.connect(
	#Callable(on_add_detergent)
		#.bind(value))

	
func reduce_detergent() ->void:
	detergent -= 1
	s_reduce_detergent.emit()
	# Llamar de esta forma
	#s_reduce_detergent.connect(
	#Callable(on_reduce_detergent)
	#.bind(value))
	if detergent <= 0:
		print("NO HAY DETERGENTE!")
		s_no_detergent.emit()
		# Llamar de esta forma
		#s_no_detergent.connect(on_add_detergent)
	
	clampf(detergent, 0, max_detergent)
