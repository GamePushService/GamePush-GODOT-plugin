extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	GP.Device.change_orientation.connect(func(arg): GP.Logger.info(arg))

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_is_mobile_pressed():
	GP.Logger.info(GP.Device.is_mobile())


func _on_is_portrait_pressed():
	GP.Logger.info(GP.Device.is_portrait())
