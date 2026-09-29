extends Camera2D
class_name PlayerCamera

@export var character_to_follow: CharacterBody2D
@export var look_ahead_factor: float = 0.2
@export var smooth_speed: float = 5.0
@export var max_look_ahead_distance: float = 120.0

func _physics_process(delta: float) -> void:
	if not character_to_follow:
		return

	# Calculate lead vector bounded to prevent excessive displacement
	var lead_offset: Vector2 = character_to_follow.velocity * look_ahead_factor
	lead_offset = lead_offset.limit_length(max_look_ahead_distance)
	
	var target_position: Vector2 = character_to_follow.global_position + lead_offset
	
	# Smoothly interpolate position to minimize eye fatigue and motion sickness
	global_position = global_position.lerp(target_position, 1.0 - exp(-smooth_speed * delta))
