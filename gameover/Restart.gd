extends Label

var init_pos = Vector2.ZERO
export(NodePath) var label_path

func _ready():
	init_pos = rect_position

func _input(event):
	if event is InputEventKey and event.pressed:
		$Tween.interpolate_property(self, "rect_position", init_pos, Vector2(400, 300), 2, Tween.TRANS_ELASTIC)
		$Tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), 2, Tween.TRANS_EXPO)
		$Tween.interpolate_property(get_node(label_path), "modulate", Color(1,1,1,1), Color(1,1,1,0), 2, Tween.TRANS_EXPO)
		$Tween.start()


func _on_Tween_tween_completed(object, key):
	get_tree().change_scene("res://World Scene.tscn")
