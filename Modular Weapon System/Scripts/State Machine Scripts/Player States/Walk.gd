extends PlayerState


# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(event: InputEvent) -> void:
	player.camera_input(event)


# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(delta: float) -> void:
	player.Player_Movement(delta)
	
	if !player.is_on_floor():
		state_machine.transition_to("Air")
	elif player.movement_input == Vector2.ZERO:
		state_machine.transition_to("Idle")
	elif player.movement_input !=  Vector2.ZERO and Input.is_action_pressed("sprint"):
		state_machine.transition_to("Run")
	elif Input.is_action_just_pressed("jump") and player.is_on_floor():
		state_machine.transition_to("Air",{jump = true})
	


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	player.speed = player.WALK_SPEED


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass
