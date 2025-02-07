extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.has_key = true
		print("El jugador agarro la llave")
		print(body.has_key)
		queue_free()
