extends Node


signal after_ready


var window: JavaScriptObject
var gp: JavaScriptObject


func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		gp = GP.gp
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.01).timeout
	after_ready.emit()
	

func current() -> String:
	if OS.get_name() == "Web":
		return gp.avatarGenerator
	else:
		push_warning("Not running on Web")
		return ""

func generate_avatar(has:Variant, size:int) -> String:
	var result := ""
	if OS.get_name() == "Web":
		result = gp.generateAvatar(has, size)
	else:
		push_warning("Not running on Web")
	return result
