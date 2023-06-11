extends Node3D


@onready var visual_node : Node3D = get_node("Visual_Node")
@export var hand_node : Node3D
@export var raycaster : RayCast3D
var weapons : Array
var current_weapon : Node


func _ready():
	weapons = get_node("Weapons").get_children()
	current_weapon = weapons[0]
	instantiate_weapon_scene(current_weapon.weapon_scene)
	
func _physics_process(delta):
	if current_weapon == null : return
	
	# Call actions for the current weapon
	current_weapon.Action_1()
	current_weapon.Action_2()
	current_weapon.Action_3()
	current_weapon.Action_4()

func instantiate_weapon_scene(weapon : PackedScene):
	var instantiated_scene = weapon.instantiate()
	hand_node.add_child(instantiated_scene)
	current_weapon.animator = instantiated_scene.get_node("Animations")
