extends "res://ZSortedStaticBody.gd"

export(String) var message
var letter_open = false
var letter_shown = false

func _ready():
	set_meta("type", "logletter")
	$Letter.modulate = Color(1,1,1,0)

func _process(delta):
	$Letter/RichTextLabel.bbcode_text = message
	$Notice.visible = !letter_shown
	
	._process(delta)

func show_letter():
	$Tween.interpolate_property($Letter, "scale", Vector2(0.8, 0.8), Vector2.ONE, 2, Tween.TRANS_EXPO)
	$Tween.interpolate_property($Letter, "modulate", Color(1,1,1,0), Color(1,1,1,1), 2, Tween.TRANS_EXPO)
	$Tween.start()
	letter_open = true
	letter_shown = true
	
func hide_letter():
	$Tween.interpolate_property($Letter, "scale", Vector2.ONE, Vector2(0.8, 0.8), 2, Tween.TRANS_EXPO)
	$Tween.interpolate_property($Letter, "modulate", Color(1,1,1,1), Color(1,1,1,0), 2, Tween.TRANS_EXPO)
	$Tween.start()
	letter_open = false
