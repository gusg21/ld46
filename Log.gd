extends "res://Item.gd"

export(String, "Log", "Stick", "Gasoline") var item_type = "Log"
var ITEMS = {
	"Log": preload("res://wood/log.png"),
	"Stick": preload("res://wood/sticks.png"),
	"Gasoline": preload("res://wood/Gas.png")
}

func _ready():
	._ready()
	set_meta("type", "log")
	
	set_texture(ITEMS[item_type])
