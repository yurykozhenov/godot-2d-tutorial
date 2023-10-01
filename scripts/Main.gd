extends Node


func _ready():
	new_game()


func new_game():
	$Player.start($StartPosition.position)
	$StepTimer.start()
	$MobSpawnPoint/MobSpawnTimer.start()
	$Music.play()
	$MobSpawnPoint.spawn_mob()


func game_over():
	print("Game Over")
	$StepTimer.stop()
	$MobSpawnPoint/MobSpawnTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	$MobSpawnPoint.spawn_mob()
