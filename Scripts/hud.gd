extends Control

@export var gun: Gun

@onready var detergente_value: Label = $Detergent/DetergenteValue
@onready var brujas_value: Label = $ScoreTexture/BrujasValue


func _ready() -> void:
	brujas_value.text = str(10)
	gun.connect("s_reduce_detergent", on_reduce_detergent)


func on_reduce_detergent():
	detergente_value.text = str(gun.detergent)
