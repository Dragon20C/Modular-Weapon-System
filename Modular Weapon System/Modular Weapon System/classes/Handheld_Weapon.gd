class_name Handheld_Weapon
extends Resource

@export_group("Default")
@export var weapon_name : String
@export var weapon_scene : PackedScene
var animator : AnimationPlayer
@export var min_damage : int
@export var max_damage : int
@export_range(0,100) var waight_modifier : float

# Use this to get raycasts or other nodes that this resource could use!
var weapon_system : Weapon_System

func actions():
	# Create inputs for each weapon.
	pass

func on_enter():
	# Play enter animations and maybe also set any variables
	pass

func on_exit():
	# Play exit animations and clear up anything left
	pass
