extends Control


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_type_pressed():
	GP.Logger.info(GP.Platform.type())


func _on_has_integrated_auth_pressed():
	GP.Logger.info(GP.Platform.has_integrated_auth())


func _on_is_logout_available_pressed():
	GP.Logger.info(GP.Platform.is_logout_available())


func _on_is_external_links_allowed_pressed():
	GP.Logger.info(GP.Platform.is_external_links_allowed())


func _on_is_secret_code_auth_available_pressed():
	GP.Logger.info(GP.Platform.is_secret_code_auth_available())


func _on_get_sdk_pressed():
	GP.Logger.info(GP.Platform.get_SDK())


func _on_get_native_sdk_pressed():
	GP.Logger.info(GP.Platform.get_native_SDK())
