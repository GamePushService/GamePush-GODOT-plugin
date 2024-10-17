extends Node

var window:JavaScriptObject
var gp:JavaScriptObject

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.1).timeout

# Method to check if the game is in development mode
func is_dev() -> bool:
	if OS.get_name() == "Web":
		return gp.isDev
	push_warning("Not running on Web")
	return false

# Method to check if the game host is in trusted sources
func is_allowed_origin() -> bool:
	if OS.get_name() == "Web":
		return gp.isAllowedOrigin
	push_warning("Not running on Web")
	return false
