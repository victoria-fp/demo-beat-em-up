extends Area2D

func _process(delta: float) -> void:
	$AnimatedSprite2D.play("default")

func _on_body_entered(body: Node2D) -> void:
	queue_free()
