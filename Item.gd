extends "ZSortedSprite.gd"

onready var velocity:Vector2

func _ready():
	set_meta("in_inv", false)

func _process(delta):
	velocity = lerp(velocity, Vector2.ZERO, 0.01)

func push(vel):
	velocity = vel
