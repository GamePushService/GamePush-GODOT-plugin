extends Node

var window:JavaScriptObject
var gp:JavaScriptObject


func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.1).timeout
			
func time() -> String:
	if OS.get_name() == "Web":
		return gp.serverTime
	push_warning("Not running on Web")
	return ""
