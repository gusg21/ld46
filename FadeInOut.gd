extends TextureRect

var level_num = 1

var LEVELS = [
	preload("res://levels/Level 1.tscn"),
	preload("res://levels/Level 2.tscn"),
	preload("res://levels/Level 3.tscn"),
	preload("res://levels/Level 4.tscn"),
	preload("res://levels/Level 5.tscn"),
	preload("res://levels/Level 6.tscn"),
	preload("res://levels/Level 7.tscn"),
]
onready var level = get_node("../../Level 1")

func _ready():
	modulate = Color(1,1,1,0)
	visible = true

func _process(delta):
	
	get_parent().target_path = level.get_node("Player").get_path()

func fade_out():
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 2, Tween.TRANS_EXPO)
	$Tween.start()

func next_level():
	if get_parent().get_parent().has_node("Level " + str(level_num)):
		get_parent().get_parent().get_node("Level " + str(level_num)).queue_free()
	level_num += 1
	
	if level_num > len(LEVELS):
		get_tree().change_scene("res://you win/you win.tscn")
		return
	
	level = LEVELS[level_num - 1].instance()
	get_parent().get_parent().add_child(level)
	level.name = "Level " + str(level_num)
	
	var player = level.get_node("Player")
	if player == null:
		print("PLAYER NULL")
	var campfire = level.get_node("Campfire")
	if campfire == null:
		print("CAMPFIRE NULL")
	get_node("..").target_path = player.get_path()
	get_node("../../Sounds/Music").player_path = player.get_path()
	get_node("../../Sounds/Music").campfire_path = campfire.get_path()
	
	get_node("../Timer").elapsed = 0
	
	if level_num == 7:
		get_node("../../Sounds/Music").fade_out()


func _on_Tween_tween_completed(object, key):
	next_level()
	
	modulate = Color(1,1,1,0)
