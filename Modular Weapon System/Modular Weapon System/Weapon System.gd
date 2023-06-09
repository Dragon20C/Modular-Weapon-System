class_name Weapon_System
extends Node

@export var action_timer : Timer
@export var raycaster : RayCast3D

@export var hand_node : Node3D
@export var weapon_inventory : Array[Handheld_Weapon]
var inventory_index = 0
var current_weapon : Handheld_Weapon

# This script will hold the weapons and do the switching of weapons and drop and pick ups as well.

func _ready():
	# Switch to the first weapon in the inventory
	switch_to_weapon(weapon_inventory[inventory_index])


func _input(event):
	if event.is_action_pressed("Scroll_up"):
		inventory_index = min(inventory_index+1,weapon_inventory.size()-1)
		switch_to_weapon(weapon_inventory[inventory_index])
		
	elif event.is_action_pressed("Scroll_down"):
		inventory_index = max(inventory_index-1,0)
		switch_to_weapon(weapon_inventory[inventory_index])
		
func switch_to_weapon(weapon):
	# Check if we are not switching to the same weapon
	if current_weapon == weapon: return
	# Check for the start of the scene, and play exit function
	if current_weapon != null:
		current_weapon.on_exit()
		await current_weapon.animator.animation_finished
		# Delete current weapon model when animation is finished.
		hand_node.get_child(0).queue_free()
	# set our selfs to the weapon so it can access raycasts etc
	weapon.weapon_system = self
	# set current weapon to weapon
	current_weapon = weapon
	# instance the model which should also have animations to it.
	var instance = current_weapon.weapon_scene.instantiate()
	hand_node.add_child(instance)
	current_weapon.animator = instance.get_node("Animations")
	# Play on enter of current Weapon
	current_weapon.on_enter()
	# Wait for animation to finish
	await current_weapon.animator.animation_finished

func _physics_process(_delta) -> void:
	# to avoid errors we wait until its not null.
	if current_weapon != null:
		# We play every unqiue action the weapon holds.
		current_weapon.actions()
