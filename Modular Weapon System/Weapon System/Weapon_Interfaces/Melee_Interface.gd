class_name Melee_Interface extends Weapon_Interface


func _ready() -> void:
	pass

func Action_1() -> void:
	if not action_1_state: return
	
	if Input.is_action_pressed("Left_Click") and not animator.is_playing():
		var list_of_animations = animator.get_animation_list()
		var choice = randi_range(0,list_of_animations.size() - 1)
		animator.play(list_of_animations[choice])
		play_sound()
		print("STAB!")
	
func Action_2() -> void:
	if not action_2_state: return
	
func Action_3() -> void:
	if not action_3_state: return

func Action_4() -> void:
	if not action_4_state: return

func play_sound():
	var audio_player : AudioStreamPlayer3D = AudioStreamPlayer3D.new()
	#var random_index : int = randi_range(0,footstep_sounds.size() - 1)
	audio_player.stream = sounds["Slash"]
	audio_player.pitch_scale = randf_range(0.8,1.2)
	sound_position.add_child(audio_player)
	audio_player.play()
	audio_player.finished.connect(func destory(): audio_player.queue_free())
