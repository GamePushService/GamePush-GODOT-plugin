extends Node

var window: JavaScriptObject
var gp: JavaScriptObject

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
			
func info(arg1="", arg2="", arg3="", arg4="") -> void:
	if OS.get_name() == "Web":
		gp.logger.info(arg1, arg2, arg3, arg4)
	else:
		print("INFO:", arg1, arg2, arg3, arg4)

func warn(arg1="", arg2="", arg3="", arg4="") -> void:
	if OS.get_name() == "Web":
		gp.logger.warn(arg1, arg2, arg3, arg4)
	else:
		push_warning(arg1, arg2, arg3, arg4)
		
func error(arg1="", arg2="", arg3="", arg4="") -> void:
	if OS.get_name() == "Web":
		gp.logger.error(arg1, arg2, arg3, arg4)
	else:
		push_error("INFO:", arg1, arg2, arg3, arg4)

func log(arg1="", arg2="", arg3="", arg4="") -> void:
	if OS.get_name() == "Web":
		gp.logger.log(arg1, arg2, arg3, arg4)
	else:
		print(arg1, arg2, arg3, arg4)
