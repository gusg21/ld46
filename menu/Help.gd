extends Sprite

var faded_in = false
var fading_in = false

func _ready():
	modulate = Color(1,1,1,0)

func _process(delta):
	if Input.is_action_just_pressed("ui_select") and faded_in:
		fade_out()

func fade_out():
	faded_in = false
	fading_in = false
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), 2, Tween.TRANS_EXPO)
	$Tween.start()

func fade_in():
	fading_in = true
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 2, Tween.TRANS_EXPO)
	$Tween.interpolate_property(self, "scale", Vector2(0.8, 0.8), Vector2(1, 1), 2, Tween.TRANS_EXPO)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	if fading_in:
		faded_in = true
		fading_in = false
