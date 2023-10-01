extends Area2D


@export var speed = 32 # How fast the mob will move (pixels/sec).
@export var player: Area2D

func move():
	if position.x != player.position.x and position.y != player.position.y:
		if randi() % 2 != 0:
			move_horizontaly()
		else:
			move_vertically()
	elif position.x != player.position.x:
		move_horizontaly()
	elif position.y != player.position.y:
		move_vertically()


func move_horizontaly():
	if position.x < player.position.x:
		position.x += speed
	elif position.x > player.position.x:
		position.x -= speed


func move_vertically():
	if position.y > player.position.y:
		position.y -= speed
	elif position.y < player.position.y:
		position.y += speed
