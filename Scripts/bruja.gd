extends CharacterBody3D

@export var move_speed: float = 3.0
@export var chase_range: float = 10.0
@export var attack_range: float = 2.0
@export var attack_damage: int = 20
@export var attack_cooldown: float = 1.5

var player: Node3D
var can_attack: bool = true

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready():
	animation_player.play("idle")
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	look_at(player.position)
	if not player:
		return
	
	var distance_to_player = global_position.distance_to(player.global_position)
	
	if distance_to_player <= chase_range:
		var direction_to_player = global_position.direction_to(player.global_position)
		
		if distance_to_player > attack_range:
			# Chase player
			velocity = direction_to_player * move_speed
			move_and_slide()
		else:
			# Stop and attack
			velocity = Vector3.ZERO
			if can_attack:
				melee_attack()

func melee_attack():
	can_attack = false
	
	# Add player damage logic here
	# Example: player.take_damage(attack_damage)
	
	# Attack cooldown
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

func take_damage(damage_amount: int):
	# Enemy health logic
	print("Enemy took %d damage" % damage_amount)
	# Add health reduction, death check, etc.
