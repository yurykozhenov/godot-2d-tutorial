extends Area2D


signal hit

@export var speed = 32 # How fast the player will move (pixels/sec).
@export var Bullet: PackedScene
@export var step_timer: Timer
@export var fire_rate = 1

var is_dead = false
var screen_size # Size of the game window.
var allowed_to_move
var move_direction = "right"
var time_to_next_shot = 0

func _ready():
	screen_size = get_viewport_rect().size

	# Init hidden and with disabled collision
	# hide()
	# $CollisionShape2D.set_deferred("disabled", true)


func _process(delta):
	if is_dead:
		return

	if time_to_next_shot <= 0:
		if Input.is_action_just_pressed("action"):
			shoot()
	else:
		time_to_next_shot -= delta

	if !allowed_to_move:
		return

	if Input.is_action_pressed("move_right"):
		# position.x += speed
		move_direction = "right"
		$AnimatedSprite2D.play("right")
		allowed_to_move = false

	if Input.is_action_pressed("move_left"):
		# position.x -= speed
		move_direction = "left"
		$AnimatedSprite2D.play("left")
		allowed_to_move = false

	if Input.is_action_pressed("move_up"):
		# position.y -= speed
		move_direction = "up"
		$AnimatedSprite2D.play("up")
		allowed_to_move = false

	if Input.is_action_pressed("move_down"):
		# position.y += speed
		move_direction = "down"
		$AnimatedSprite2D.play("down")
		allowed_to_move = false

	position = position.clamp(Vector2(96, 96), Vector2(288, 288))


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func shoot():
	var b = Bullet.instantiate()
	b.timer = step_timer
	get_parent().add_child(b)

	if move_direction == "up":
		b.position.x = position.x
		b.position.y = position.y - 64
		b.rotation = deg_to_rad(-90)

	if move_direction == "down":
		b.position.x = position.x
		b.position.y = position.y + 64
		b.rotation = deg_to_rad(90)

	if move_direction == "right":
		b.position.x = position.x + 64
		b.position.y = position.y
		b.rotation = deg_to_rad(0)

	if move_direction == "left":
		b.position.x = position.x - 64
		b.position.y = position.y
		b.rotation = deg_to_rad(180)

	b.direction = move_direction
	$ShootSound.play()
	$ShootSound.pitch_scale = randf_range(1, 2)
	print("Pew")
	time_to_next_shot = fire_rate


func _on_body_entered(_body):
	print("Body entered")



func _on_area_entered(_area):
	print("Area entered")
	collide()


func collide():
	hide()
	hit.emit()
	is_dead = true
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)


func _on_step_timer_timeout():
	if move_direction == "right":
		position.x += speed

	if move_direction == "left":
		position.x -= speed

	if move_direction == "up":
		position.y -= speed

	if move_direction == "down":
		position.y += speed

	allowed_to_move = true
