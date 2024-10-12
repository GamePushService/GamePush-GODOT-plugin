extends Control

func _ready():
	GP.App.review_requested.connect(func(arg): GP.Logger.info("review_requested", arg["success"], arg["rating"] , arg["error"]))
	GP.App.shortcut_added.connect(func(arg): GP.Logger.info(arg))


func _on_title_pressed():
	GP.Logger.info(GP.App.title())


func _on_description_pressed():
	GP.Logger.info(GP.App.description())


func _on_image_pressed():
	GP.Logger.info(GP.App.image())


func _on_url_pressed():
	GP.Logger.info(GP.App.url())


func _on_request_review_pressed():
	GP.App.request_review()
	


func _on_can_request_review_pressed():
	GP.Logger.info(GP.App.can_request_review())
	

func _on_is_already_reviewed_pressed():
	GP.Logger.info(GP.App.is_already_reviewed())


func _on_add_shortcut_pressed():
	GP.App.add_shortcut()


func _on_can_add_shortcut_pressed():
	GP.Logger.info(GP.App.can_add_shortcut())


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")
