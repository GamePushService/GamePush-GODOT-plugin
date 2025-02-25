@tool
extends EditorPlugin

const AUTOLOAD_NAME = "GP"
var export_plugin: HTMLExportPlugin



func _enter_tree():
	if !ProjectSettings.has_setting("game_push/config/project_id"):
		ProjectSettings.set_setting("game_push/config/project_id", "0")
		ProjectSettings.set_initial_value("game_push/config/project_id", "0")
	if !ProjectSettings.has_setting("game_push/config/token"):
		ProjectSettings.set_setting("game_push/config/token", "")
		ProjectSettings.set_initial_value("game_push/config/token", "")
	if !ProjectSettings.has_setting("game_push/config/is_preloader_show"):
		ProjectSettings.set_setting("game_push/config/is_preloader_show", false)
		ProjectSettings.set_initial_value("game_push/config/is_preloader_show", false)
	if !ProjectSettings.has_setting("game_push/config/ready_delay"):
		ProjectSettings.set_setting("game_push/config/ready_delay", 0.0)
		ProjectSettings.set_initial_value("game_push/config/ready_delay", 0.0)
	if !ProjectSettings.has_setting("game_push/config/is_archive"):
		ProjectSettings.set_setting("game_push/config/is_archive", false)
		ProjectSettings.set_initial_value("game_push/config/is_archive", false)
	if !ProjectSettings.has_setting("game_push/config/archive_name"):
		ProjectSettings.set_setting("game_push/config/archive_name", "export_archive.zip")
		ProjectSettings.set_initial_value("game_push/config/archive_name", "export_archive.zip")
	# The autoload can be a scene or script file.
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/gamepush/game_push.gd")
	export_plugin = load("res://addons/gamepush/export_plugin.gd").new()
	add_export_plugin(export_plugin)


func _exit_tree():
	remove_autoload_singleton(AUTOLOAD_NAME)
	remove_export_plugin(export_plugin)


#func _has_main_screen():
	#return true


func _get_plugin_name():
	return "GamePush"
#
#func _get_plugin_icon():
	#return EditorInterface.get_editor_theme().get_icon("Node", "EditorIcons")


	
