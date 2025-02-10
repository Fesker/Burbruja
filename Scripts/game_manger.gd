class_name GameManager extends Node

signal score_updated

var score: int = 0

func add_points(points: int) -> void:
	score += points
	score_updated.emit()

func reset_score() -> void:
	score = 0
	
