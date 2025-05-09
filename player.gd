extends Area2D

signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var velocity = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	var norm_velocity = velocity.normalized()
	if velocity.length() > 0:
		velocity = norm_velocity * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	select_animation(norm_velocity)
	
	velocity = Vector2.ZERO


func _on_body_entered(_body: Node2D) -> void:
	# Note: _ before the body parameter indicates it's unused (convension).
	hide()
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func add_velocity(given_velocity: Vector2):
	velocity += given_velocity

func select_animation(norm_velocity: Vector2):
	if abs(norm_velocity.x) >= 0.5:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = norm_velocity.x < 0
	elif norm_velocity.y >= 0.5:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = true
		$AnimatedSprite2D.flip_h = false
	elif norm_velocity.y < -0.5:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = false
