extends Control

@export var pause_menu = self

func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused


func _on_resume_pressed() -> void:
	SoundManager.play_sound("button_click")
	get_tree().paused = false
	visible = false


func _on_quit_pressed() -> void:
	SoundManager.play_sound("button_click")
	get_tree().paused = false
	SceneManager.change_scene("res://scenes/ui/main_menu.tscn")
