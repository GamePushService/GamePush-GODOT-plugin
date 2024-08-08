@tool
extends EditorPlugin

const AUTOLOAD_NAME = "GP"
var export_plugin: HTMLExportPlugin

const MainScreenScene = preload("res://addons/gamepush/main_screen_scene.tscn")
var main_screen_scene_instance: Node


func _enter_tree():
	# The autoload can be a scene or script file.
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/gamepush/game_push.gd")
	export_plugin = load("res://addons/gamepush/export_plugin.gd").new()
	add_export_plugin(export_plugin)
	_make_visible(false)
	main_screen_scene_instance = MainScreenScene.instantiate()
	main_screen_scene_instance.main_scene_data_change.connect(_update_data_from_main_screen)
	EditorInterface.get_editor_main_screen().add_child(main_screen_scene_instance)


func _exit_tree():
	remove_autoload_singleton(AUTOLOAD_NAME)
	remove_export_plugin(export_plugin)


func _has_main_screen():
	return true

func _make_visible(visible):
	if main_screen_scene_instance:
		main_screen_scene_instance.visible = visible

func _get_plugin_name():
	return "GamePush"

func _get_plugin_icon():
	return EditorInterface.get_editor_theme().get_icon("Node", "EditorIcons")


func _update_data_from_main_screen():
	export_plugin.project_id = main_screen_scene_instance.project_id
	export_plugin.public_token = main_screen_scene_instance.token
	export_plugin.is_archive = main_screen_scene_instance.is_archive
	export_plugin.archive_name = main_screen_scene_instance.archive_name
