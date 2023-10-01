extends Marker2D

@export var Mob: PackedScene
@export var player: Area2D
@export var step_timer: Timer

func _on_mob_spawn_timer_timeout():
	spawn_mob()

func spawn_mob():
	var mob = Mob.instantiate()
	mob.position = position
	get_parent().add_child(mob)
	mob.player = player
	step_timer.timeout.connect(mob.move)
