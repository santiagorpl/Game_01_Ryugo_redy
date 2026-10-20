extends CharacterBody2D

const SPEED = 150.0

var player: Node2D = null

func _ready() -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

func _physics_process(_delta: float) -> void:
	# Jika player belum ditemukan, cari lagi di group
	if player == null:
		var players = get_tree().get_nodes_in_group("player")
		if players.size() > 0:
			player = players[0]
		return

	# Zombie langsung mengejar ke posisi player
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * SPEED

	move_and_slide()
