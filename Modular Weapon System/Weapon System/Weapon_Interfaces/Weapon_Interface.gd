class_name Weapon_Interface extends Node



@export var weapon_scene : PackedScene
@onready var weapon_system = get_parent().get_parent()
@onready var raycaster : RayCast3D = weapon_system.raycaster
var animator : AnimationPlayer
#@onready var visual_node : Node3D = get_parent().get_parent().find_child("Visual_Node")

# Use this to disable an action when needed for example reloading we dont want to shoot so disable it.
var action_1_state : bool = true
var action_2_state : bool = true
var action_3_state : bool = true
var action_4_state : bool = true

func _ready() -> void:
	pass

# These are input actions, each action should have a seperate input
# Example guns would have a shoot, reload and aim.

func Action_1() -> void:
	if not action_1_state: return
	
func Action_2() -> void:
	if not action_2_state: return
	
func Action_3() -> void:
	if not action_3_state: return

func Action_4() -> void:
	if not action_4_state: return
