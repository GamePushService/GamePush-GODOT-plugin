extends Control


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_is_dev_pressed():
	GP.Logger.info(GP.System.is_dev())


func _on_is_allowed_origin_pressed():
	GP.Logger.info(GP.System.is_allowed_origin())
