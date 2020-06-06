extends Camera2D

export var target_path:NodePath = "../Level 1/Player"

func _process(delta):
	position = lerp(position, get_node(target_path).position, 0.1)
