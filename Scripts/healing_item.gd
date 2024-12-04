extends Area2D

func _process(delta: float) -> void:
	$AnimatedSprite2D.play("default")

func _on_body_entered(body: Node2D) -> void:
	$ItemGetSfx.play()
	if Manager.life < 3 :
		Manager.life += 1
	queue_free()
