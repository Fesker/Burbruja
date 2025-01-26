extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.





func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if body.has_key == true:
			print("abrir puerta")
		else: print ("no tenes la llave pa")
