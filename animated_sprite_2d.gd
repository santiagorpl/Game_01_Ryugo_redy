extends CharacterBody2D

@export var speed = 100.0
var mulai_mengejar = true

@onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	if mulai_mengejar:
		var arah = global_position.direction_to(player.global_position)
		velocity = arah * speed
		move_and_slide()
