extends Control



func _ready():
	GP.Fullscreen.opened.connect(func(): GP.Logger.info("open"))
	GP.Fullscreen.closed.connect(func(): GP.Logger.info("close"))
	GP.Fullscreen.changed.connect(func(): GP.Logger.info("change"))
	
	
func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_open_pressed():
	GP.Fullscreen.open()


func _on_close_pressed():
	GP.Fullscreen.close()


func _on_toggle_pressed():
	GP.Fullscreen.toggle()


func _on_is_enabled_pressed():
	GP.Logger.info(GP.Fullscreen.is_enabled())
