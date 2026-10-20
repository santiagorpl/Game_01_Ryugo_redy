extends CanvasLayer

func _on_button_pressed() -> void:
	queue_free() # Menghapus PapanUI beserta semua isinya saat tombol diklik
