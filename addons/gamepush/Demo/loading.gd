extends Control


func _ready():
	if GP.is_inited:
		go_to_main()
		return
	GP.inited.connect(go_to_main)
	GP.Player.player_ready.connect(func(): GP.Logger.info("player_ready"))


func go_to_main(is_init:bool=false):
	# Put here your scene file
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")
