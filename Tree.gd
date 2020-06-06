extends "res://ZSortedStaticBody.gd"

var TREE_PATHS = [
	preload("res://tilemap/objects/Deadtree.png"), 
	preload("res://tilemap/objects/Pinetree.png"), 
	preload("res://tilemap/objects/Tree.png")
]

func _ready():
	$Graphics.set_texture(TREE_PATHS[rand_range(0, len(TREE_PATHS) - 1)])

func _process(delta):
	._process(delta)
