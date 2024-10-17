extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	GP.inited.connect(func():
		get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")
		)
