@tool
extends EditorPlugin

const AUTOLOAD_NAME = "GP"


func _enter_tree():
	# The autoload can be a scene or script file.
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/gamepush/game_push.gd")


func _exit_tree():
	remove_autoload_singleton(AUTOLOAD_NAME)
