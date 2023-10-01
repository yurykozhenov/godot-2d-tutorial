extends Area2D


@export var speed = 32
@export var timer: Timer


func _ready():
	timer.timeout.connect(move)


func move():
	position.y -= speed


func collision(body: Node):
	print("Bullet collision!")
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()


func _on_area_entered(area):
	collision(area)


func _on_body_entered(body):
	collision(body)
