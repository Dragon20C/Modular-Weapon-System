extends Decal

@onready var dust_emiiter = get_node("BulletImpact")
# Called when the node enters the scene tree for the first time.
func _ready():
	dust_emiiter.emitting = true
