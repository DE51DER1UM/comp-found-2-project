extends CharacterBody2D

enum States {IDLE, RUNNING, JUMPING, FALLING, DASHING, DEATH}

var state: States = States.IDLE

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const GRAVITY = 1200.0
const DASH_SPEED = 1200.0
const DASH_TIME = 0.2
const DASH_COOLDOWN = 0.5

var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var dash_direction = Vector2.ZERO

var has_started_timer := false
var is_timer_running := false

var camera = Camera2D


func _ready():
	camera = get_viewport().get_camera_2d()

func player_has_input() -> bool:
	return Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up")

func change_state(new_state: States) -> void:
	if state == new_state:
		return

	exit_state()
	state = new_state
	enter_state()

func enter_state() -> void:
	match state:
		States.IDLE:
			$AnimatedSprite2D.play("idle")
		States.RUNNING:
			$AnimatedSprite2D.play("run")
		States.JUMPING:
			velocity.y = JUMP_VELOCITY
			SoundManager.play_sound("jump")
			$AnimatedSprite2D.play("jump")
		States.DASHING:
			SoundManager.play_sound("dash")
			dash_timer = DASH_TIME
			$AnimatedSprite2D.play("dash")
		States.DEATH:
			$AnimatedSprite2D.play("death")

func update_state(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	match state:
		States.IDLE: 
			if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0:
				start_dash(direction)
			if direction: 
				change_state(States.RUNNING)
			elif !is_on_floor():
				change_state(States.FALLING)
			elif Input.is_action_just_pressed("ui_up"):
				change_state(States.JUMPING) 
			
		States.RUNNING: 
			if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0:
				start_dash(direction)
			velocity.x = direction * SPEED 
			if velocity.x > 0:
				$AnimatedSprite2D.flip_h = false
			elif velocity.x < 0:
				$AnimatedSprite2D.flip_h = true
				
			if !is_on_floor():
				change_state(States.FALLING)
			elif Input.is_action_just_pressed("ui_up"):
				change_state(States.JUMPING) 
			elif velocity.x == 0: 
				change_state(States.IDLE)
				
			move_and_slide()
			
		States.JUMPING:
			if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0:
				start_dash(direction)
			velocity.x = direction * SPEED 
			if velocity.x > 0: 
				$AnimatedSprite2D.flip_h = false
			elif velocity.x < 0:
				$AnimatedSprite2D.flip_h = true
				
			if !is_on_floor(): 
				velocity.y += GRAVITY * delta
				if velocity.y > 0: 
					change_state(States.FALLING)
				
			move_and_slide()
			
		States.FALLING: 
			if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0:
				start_dash(direction)
			velocity.x = direction * SPEED 
			if velocity.x > 0: 
				$AnimatedSprite2D.flip_h = false
			elif velocity.x < 0:
				$AnimatedSprite2D.flip_h = true
				
			if is_on_floor():
				change_state(States.IDLE)
			else:
				velocity.y += GRAVITY * delta
				
			move_and_slide()
			
		States.DASHING:
			if dash_timer > 0:
				dash_timer -= delta
				velocity = dash_direction * DASH_SPEED
				move_and_slide()
			else:
				dash_cooldown_timer = DASH_COOLDOWN
				change_state(States.FALLING if !is_on_floor() else States.IDLE)
			
		States.DEATH:
			pass
			
			
func start_dash(direction: float) -> void:
	if direction == 0:
		dash_direction = Vector2(-1, 0) if $AnimatedSprite2D.flip_h else Vector2(1, 0)
	else:
		dash_direction = Vector2(direction, 0)
		change_state(States.DASHING)

func _physics_process(delta: float) -> void:
	if not has_started_timer and player_has_input():
		has_started_timer = true
		is_timer_running = true
		SceneManager.score_timer = 0.0

	if is_timer_running:
		SceneManager.score_timer += delta
		var display_score = str(snapped(SceneManager.score_timer, 0.01))
		SceneManager.get_current_scene().get_node("CanvasLayer/UI/CanvasLayer/ScoreLabel").text = "Score: " + display_score

	if camera and global_position.y > camera.limit_bottom:
		#await get_tree().create_timer(1.0).timeout
		SoundManager.play_sound("death")
		is_timer_running = false
		SceneManager.score_timer = 0.0
		SceneManager.change_scene("res://scenes/ui/game_over.tscn")
		print_debug("death")
		print_debug(SceneManager.total_score)
		return
		
	#dev shortcuts
	if Input.is_action_pressed("1"):
		SceneManager.add_level_score()
		print_debug(SceneManager.total_score)
		SceneManager.change_scene("res://scenes/levels/levelone.tscn")
	if Input.is_action_pressed("2"):
		SceneManager.add_level_score()
		print_debug(SceneManager.total_score)
		SceneManager.change_scene("res://scenes/levels/leveltwo.tscn")
	if Input.is_action_pressed("3"):
		SceneManager.add_level_score()
		print_debug(SceneManager.total_score)
		SceneManager.change_scene("res://scenes/levels/levelthree.tscn")
	if Input.is_action_pressed("devwin"):
		SceneManager.add_level_score()
		print_debug(SceneManager.total_score)
		SceneManager.change_scene("res://scenes/ui/game_end.tscn")
		
	update_state(delta)

func exit_state() -> void:
	match state:
		States.IDLE: 
			pass
		States.RUNNING: 
			pass
		States.JUMPING:
			pass
		States.FALLING: 
			pass
		States.DASHING:
			pass
		States.DEATH:
			pass
