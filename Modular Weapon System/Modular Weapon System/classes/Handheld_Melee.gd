class_name Handheld_Melee
extends Handheld_Weapon

@export_group("Melee")
@export var melee_speed : float


func actions():
	if Input.is_action_just_pressed("Left_Click"):
		animator.seek(0)
		animator.play("Slash")
		print("STAB!")

func on_enter():
	# Play enter animations and maybe also set any variables
	
	animator.play("BringIn")
	print("Bring melee weapon in!")

func on_exit():
	# Play exit animations and clear up anything left
	print("Putting melee weapon away...")
	animator.play("PutAway")
