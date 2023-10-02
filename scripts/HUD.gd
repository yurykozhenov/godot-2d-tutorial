extends CanvasLayer


var time = 60


func show_game_over():
	$Message.show()
	await get_tree().create_timer(3.0).timeout
	$RestartButton.show()


func show_victory():
	$Message.text = "Victory!"
	$Message.show()


func _on_restart_button_pressed():
	get_tree().reload_current_scene()


func _on_game_timer_timeout():
	time -= 1
	$Time.text = String.num(time)
