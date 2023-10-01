extends CanvasLayer


func show_game_over():
	$GameOverMessage.show()
	await get_tree().create_timer(3.0).timeout
	$RestartButton.show()


func _on_restart_button_pressed():
	get_tree().reload_current_scene()
