class_name Projectile extends Node3D

@export var damage = 10
@export var speed = 2
@export var lifeTime = 5.0
@export var popAudio: AudioStream
@export var fireAudio: AudioStream

@onready var audio_player: AudioStreamPlayer3D = %ProjectileAudio

var direction

func _ready() -> void:
	audio_player.stream = fireAudio
	audio_player.play()


func set_direction(new_direction):
	direction = new_direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta
	


func destruir_burbuja() -> void:
	audio_player.stream = popAudio
	audio_player.pitch_scale *= 1.3
	audio_player.play()
	await audio_player.finished
	queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("enemy"):
		destruir_burbuja()
		body.recibir_danio()


func _on_timer_timeout() -> void:
	destruir_burbuja()
