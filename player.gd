extends CharacterBody2D

@onready var shoot_audio: AudioStreamPlayer = $ShootAudio

# Kecepatan gerak karakter
@export var speed: float = 800.0

# Scene peluru
@export var bullet_scene: PackedScene

# Node reference ke AnimatedSprite2D
@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Titik keluarnya peluru
@onready var shoot_point: Marker2D = $ShootPoint

var last_direction: Vector2 = Vector2.DOWN


func _physics_process(_delta: float) -> void:
	# Menggunakan "left", "right", "up", "down" agar terbaca oleh Joystick & Keyboard sekaligus
	var input_vector := Input.get_vector("left", "right", "up", "down")

	if input_vector != Vector2.ZERO:
		velocity = input_vector * speed
		last_direction = input_vector
		play_walk_animation(input_vector)
	else:
		velocity = Vector2.ZERO
		play_idle_animation()

	move_and_slide()


func play_walk_animation(dir: Vector2) -> void:
	if abs(dir.y) >= abs(dir.x):
		if dir.y < 0:
			_animated_sprite.play("atas")
		else:
			_animated_sprite.play("bawah")
	else:
		if dir.x < 0:
			_animated_sprite.play("kiri")
		else:
			_animated_sprite.play("kanan")


# Fungsi untuk memutar animasi idle
func play_idle_animation() -> void:
	_animated_sprite.play("idle")


# =========================
# SISTEM MENEMBAK
# =========================

func _input(event: InputEvent) -> void:
	# Tembak menggunakan tombol Keyboard (SPACE)
	if event is InputEventKey:
		if event.keycode == KEY_SPACE and event.pressed and not event.is_echo():
			shoot()
			
	# Tembak menggunakan tombol Virtual Button / Touchscreen
	if event.is_action_pressed("shoot"):
		shoot()


func shoot() -> void:
	# Memutar suara tembakan
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = load("res://lagu/TEMBAK.wav")
	audio_player.bus = "SFX"
	get_tree().current_scene.add_child(audio_player)
	audio_player.play()

	# POTONG SUARA: Hentikan & hapus audio setelah 0.3 detik
	get_tree().create_timer(0.3).timeout.connect(func():
		if is_instance_valid(audio_player):
			audio_player.stop()
			audio_player.queue_free()
	)

	if bullet_scene == null:
		print("Bullet Scene belum dipasang!")
		return

	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = shoot_point.global_position
	bullet.direction = last_direction.normalized()

func _on_shoot_button_pressed() -> void:
	shoot()
