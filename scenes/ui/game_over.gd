extends Control

func _ready():
	pass

func _on_restart_level_button_pressed() -> void:
	SoundManager.play_sound("button_click")
	SceneManager.reset_level()
	SceneManager.return_to_previous_scene()

func _on_restart_run_button_pressed() -> void:
	SoundManager.play_sound("button_click")
	SceneManager.change_scene("res://scenes/levels/levelone.tscn")

func _on_quit_button_pressed() -> void:
	SoundManager.play_sound("button_click")
	SceneManager.change_scene("res://scenes/ui/main_menu.tscn")
