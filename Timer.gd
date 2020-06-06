extends AnimatedSprite

var elapsed = 0.0
var length = 2 * 60.0
var stopped =false

func _process(delta):
	elapsed += delta# * 20.0
	
	set_frame(floor((elapsed / length) * 9))
	visible = get_parent().get_node("TextureRect").level_num != 7
	
	if floor((elapsed / length) * 9) > 8 and !stopped and !(get_parent().get_node("TextureRect").level_num == 7):
		stopped = true
		get_parent().get_node("TextureRect").fade_out()
