extends Sprite

export(NodePath) var menu_path

var fading_out = false

func _ready():
	visible = true
	
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 2, Tween.TRANS_EXPO)
	$Tween.start()
	
	get_node(menu_path).visible = false

func _on_Fade_Out_timeout():
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), 2, Tween.TRANS_EXPO)
	$Tween.start()
	fading_out = true

func _on_Tween_tween_all_completed():
	if fading_out:
		pass
	else:
		get_node(menu_path).visible = true
