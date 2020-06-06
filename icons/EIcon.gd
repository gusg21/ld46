extends Sprite

onready var frames = 0
var red_x = false

var FRAMES = [preload("res://icons/E.png"), preload("res://icons/Ex.png")]

func _process(delta):
	frames += 1
	offset.y = sin(frames / 5) * 2
	
	set_texture(FRAMES[int(red_x)])
