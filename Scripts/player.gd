extends CharacterBody2D

var speed : float = 250
var punch = false
var hurt = false


func handleInput():
	var moveDirection = Input.get_vector("left","right","up","down")
	velocity = moveDirection * speed
	
	
	# Gestion du coup de poing 
	if Input.is_action_just_pressed("punch") :
		punch = true
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
	elif not Input.is_action_just_pressed("punch") and not punch :
		if moveDirection.x == 0 && moveDirection.y == 0 :
			$AnimatedSprite2D.play("Idle")
		else:
			$AnimatedSprite2D.play("Run")
		
	
	# flipper la sprite si on se déplace vers la droite
	if moveDirection.x > 0: 
		$AnimatedSprite2D.flip_h = false	
	if moveDirection.x < 0:
		$AnimatedSprite2D.flip_h = true


	# animations plus fluides
	if Input.is_action_just_released("left") :
		$AnimatedSprite2D.play("Idle")
	if Input.is_action_just_released("right") :
		$AnimatedSprite2D.play("Idle")
	if Input.is_action_just_released("up") :
		$AnimatedSprite2D.play("Idle")
	if Input.is_action_just_released("down") :
		$AnimatedSprite2D.play("Idle")



func _physics_process(delta):
	handleInput()
	move_and_slide()


	
func _on_animated_sprite_2d_animation_finished() -> void:
	if Manager.life <= 0 : 
		get_tree().quit()
	else :
		$AnimatedSprite2D.play("Idle")
		punch = false
		hurt = false



func take_damage() :
	hurt = true
	punch = true
	$AnimatedSprite2D.play("Hurt")
