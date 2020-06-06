extends AnimatedSprite

var init_pos = Vector2.ZERO
var sel_id = 0
var can_select = false

func _ready():
	init_pos = position
	modulate = Color(1,1,1,0)

func _process(delta):
	position = init_pos + Vector2(0, sel_id * 22)
	
	var help = get_node("../../Help")
	if help.faded_in or help.fading_in or not can_select:
		return
	
	if Input.is_action_just_pressed("ui_down"):
		sel_id += 1
		$Blip.pitch_scale = 1.1
		$Blip.play()
	if Input.is_action_just_pressed("ui_up"):
		sel_id -= 1
		$Blip.pitch_scale = 0.9
		$Blip.play()
	
	
	if sel_id < 0:
		sel_id = 3
	elif sel_id > 3:
		sel_id = 0
		
	if Input.is_action_just_pressed("ui_select"):
		if sel_id == 0:
			get_node("../../Fade Out").fade_out()
		if sel_id == 1:
			help.fade_in()
		if sel_id == 2:
			get_tree().change_scene("res://credits/Credits.tscn")
		if sel_id == 3:
			get_tree().quit()	
		
		$Select.play()
			
func _on_Timer_timeout():
	can_select = true
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 2, Tween.TRANS_EXPO)
	$Tween.start()
