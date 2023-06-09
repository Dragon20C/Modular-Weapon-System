extends CharacterBody3D
class_name Player

var speed : float
const WALK_SPEED : float = 5.0
const SPRINT_SPEED : float = 8.0
const JUMP_VELOCITY : float= 4.8
@export var sensitivity : float = 0.0025

#bob variables
const BOB_FREQ : float = 2.4
const BOB_AMP : float = 0.05
var t_bob : float = 0.0

#fov variables
const BASE_FOV : float = 75.0
const FOV_CHANGE : float = 1.0

@export_group("Node Paths")
# node paths and variables
@export var head_path : NodePath
@export var camera_path : NodePath
@onready var head = get_node(head_path)
@onready var camera = get_node(camera_path)

# player vectors
var mouse_input : Vector2 = Vector2.ZERO
var movement_input : Vector2 = Vector2.ZERO

@export_group("Jump settings")
# Jump variables
@export var time_to_peak: float = 0.30 # Time
@export var jump_height : float = 1.4 # Height
@export var jump_distance: float = 5.2 # Distance

var gravity : float = (jump_height * 2) / pow(time_to_peak,2) #ProjectSettings.get_setting("physics/3d/default_gravity")
var jump_force : float = gravity * time_to_peak
var jump_speed : float = jump_distance / (time_to_peak * 2)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func camera_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	if event is InputEventMouseMotion:
		mouse_input = -event.relative * sensitivity
		head.rotate_y(mouse_input.x )
		camera.rotate_x(mouse_input.y)
		camera.rotation.x = clamp(camera.rotation.x, -PI / 2, PI / 2)

func get_input():
	return Input.get_vector("left", "right", "up", "down")

func Player_Movement(delta):
	movement_input = get_input()
	# Get the input direction and handle the movement/deceleration.
	
	var direction = (head.transform.basis * Vector3(movement_input.x, 0, movement_input.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		# keep distance if sprinting else reduce distance
		var result = 1.0 if speed == SPRINT_SPEED else 0.6
		velocity.x = lerp(velocity.x, direction.x * (jump_speed * result), delta * 4.0)
		velocity.z = lerp(velocity.z, direction.z * (jump_speed * result), delta * 4.0)
	
	# Head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	# FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, WALK_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	#print(target_fov)
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	move_and_slide()


func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
