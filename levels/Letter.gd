extends Sprite

func _ready():
	visible = true
	
func _process(delta):
	position = get_node("../../../Camera").position + Vector2(-290, 44)
