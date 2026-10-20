extends Node2D

# Fungsi ini akan berjalan otomatis setelah kamu hubungkan signal pressed() dari Button
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
