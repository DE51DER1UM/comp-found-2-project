extends Area2D


func _on_body_entered(body):
	var current_scene_path = SceneManager.get_current_scene().scene_file_path
	
	var tween = create_tween()

	if body.name == "Player" and current_scene_path == "res://scenes/levels/levelone.tscn":
		SoundManager.play_sound("coin")
		$AnimatedSprite2D.speed_scale *= 2
		tween.tween_property(self, "position", position + Vector2(0, -20), 0.3)
		tween.tween_property(self, "modulate:a", 0, 0.3)
		await get_tree().create_timer(0.5).timeout
		
		SceneManager.add_level_score()
		print_debug(SceneManager.total_score)
		SceneManager.change_scene("res://scenes/levels/leveltwo.tscn")
		
	if body.name == "Player" and current_scene_path == "res://scenes/levels/leveltwo.tscn":
		SoundManager.play_sound("coin")
		$AnimatedSprite2D.speed_scale *= 2
		tween.tween_property(self, "position", position + Vector2(0, -20), 0.2)
		tween.tween_property(self, "modulate:a", 0, 0.3)
		await get_tree().create_timer(0.5).timeout
		
		SceneManager.add_level_score()
		print_debug(SceneManager.total_score)
		SceneManager.change_scene("res://scenes/levels/levelthree.tscn")
	
	if body.name == "Player" and current_scene_path == "res://scenes/levels/levelthree.tscn":
		SoundManager.play_sound("coin")
		$AnimatedSprite2D.speed_scale *= 2
		tween.tween_property(self, "position", position + Vector2(0, -20), 0.2)
		tween.tween_property(self, "modulate:a", 0, 0.3)
		await get_tree().create_timer(0.5).timeout
		
		SceneManager.add_level_score()
		print_debug(SceneManager.total_score)
		SceneManager.change_scene("res://scenes/ui/game_end.tscn")
