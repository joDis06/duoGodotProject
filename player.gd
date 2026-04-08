extends Area2D

enum Directions {LEFT, RIGHT, UP, DOWN}

var speed = 400
var screen_size
var last_move = Directions.DOWN


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	
	#self.scale = Vector2.ONE * (screen_size.y / 32) / 5 # last number is how tall in 
														# relation to the screen he is and 32 is his pixel size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		last_move = Directions.RIGHT
		$AnimatedSprite2D.play("walking_right")
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		last_move = Directions.LEFT
		$AnimatedSprite2D.play("walking_left")
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		last_move = Directions.DOWN
		$AnimatedSprite2D.play("walking_forward")
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		last_move = Directions.UP
		$AnimatedSprite2D.play("walking_backward")
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		# Play Idle when stopped
		match last_move:
			Directions.RIGHT:
				$AnimatedSprite2D.play("idle_right")
			Directions.LEFT:
				$AnimatedSprite2D.play("idle_left")
			Directions.UP:
				$AnimatedSprite2D.play("idle_backward") # wrong but lol
			Directions.DOWN:
				$AnimatedSprite2D.play("idle_forward")
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	print(position)
	
