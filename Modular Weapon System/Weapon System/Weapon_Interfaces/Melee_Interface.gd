class_name Melee_Interface extends Weapon_Interface



func _ready() -> void:
	pass

func Action_1() -> void:
	if not action_1_state: return
	
	if Input.is_action_just_pressed("Left_Click"):
		animator.seek(0)
		animator.play("Slash")
		print("STAB!")
	
func Action_2() -> void:
	if not action_2_state: return
	
func Action_3() -> void:
	if not action_3_state: return

func Action_4() -> void:
	if not action_4_state: return
