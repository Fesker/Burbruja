extends Node3D

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var object: Node3D = $Object


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.has_key = true
		object.visible = false
		audio_stream_player_3d.playing = true
		await audio_stream_player_3d.finished
		queue_free()
