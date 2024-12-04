extends Control


func _process(delta: float) -> void:
	match Manager.life : 
		3:
			$AnimatedSprite2D.play("3")
		2:
			$AnimatedSprite2D.play("2")
		1:
			$AnimatedSprite2D.play("1")
		0:
			$AnimatedSprite2D.play("0")
