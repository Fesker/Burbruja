class_name Projectile extends Node3D

@export var damage = 10
@export var speed = 2
@export var lifeTime = 5.0
@export var popAudio: AudioStream
@export var fireAudio: AudioStream

@onready var audio_player: AudioStreamPlayer3D = %ProjectileAudio

var projectile_timer = Timer.new()
var direction

func _ready() -> void:
	audio_player.stream = fireAudio
	audio_player.play()
	setup_timer()


func set_direction(new_direction):
	direction = new_direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta
	

func setup_timer() -> void:
	add_child(projectile_timer)
	projectile_timer.wait_time = lifeTime
	projectile_timer.one_shot = true  # Only trigger once
	projectile_timer.start()
	projectile_timer.timeout.connect(func(): queue_free())


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("enemy"):
		body.recibir_danio()
