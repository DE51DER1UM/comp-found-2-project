extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update_score(value):
	$CanvasLayer/ScoreLabel.text = str(value)
