extends Node2D

@export var zombie_scene: PackedScene

func _ready() -> void:
	spawn_zombie($SpawnPoint1)
	spawn_zombie($SpawnPoint2)
	spawn_zombie($SpawnPoint3)
	spawn_zombie($SpawnPoint4)
	spawn_zombie($SpawnPoint5)

func spawn_zombie(spawn_point: Marker2D) -> void:
	print(spawn_point.name, " GLOBAL: ", spawn_point.global_position)

	var zombie = zombie_scene.instantiate()

	print("Zombie instance: ", zombie)
	print("Zombie scene: ", zombie_scene)

	get_parent().add_child(zombie)

	zombie.global_position = spawn_point.global_position

	print("Zombie dibuat di: ", zombie.global_position)
