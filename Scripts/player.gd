extends CharacterBody2D

var speed : float = 250
var isPunching = false
var isHurt = false


func handleInput():
	var moveDirection = Input.get_vector("left","right","up","down")
	velocity = moveDirection * speed
	
	
	# Gestion du coup de poing 
	if Input.is_action_just_pressed("punch") :
		isPunching = true
		$AnimatedSprite2D.play("Punch")
		$AudioStreamPlayer.play()
		
		if $AnimatedSprite2D.flip_h == false :
			for body in $RightFist.get_overlapping_bodies():
				if(body.get_collision_layer() == 2):
					body.take_damage()
					body.life -= 1
					
		if $AnimatedSprite2D.flip_h == true :
			for body in $LeftFist.get_overlapping_bodies():
				if(body.get_collision_layer() == 2):
					body.take_damage()
					body.life -= 1
			
	
	# Gestion du déplacement
	elif not Input.is_action_just_pressed("punch") :
		if not isPunching and not isHurt :
			if moveDirection.x == 0 && moveDirection.y == 0 :
				$AnimatedSprite2D.play("Idle")
			else:
				$AnimatedSprite2D.play("Run")
		elif isPunching and moveDirection.x != 0 && moveDirection.y != 0 :
			$AnimatedSprite2D.play("Run")
	
		
	
	# flipper la sprite si on se déplace vers la droite
	if moveDirection.x > 0: 
		$AnimatedSprite2D.flip_h = false
	if moveDirection.x < 0:
		$AnimatedSprite2D.flip_h = true



func _physics_process(delta):
	handleInput()
	move_and_slide()



func _on_animated_sprite_2d_animation_finished() -> void:
	isPunching = false
	
	if Manager.life == 0 : 
		get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")
	elif Manager.life > 0 and isHurt :
		$AnimatedSprite2D.play("Hurt")
		isHurt = false
	else : 
		$AnimatedSprite2D.play("Idle")



func take_damage() :
	isHurt = true
	isPunching = false
	$AnimatedSprite2D.play("Hurt")
