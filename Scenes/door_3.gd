extends Node3D

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if body.has_key == true:
			audio_stream_player_3d.playing = true
			await audio_stream_player_3d.finished
			get_tree().change_scene_to_file("res://pantalla_final.tscn")
