extends Sprite

onready var frames = 0

func _process(delta):
	frames += 1
	offset.y = sin(frames / 5) * 2
