extends Node

var window:JavaScriptObject
var gp:JavaScriptObject

signal after_ready

signal change_orientation(is_portrait:bool)

var _callback_change_orientation := JavaScriptBridge.create_callback(_change_orientation)
# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		gp = GP.gp
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.01).timeout
		gp.on("change:orientation", _callback_change_orientation)
	after_ready.emit()

func is_mobile():
	if OS.get_name() == "Web":
		return gp.isMobile
	push_warning("Not running on Web")
	

func is_portrait():
	if OS.get_name() == "Web":
		return gp.isPortrait
	push_warning("Not running on Web")
	

func _change_orientation(args): change_orientation.emit(args[0])
	
	
