extends Area2D


@export var speed = 32
@export var timer: Timer
@export var direction = "up"


func _ready():
	timer.timeout.connect(move)


func move():
	if direction == "up":
		position.y -= speed

	if direction == "down":
		position.y += speed

	if direction == "right":
		position.x += speed

	if direction == "left":
		position.x -= speed


func collision(body: Node):
	print("Bullet collision!")
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()


func _on_area_entered(area):
	collision(area)


func _on_body_entered(body):
	collision(body)
