extends Sprite

func _ready():
	modulate = Color(1,1,1,0)

func _on_Timer_timeout():
	$Tween.interpolate_property(self, "position", Vector2(154, -100), Vector2(154, 54), 2, Tween.TRANS_SINE)
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 2, Tween.TRANS_LINEAR)
	$Tween.start()
