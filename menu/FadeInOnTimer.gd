extends Label

func _ready():
	modulate = Color(1,1,1,0)

func _on_Timer_timeout():
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1, Tween.TRANS_EXPO)
	$Tween.start()
