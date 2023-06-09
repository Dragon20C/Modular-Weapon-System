extends PlayerState

@export_group("Slide Settings")
@export var timer_path : NodePath
@onready var Slide_timer = get_node(timer_path)
@export var slide_duration : float = 0.55
@export var slide_speed : float = 12.0
var slide_vector : Vector3 = Vector3.ZERO
# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(event: InputEvent) -> void:
	player.camera_input(event)


# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(delta: float) -> void:
	
	if not player.is_on_floor():
		player.velocity.y -= (player.gravity / 4) * delta
		
	player.velocity.x = lerp(player.velocity.x, slide_vector.x * slide_speed, delta * 7.0)
	player.velocity.z = lerp(player.velocity.z, slide_vector.z * slide_speed, delta * 7.0)
	player.move_and_slide()

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	slide_vector = get_forward_direction()
	Slide_timer.wait_time = slide_duration
	Slide_timer.start()
	

# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass

func slide_finished():
	print("Slide finished")
	
	var check_input = player.get_input()
	if check_input != Vector2.ZERO and not Input.is_action_pressed("sprint"):
		state_machine.transition_to("Walk")
	elif check_input != Vector2.ZERO and Input.is_action_pressed("sprint"):
		state_machine.transition_to("Run")
	else:
		state_machine.transition_to("Idle")

func get_forward_direction():
	var offsetDistance = 2  # Adjust this value as needed
	var forwardDirection = player.head.transform.basis.z - (player.head.transform.basis.z * offsetDistance)
		
	return forwardDirection
