extends Node2D

var enemyNode = preload("res://Scenes/enemy_1.tscn")


func _ready() -> void:
	pass
	#new_instance(enemyNode, Vector2(0,0))


func _physics_process(delta: float) -> void:
	pass
	
	
func new_instance(node, pos):
	var instance = node.instantiate()
	instance.position = pos
	add_child(instance)
