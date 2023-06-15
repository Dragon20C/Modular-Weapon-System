class_name Gun_Data extends Weapon_Data

@export_group("Gun")
@export_flags ("Automatic", "Semi-automatic", "Shotgun") var action_type = 0
@export var ammo_capacity : int
@export var magazine_max : int
@export var rpm : float
@export var reload_speed : float

@export_group("Shotgun")
@export var max_range : int
@export var pellets : int
@export var spread_angle : float
