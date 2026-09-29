extends Node2D
class_name Fire_Block

enum FIRE_BLOCK_STATES {
	IDLE = 1,
	SHOOTING_FIRE = 2
}

@export var current_state: FIRE_BLOCK_STATES = FIRE_BLOCK_STATES.IDLE
@export var idle_time: float = 4.0
@export var shooting_fire_time: float = 3.0

@onready var idle_timer: Timer = %OnTimer
@onready var shooting_fire_timer: Timer = %OffTimer
@onready var animation_node: AnimatedSprite2D = %Animations
@onready var hit_box: Area2D = %FireHitBox

func _ready() -> void:
	# setting up a state machine by using timers
	idle_timer.wait_time = idle_time
	idle_timer.timeout.connect(update_state.bind(FIRE_BLOCK_STATES.SHOOTING_FIRE))
	
	shooting_fire_timer.wait_time = shooting_fire_time
	shooting_fire_timer.timeout.connect(update_state.bind(FIRE_BLOCK_STATES.IDLE))
	
	update_state(current_state)

func update_state(new_state: FIRE_BLOCK_STATES) -> void:
	print(new_state)
	current_state = new_state
	match current_state:
		FIRE_BLOCK_STATES.IDLE:
			shooting_fire_timer.stop()
			idle_timer.start()
			hit_box.monitorable = false
			animation_node.play("off")
		
		FIRE_BLOCK_STATES.SHOOTING_FIRE:
			shooting_fire_timer.start()
			idle_timer.stop()
			hit_box.monitorable = true
			animation_node.play("shooting_fire")
