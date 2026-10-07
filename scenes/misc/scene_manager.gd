extends Node

var previous_scene_path: String
var score_timer: float = 0.0

var total_score: float = 0.0

func get_current_scene() -> Node:
	return get_tree().current_scene
	
func change_scene(new_scene_path: String):
	previous_scene_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(new_scene_path)

func return_to_previous_scene():
	if previous_scene_path:
		get_tree().change_scene_to_file(previous_scene_path)
		

func reset_run():
	total_score = 0.0
	score_timer = 0.0
	
func reset_level():
	score_timer = 0.0

func add_level_score():
	total_score += score_timer
	score_timer = 0.0 
