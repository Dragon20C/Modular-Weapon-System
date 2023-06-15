class_name Gun_Interface extends Weapon_Interface

@export var fire_timer : Timer
@onready var rate_of_fire : float = 1.0 / (weapon_data.rpm / 60.0)
@onready var current_magazine : int = weapon_data.magazine_max
var bullet_decal = preload("res://BulletDecal/Scripts and scenes/bullet_decal.tscn")

func _ready() -> void:
	randomize()
	fire_timer.wait_time = rate_of_fire

func Action_1() -> void:
	if not action_1_state: return
	
	if weapon_data.action_type == 1:
		if Input.is_action_pressed("Left_Click") and fire_timer.is_stopped():
			shoot()
	elif weapon_data.action_type == 2:
		if Input.is_action_just_pressed("Left_Click") and fire_timer.is_stopped():
			shoot()
	elif weapon_data.action_type == 4:
		if Input.is_action_just_pressed("Left_Click") and not animator.is_playing():
			shotgun_shoot()
	
func Action_2() -> void:
	if not action_2_state: return
	if Input.is_action_just_pressed("R_key"):
		reload()
	
func Action_3() -> void:
	if not action_3_state: return

func Action_4() -> void:
	if not action_4_state: return

func shoot():
	if current_magazine > 0:
		current_magazine -= 1
		fire_timer.start()
		animator.seek(0)
		animator.play("Shoot")
		print(current_magazine)
		raycaster.force_raycast_update()
		if raycaster.is_colliding():
			spawn_decal(raycaster.get_collision_point(),raycaster.get_collision_normal())
	else:
		reload()

func shotgun_shoot():
	if current_magazine > 0:
		animator.play("Shoot")
		current_magazine -= 1
		print(current_magazine)
		var angle = weapon_data.spread_angle
		for pellet in weapon_data.pellets:
			var spread : Vector2 = Vector2(randi_range(-angle,angle),randi_range(-angle,angle))
			raycaster.rotate_x(deg_to_rad(spread.x))
			raycaster.rotate_y(deg_to_rad(spread.y))
			raycaster.force_raycast_update()
			if raycaster.is_colliding():
				spawn_decal(raycaster.get_collision_point(),raycaster.get_collision_normal())
		raycaster.rotation = Vector3.ZERO
	
func reload():
	weapon_system.disable_actions = true
	if current_magazine == weapon_data.magazine_max: return
	print("reloading!")
	animator.play("Reload")
	action_2_state = false
	action_1_state = false
	await animator.animation_finished
	replenish_ammo()
	weapon_system.disable_actions = false

func replenish_ammo():
	action_1_state = true
	action_2_state = true
	print("reload finished!")
	current_magazine = weapon_data.magazine_max

func spawn_decal(position: Vector3, normal: Vector3):
	var decal = bullet_decal.instantiate()
	get_tree().get_root().add_child(decal)
	decal.global_transform.origin = position
	
	# Check if normal is not down or up then we do look at
	if normal != Vector3.UP and normal != Vector3.DOWN:
		decal.look_at(position + normal,Vector3.UP)
		decal.transform = decal.transform.rotated_local(Vector3.RIGHT, PI/2.0)
	# Else we check if its up and we do a 180 to get it to rotate correctly!
	elif normal == Vector3.UP:
		decal.transform = decal.transform.rotated_local(Vector3.RIGHT, PI)
		
	decal.rotate(normal, randf_range(0, 2*PI))
	
	get_tree().create_timer(5).timeout.connect(func destory_decal(): decal.queue_free())
