extends Area2D

@export var speed: float = 2000.0

var direction: Vector2 = Vector2.RIGHT


func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("zombiee"):
		body.queue_free()
		queue_free()
