extends Node3D
@export var small_tumb_model : PackedScene
@export var big_tumb_model : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#replace_tombs()


func replace_tombs():
	for node in get_tree().get_nodes_in_group("small_tumb"):
		replace_mesh(node, small_tumb_model)
		
	for node in get_tree().get_nodes_in_group("big_tumb"):
		replace_mesh(node, big_tumb_model)

func replace_mesh(old_node: Node3D, new_model: PackedScene):
	var new_instance = new_model.instantiate()
	new_instance.transform = old_node.transform
	old_node.get_parent().add_child(new_instance)
	old_node.queue_free()


func _on_timer_timeout() -> void:
	replace_tombs()
