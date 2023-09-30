class_name Weapon_Interface extends Node

# Here we should store things multiple weapons could reuse like raycaster.
@export var weapon_scene : PackedScene
@export var weapon_data : Weapon_Data
@onready var weapon_system = get_parent().get_parent()
@onready var raycaster : RayCast3D = weapon_system.raycaster
@export var sounds : Dictionary
var sound_position : Marker3D
var animator : AnimationPlayer
var busy : bool = false

# Can use the ready function to set up variables that change dynamicly.
# Example a guns current ammo count.
func _ready() -> void:
	pass

# These actions are what allows the weapon to have Input.
# Currently only have 4 but if a weapon needs more I can just add more.
func Action_1() -> void:
	if busy: return
	
func Action_2() -> void:
	if busy: return
	
func Action_3() -> void:
	if busy: return

func Action_4() -> void:
	if busy: return
