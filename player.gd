extends Area2D

var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Handle Movement
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	print(position)
	
	# Handle animations
	# Cursed block of logic (this can be condensed by I don't really feel like it)
	# Please refer to the truth table for guidance:
	# +---+---------+
	# |:3c| W A S D |
	# +---+---------+
	# | W | B B X B |
	# | A | B L F X |
	# | S | X F F F |
	# | D | B X F R |
	
	#Left (and by extension combined up and down animation logic)
	if Input.is_action_pressed("move_left"):
		if Input.is_action_pressed("move_up"):
			$AnimatedSprite2D.play("walking_backward")
			return
		if Input.is_action_pressed("move_down"):
			$AnimatedSprite2D.play("walking_forward")
			return
		$AnimatedSprite2D.play("walking_left")
		return
	#Right (and by extension combined up and down animation logic)
	if Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("move_up"):
			$AnimatedSprite2D.play("walking_backward")
			return
		if Input.is_action_pressed("move_down"):
			$AnimatedSprite2D.play("walking_forward")
			return
		$AnimatedSprite2D.play("walking_right")
		return
	#Pure up and down logic
	if Input.is_action_pressed("move_up"):
		$AnimatedSprite2D.play("walking_backward")
		return
	if Input.is_action_pressed("move_down"):
		$AnimatedSprite2D.play("walking_forward")
		return
		
	# Idle anims (can use just released because 
	# if moving then would've broken out of function)
	if Input.is_action_just_released("move_left"):
		$AnimatedSprite2D.play("idle_left")
	if Input.is_action_just_released("move_right"):
		$AnimatedSprite2D.play("idle_right")
	if Input.is_action_just_released("move_up"):
		$AnimatedSprite2D.play("idle_backward")
	if Input.is_action_just_released("move_down"):
		$AnimatedSprite2D.play("idle_forward")
	
	
