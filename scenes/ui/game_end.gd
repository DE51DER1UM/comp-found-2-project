extends Node2D


func _ready():
	$VBoxContainer/ScoreLabel.text += str(snapped(SceneManager.total_score, 0.01))

func _on_restart_run_button_pressed() -> void:
	SoundManager.play_sound("button_click")
	SceneManager.reset_run()
	SceneManager.change_scene("res://scenes/levels/levelone.tscn")


func _on_quit_button_pressed() -> void:
	SoundManager.play_sound("button_click")
	SceneManager.reset_run()
	SceneManager.change_scene("res://scenes/ui/main_menu.tscn")
