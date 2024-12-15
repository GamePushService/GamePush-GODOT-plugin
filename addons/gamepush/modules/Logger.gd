extends Node

var window: JavaScriptObject
var gp: JavaScriptObject

signal after_ready

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		gp = GP.gp
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.01).timeout
	after_ready.emit()
		
			
func info(arg1="", arg2="", arg3="", arg4="") -> void:
	if OS.get_name() == "Web":
		gp.logger.info(str(arg1), str(arg2), str(arg3), str(arg4))
	else:
		print("INFO:", arg1, arg2, arg3, arg4)

func warn(arg1="", arg2="", arg3="", arg4="") -> void:
	if OS.get_name() == "Web":
		gp.logger.warn(str(arg1), str(arg2), str(arg3), str(arg4))
	else:
		push_warning(arg1, arg2, arg3, arg4)
		
func error(arg1="", arg2="", arg3="", arg4="") -> void:
	if OS.get_name() == "Web":
		gp.logger.error(str(arg1), str(arg2), str(arg3), str(arg4))
	else:
		push_error("INFO:", arg1, arg2, arg3, arg4)

func log(arg1="", arg2="", arg3="", arg4="") -> void:
	if OS.get_name() == "Web":
		gp.logger.log(str(arg1), str(arg2), str(arg3), str(arg4))
	else:
		print(arg1, arg2, arg3, arg4)
		
		
func info_array(args:Array) -> void:
	var res:= ""
	for a in args:
		res += str(a)
		res += " "
	res.strip_edges()
	if OS.get_name() == "Web":
		gp.logger.info(res)
	else:
		print("INFO:", res)

func warn_array(args:Array) -> void:
	var res:= ""
	for a in args:
		res += str(a)
		res += " "
	res.strip_edges()
	if OS.get_name() == "Web":
		gp.logger.warn(res)
	else:
		push_warning(res)
		
func error_array(args:Array) -> void:
	var res:= ""
	for a in args:
		res += str(a)
		res += " "
	res.strip_edges()
	if OS.get_name() == "Web":
		gp.logger.error(res)
	else:
		push_error(res)
