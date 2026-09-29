extends CharacterBody2D

enum PLAYER_STATES {
	GROUND = 1,
	JUMPING = 2,
	DOUBLE_JUMPING = 3,
	DEAD = 4
}

@export var speed: float = 100
@export var jump_power: float = 300
@export var can_double_jump: bool = true

@onready var animation_node = %Animation

var current_player_state: PLAYER_STATES = PLAYER_STATES.GROUND

func _physics_process(_delta: float) -> void:
	if current_player_state == PLAYER_STATES.DEAD:
		return
	
	var movement_direction: int = 0
	if Input.is_action_pressed("left"):
		movement_direction -= 1
	if Input.is_action_pressed("right"):
		movement_direction += 1
	velocity.x = movement_direction * speed
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jump_power
			animation_node.play("jump")
			current_player_state = PLAYER_STATES.JUMPING
		else:
			current_player_state = PLAYER_STATES.GROUND
			if movement_direction == 0:
				animation_node.play("idle")
			else:
				animation_node.play("run")
	
	else:
		if (Input.is_action_just_pressed("jump")
			and can_double_jump
			and current_player_state != PLAYER_STATES.DOUBLE_JUMPING):
			velocity.y = -jump_power
			current_player_state = PLAYER_STATES.DOUBLE_JUMPING
			animation_node.play("double_jump")
		velocity.y += 9.8
		if velocity.y > 0 and current_player_state != PLAYER_STATES.DOUBLE_JUMPING:
			animation_node.play("fall")
	
	if velocity.x < 0:
		animation_node.flip_h = true
	elif velocity.x > 0:
		animation_node.flip_h = false
	
	move_and_slide()
