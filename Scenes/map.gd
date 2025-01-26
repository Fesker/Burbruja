class_name Map extends Node3D

#@export var spawn_points : Array[Area3D]
@export var llave_scene : PackedScene
@export var key_locations : Array[Marker3D]


var active_spawn_index := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cargar_llave()
	
func cargar_llave():
	active_spawn_index = randi() % key_locations.size()
	var llave = llave_scene.instantiate()
	llave.position = key_locations[active_spawn_index].position
	get_parent().add_child.call_deferred(llave)
	#spawn_points[active_spawn_index].monitoring = true
	#spawn_points[active_spawn_index].monitorable = true
	#spawn_points[active_spawn_index].get_child(0).visible = true
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#func _on_key_spawn_body_entered(body: Node3D) -> void:
	#if body.is_in_group("player"):
		#key_is_active()
		#print("El jugador agarro la llave")
	
#func key_is_active ():
	#active_key = true
