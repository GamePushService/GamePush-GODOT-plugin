extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	GP.Game.paused.connect(func(): GP.Logger.info("pause"))
	GP.Game.resumed.connect(func(): GP.Logger.info("resume"))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_is_paused_pressed():
	GP.Logger.info(GP.Game.is_paused())


func _on_pause_pressed():
	GP.Game.pause()


func _on_resume_pressed():
	GP.Game.resume()


func _on_game_start_pressed():
	GP.Game.game_start()


func _on_gameplay_start_pressed():
	GP.Game.gameplay_start()


func _on_gameplay_stop_pressed():
	GP.Game.gameplay_stop()
