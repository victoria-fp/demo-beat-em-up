extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level.tscn")


func _on_button_3_pressed() -> void:
	queue_free()
