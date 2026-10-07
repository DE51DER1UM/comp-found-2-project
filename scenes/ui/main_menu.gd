extends Node


func _on_start_button_pressed() -> void:
	SoundManager.play_sound("button_click")
	SceneManager.change_scene("res://scenes/levels/tutoriallevel.tscn")


func _on_quit_button_pressed() -> void:
	SoundManager.play_sound("button_click")
	get_tree().quit()
