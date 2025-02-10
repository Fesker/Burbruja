extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var botella: Node3D = $Botella


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		var player = body as Dorothy
		audio_stream_player_3d.playing = true
		player.gun.add_detergent(10)
		botella.visible = false
		await audio_stream_player_3d.finished
		queue_free()
