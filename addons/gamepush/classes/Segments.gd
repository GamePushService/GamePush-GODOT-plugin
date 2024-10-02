extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var segments:JavaScriptObject

signal entered(segment_tag: String)
signal left(segment_tag: String)

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		segments = gp.segments
		gp.segments.on("enter", JavaScriptBridge.create_callback(func(args):
			entered.emit(args[0])
		))
		gp.segments.on("leave", JavaScriptBridge.create_callback(func(args):
			left.emit(args[0])
		))

func list() -> Array:
	if OS.get_name() == "Web":
		var segment_list: Array = []
		segments.list.forEach(JavaScriptBridge.create_callback(func(segment: String): segment_list.append(segment)))
		return segment_list
	push_warning("Not running on Web")
	return []

func has(tag: String) -> bool:
	if OS.get_name() == "Web":
		var has_payments = await segments.has(tag)
		return has_payments
	push_warning("Not running on Web")
	return false
