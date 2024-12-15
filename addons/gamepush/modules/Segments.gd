extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var segments:JavaScriptObject

signal after_ready

signal entered(segment_tag: String)
signal left(segment_tag: String)

var _callback_entered := JavaScriptBridge.create_callback(func(args):
			entered.emit(args[0]))
var _callback_left := JavaScriptBridge.create_callback(func(args):
			left.emit(args[0]))

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		gp = GP.gp
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.01).timeout
		segments = gp.segments
		gp.segments.on("enter", _callback_entered)
		gp.segments.on("leave", _callback_left)
	after_ready.emit()
	

func list() -> Array:
	if OS.get_name() == "Web":
		var segment_list: Array = []
		var _callback_f_e = func(args):
			segment_list.append(args[0])
		var _callback = JavaScriptBridge.create_callback(_callback_f_e)
		segments.list.forEach(_callback)
		return segment_list
	push_warning("Not running on Web")
	return []

func has(tag: String) -> bool:
	if OS.get_name() == "Web":
		return segments.has(tag)
	push_warning("Not running on Web")
	return false
