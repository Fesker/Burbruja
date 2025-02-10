extends Control

@export var gun: Gun

@onready var detergente_value: Label = $Detergent/DetergenteValue
@onready var brujas_value: Label = $ScoreTexture/BrujasValue


func _ready() -> void:
	gun.connect("s_reduce_detergent", on_reduce_detergent)
	gun.connect("s_add_detergent", on_add_detergent)
	GM.score_updated.connect(on_increase_score)


func on_reduce_detergent():
	detergente_value.text = str(gun.detergent)

func on_increase_score():
	brujas_value.text = str(GM.score)
	
func on_add_detergent():
	detergente_value.text = str(gun.detergent)
