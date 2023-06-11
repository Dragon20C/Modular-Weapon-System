class_name Weapon_Data extends Resource

@export_group("Default")
@export var weapon_name : String
var animator : AnimationPlayer
@export var min_damage : int
@export var max_damage : int
@export_range(0,100) var waight_modifier : float
