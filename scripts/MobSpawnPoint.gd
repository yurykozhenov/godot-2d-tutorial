extends Marker2D


@export var Mob: PackedScene
@export var player: Area2D
@export var step_timer: Timer
var positionsX = [96, 128, 160, 192]
var timeout_count = 0
var MAX_TIMEOUT_COUNT = 20


func _on_mob_spawn_timer_timeout():
	spawn_mob()
	timeout_count += 1

	if timeout_count == 5:
		$MobSpawnTimer.wait_time = 2.5
	if timeout_count == 10:
		$MobSpawnTimer.wait_time = 2
	if timeout_count == 15:
		$MobSpawnTimer.wait_time = 1.5


func spawn_mob():
	var mob = Mob.instantiate()
	mob.position = position
	get_parent().add_child(mob)
	mob.player = player
	step_timer.timeout.connect(mob.move)
	position.x = positionsX[randi() % 4]
