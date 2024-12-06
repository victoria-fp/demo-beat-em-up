extends Node2D

var enemyNode = preload("res://Scenes/enemy_1.tscn")


func _ready() -> void:
	$CanvasLayer/GoSign.visible = false


func _physics_process(delta: float) -> void:
	if Manager.enemiesDefeated >= Manager.enemyAmount and Manager.enemiesDefeated > 0 :
		$TileMapLayer2.set_enabled(false)
		$CanvasLayer/GoSign.visible = true
	elif Manager.enemiesDefeated < Manager.enemyAmount : 
		$TileMapLayer2.set_enabled(true)
		$CanvasLayer/GoSign.visible = false



func new_instance(node, pos):
	var instance = node.instantiate()
	instance.position = pos
	call_deferred("add_child", instance)
	Manager.enemyAmount += 1


# Zone 1
func _on_area_1_body_entered(body: Node2D) -> void:
	Manager.enemiesDefeated = 0
	new_instance(enemyNode, Vector2(500,445))
	new_instance(enemyNode, Vector2(1000,590))

func _on_area_1_body_exited(body: Node2D) -> void:
	Manager.enemyAmount = 0



# Zone 2
func _on_area_2_body_entered(body: Node2D) -> void:
	Manager.enemiesDefeated = 0
	new_instance(enemyNode, Vector2(1860,620))
	new_instance(enemyNode, Vector2(2000,430))
	new_instance(enemyNode, Vector2(2200,560))

func _on_area_2_body_exited(body: Node2D) -> void:
	Manager.enemyAmount = 0
