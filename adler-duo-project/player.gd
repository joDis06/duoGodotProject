extends Area2D

enum Directions {LEFT, RIGHT, UP, DOWN}

var speed = 400
var screen_size
var last_move = Directions.DOWN


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		last_move = Directions.RIGHT
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		last_move = Directions.LEFT
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		last_move = Directions.DOWN
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		last_move = Directions.UP
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play("idle_forward") # hack to move him forward
		$AnimatedSprite2D.stop() # Stop Idle when moving (hack)
	else:
		# Play Idle when stopped
		match last_move:
			Directions.RIGHT:
				$AnimatedSprite2D.play("idle_right")
			Directions.LEFT:
				$AnimatedSprite2D.play("idle_left")
			Directions.UP:
				$AnimatedSprite2D.play("idle_forward") # wrong but lol
			Directions.DOWN:
				$AnimatedSprite2D.play("idle_forward")
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
