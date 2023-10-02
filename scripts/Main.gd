extends Node


var time = 60


func _ready():
	new_game()


func new_game():
	print("Start")
	$Player.start($StartPosition.position)
	$GameTimer.start()
	$StepTimer.start()
	$MobSpawnPoint/MobSpawnTimer.start()
	$Music.play()
	$MobSpawnPoint.spawn_mob()


func stop_game():
	$GameTimer.stop()
	$StepTimer.stop()
	$MobSpawnPoint/MobSpawnTimer.stop()
	$Music.stop()


func game_over():
	print("Game Over")
	stop_game()
	$HUD.show_game_over()
	$DeathSound.play()
	$DeathSound.seek(0.45)
	await get_tree().create_timer(0.5).timeout
	$GameOverMusic.play()


func victory():
	stop_game()
	$HUD.show_victory()
	$VictoryMusic.play()
	await get_tree().create_timer(4).timeout
	$Floppa.show()
	$FloppaSound.play()
	$HUD.hide()


func _on_game_timer_timeout():
	time -= 1

	if time == 0:
		victory()
