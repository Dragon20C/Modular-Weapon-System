class_name Weapon_Interface extends Node

# Here we should store things multiple weapons could reuse like raycaster.
@export var weapon_scene : PackedScene
@export var weapon_data : Weapon_Data
@onready var weapon_system = get_parent().get_parent()
@onready var raycaster : RayCast3D = weapon_system.raycaster
var audio_player : AudioStreamPlayer3D
var animator : AnimationPlayer

# I can use these to disable a state to avoid doing multiple inputs when one is required.
# Example when reloading, shooting shouldnt happen.
var action_1_state : bool = true
var action_2_state : bool = true
var action_3_state : bool = true
var action_4_state : bool = true

# Can use the ready function to set up variables that change dynamicly.
# Example a guns current ammo count.
func _ready() -> void:
	pass

# These actions are what allows the weapon to have Input.
# Currently only have 4 but if a weapon needs more I can just add more.
func Action_1() -> void:
	if not action_1_state: return
	
func Action_2() -> void:
	if not action_2_state: return
	
func Action_3() -> void:
	if not action_3_state: return

func Action_4() -> void:
	if not action_4_state: return
