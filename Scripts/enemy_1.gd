extends CharacterBody2D

var speed : float = 100
var life = 3
var target = false
var targetBody = null
#@onready var animated_sprite_2d = $AnimatedSprite2D
var animation = false
var attack = false


func attack_player() : 
	for body in $LeftArea.get_overlapping_bodies():
		if(body.get_collision_layer() == 1) :
			if attack == false :
				animation = true
				attack = true
				$AttackTimer.start()
				$HurtSfx.play()
				$AnimatedSprite2D.play("Attack")
				body.take_damage()
				Manager.life -= 1
	for body in $RightArea.get_overlapping_bodies():
		if(body.get_collision_layer() == 1) :
			if attack == false :
				animation = true
				attack = true
				$AttackTimer.start()
				$HurtSfx.play()
				$AnimatedSprite2D.play("Attack")
				body.take_damage()
				Manager.life -= 1


func take_damage():
	if life > 0:
		animation = true
		$AnimatedSprite2D.play("Hurt")
		print ("hurt")
		$HurtSfx.play()



func _on_animated_sprite_2d_animation_finished() -> void:
	if life == 0:
		animation = true
		$AnimatedSprite2D.play("Death")
		$DeathSfx.play()
		$DeathTimer.start()
	else:
		animation = false
		if target :
			$AnimatedSprite2D.play("Run")
		else :
			$AnimatedSprite2D.play("Idle")



func _physics_process(delta):
	if target:
		# ennemi se déplace vers le joueur
		var velocity = global_position.direction_to(targetBody.global_position)
		move_and_collide(velocity * speed * delta)
		if animation == false :
			$AnimatedSprite2D.play("Run")

		# ennemi se retourne selon la position du joueur
		if global_position.x >= targetBody.global_position.x :
			$AnimatedSprite2D.flip_h = false
		if global_position.x <= targetBody.global_position.x :
			$AnimatedSprite2D.flip_h = true
			
		attack_player()
			
	else :
		$AnimatedSprite2D.play("Idle")



func _on_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		target = true
		targetBody = body


		
func _on_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		target = false
		targetBody = null



func _on_death_timer_timeout() -> void:
	queue_free()


	
func _on_attack_timer_timeout() -> void:
	attack = false
	animation = false
