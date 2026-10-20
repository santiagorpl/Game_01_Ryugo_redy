extends Area2D

# Path to your end game scene
const END_GAME_SCENE = "res://end_gam.tscn"

func _ready() -> void:
	# Connect the signal dynamically if you haven't done it via the editor UI
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# Check if the colliding body is the Player. 
	# Replace "Player" with your exact player script name or node name.
	if body.name == "Player" or body.is_in_group("player"):
		# Change to the target scene
		var error = get_tree().change_scene_to_file(END_GAME_SCENE)
		
		# Optional: Error handling to catch typos in file paths
		if error != OK:
			print("Error: Could not load scene ", END_GAME_SCENE)
