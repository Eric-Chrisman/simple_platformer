extends ParallaxLayer

@export var hor_speed: float = 30
@export var ver_speed: float = 10

func _process(delta: float) -> void:
	motion_offset.x += hor_speed * delta
	motion_offset.y += ver_speed * delta
