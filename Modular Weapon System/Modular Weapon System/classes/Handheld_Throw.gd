class_name Handheld_Throw
extends Handheld_Weapon

@export_group("Throw")
@export var throw_range : int
@export var throw_speed : float


func actions():
	# Create inputs for each weapon.
	pass

func on_enter():
	# Play enter animations and maybe also set any variables
	pass

func on_exit():
	# Play exit animations and clear up anything left
	pass
