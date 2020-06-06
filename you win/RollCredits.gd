extends Label

var CREDITS = preload("res://credits/Credits.tscn")
export(NodePath) var label 

var credits_started = false

func _input(event):
	if event is InputEventKey and event.pressed and !credits_started:
		credits_started = true
		var c = CREDITS.instance()
		get_parent().add_child(c)
		c.position.y += 50
		
func _process(delta):
	if credits_started:
		rect_position.x += 2
		get_node(label).rect_position.x += 2
