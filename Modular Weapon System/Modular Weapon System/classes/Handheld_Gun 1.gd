class_name Gun_0000
extends Weapon


@export_group("Gun")
@export_flags ("Automatic", "Semi-automatic") var action_type = 0
@export var ammo_capacity : int
@export var magazine_max : int
@export var current_magazine : int
@export var rpm : int
var rate_of_fire : float
@export var reload_speed : float
@export var bullet_decal : PackedScene

# Create inputs for each weapon.
func actions():
	if action_type == 1:
		if Input.is_action_pressed("Left_Click") and weapon_system.action_timer.is_stopped():
			weapon_system.action_timer.start()
			shoot()
	elif action_type == 2:
		if Input.is_action_just_pressed("Left_Click"):
			shoot()
		
	if Input.is_action_just_pressed("R_key"):
		current_magazine = magazine_max
		print("Reloading!")

func shoot():
	if current_magazine > 0:
		current_magazine -= 1
		print("you have " + str(current_magazine) + " rounds left")
		check_raycast()
	else:
		print("Out of ammo!")
		
	animator.seek(0)
	animator.play("Shoot")
	print("Bang!")

func check_raycast():
	var raycast = weapon_system.raycaster
	if raycast.is_colliding():
		var point = raycast.get_collision_point()
		var normal = raycast.get_collision_normal()
		spawn_decal(point,normal)

func spawn_decal(position: Vector3, normal: Vector3):
	var decal = bullet_decal.instantiate()
	weapon_system.get_tree().get_root().add_child(decal)
	decal.global_transform.origin = position
	
	# Check if normal is not down or up then we do look at
	if normal != Vector3.UP and normal != Vector3.DOWN:
		decal.look_at(position + normal,Vector3.UP)
		decal.transform = decal.transform.rotated_local(Vector3.RIGHT, PI/2.0)
	# Else we check if its up and we do a 180 to get it to rotate correctly!
	elif normal == Vector3.UP:
		decal.transform = decal.transform.rotated_local(Vector3.RIGHT, PI)
		
	decal.rotate(normal, randf_range(0, 2*PI))
	
	weapon_system.get_tree().create_timer(5).timeout.connect(func destory_decal(): decal.queue_free())

func on_enter():
	# Play enter animations and maybe also set any variables
	rate_of_fire = 1.0 / (rpm / 60.0)
	weapon_system.action_timer.wait_time = rate_of_fire
	animator.play("BringIn")
	print("Bring " + weapon_name + " in!")

func on_exit():
	# Play exit animations and clear up anything left
	print("Putting " + weapon_name + " away...")
	animator.play("PutAway")
