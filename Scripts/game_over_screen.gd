extends CanvasLayer


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
	Manager.life = 3


func _on_quit_pressed() -> void:
	get_tree().quit()
