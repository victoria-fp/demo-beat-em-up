extends Area2D

func _process(delta: float) -> void:
	$AnimatedSprite2D.play("default")

func _on_body_entered(body: Node2D) -> void:
	if Manager.life < 3 :
		Manager.life += 1
	$ItemGetTimer.start()
	$ItemGetSfx.play()


func _on_item_get_timer_timeout() -> void:
	queue_free()
