class_name Weapon_System extends Node3D

# Can store variables from the player here and transfer to the weapons if needed.
var weapon_hidden : bool = false
@onready var hand_node : Node3D = get_node("Hand")
@onready var hand_animations : AnimationPlayer = get_node("AnimationPlayer")
@export var raycaster : RayCast3D
# Get available children from the weapons node.
var weapons : Array
# Set the first child to current weapon.
var current_weapon : Node
var weapon_index : int = 0
var disable_actions : bool = false


func _ready():
	weapons = get_node("Weapons").get_children()
	switch_weapon(weapons[weapon_index])
	
func _input(event):
	if event.is_action_pressed("Scroll_up") and not disable_actions:
		weapon_index = min(weapon_index+1,weapons.size()-1)
		switch_weapon(weapons[weapon_index])

	elif event.is_action_pressed("Scroll_down") and not disable_actions:
		weapon_index = max(weapon_index-1,0)
		switch_weapon(weapons[weapon_index])
	
func _physics_process(_delta):
	# This is for putting the weapons away.
	if Input.is_action_just_pressed("Q_key") and !hand_animations.is_playing():
		# we swap the bool depending if we want to take or put away
		weapon_hidden = !weapon_hidden
		
		# check witch state we are in
		if weapon_hidden:
			disable_actions = true
			put_away_weapon()
		else:
			disable_actions = false
			take_weapon()
			

	
	if current_weapon == null : return
	
	# Call actions for the current weapon
	if not disable_actions:
		current_weapon.Action_1()
		current_weapon.Action_2()
		current_weapon.Action_3()
		current_weapon.Action_4()

func switch_weapon(weapon : Weapon_Interface):
	if current_weapon == weapon: return
	disable_actions = true
	
	if current_weapon != null:
		hand_animations.speed_scale = current_weapon.weapon_data.transition_speed
		hand_animations.play("Unequip_weapon")
		await hand_animations.animation_finished
		hand_node.get_child(0).queue_free()
		
	current_weapon = weapon
	instantiate_weapon_scene(current_weapon.weapon_scene)
	hand_animations.speed_scale = current_weapon.weapon_data.transition_speed
	hand_animations.play("Equip_weapon")
	await hand_animations.animation_finished
	disable_actions = false
	
func instantiate_weapon_scene(weapon : PackedScene):
	var instantiated_scene = weapon.instantiate()
	# Hand node is the visual node for the models.
	hand_node.add_child(instantiated_scene)
	# Set the animationplayer from the scene to the current weapon.
	current_weapon.animator = instantiated_scene.get_node("Animations")
	current_weapon.sound_position = instantiated_scene.get_node("SoundPosition")

func put_away_weapon():
	#hand_animations.speed_scale = current_weapon.weapon_data.transition_speed
	current_weapon.busy = true
	hand_animations.play("Unequip_weapon")
	await hand_animations.animation_finished
	hand_node.visible = false

func take_weapon():
	#hand_animations.speed_scale = current_weapon.weapon_data.transition_speed
	
	hand_node.visible = true
	hand_animations.play("Equip_weapon")
	await hand_animations.animation_finished
	current_weapon.busy = false
