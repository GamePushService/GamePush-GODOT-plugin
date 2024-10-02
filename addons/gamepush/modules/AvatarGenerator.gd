extends Node

var window: JavaScriptObject
var gp: JavaScriptObject

#Needs Docs or something
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
			

func current() -> String:
	if OS.get_name() == "Web":
		return gp.avatarGenerator
	else:
		push_warning("Not running on Web")
		return ""

func generate_avatar(has:Variant,	 size:int) -> String:
	var result := ""
	if OS.get_name() == "Web":
		result = await gp.generateAvatar(has, size)
	else:
		push_warning("Not running on Web")
	return result
