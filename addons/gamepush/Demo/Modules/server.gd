extends Control



func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_time_pressed():
	GP.Logger.info(GP.Server.time())
