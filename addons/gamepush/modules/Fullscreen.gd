extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var fullscreen:JavaScriptObject

signal opened
signal closed
signal changed

var _callback_open := JavaScriptBridge.create_callback(_open)
var _callback_close := JavaScriptBridge.create_callback(_close) 
var _callback_change := JavaScriptBridge.create_callback(_change) 


func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		fullscreen = gp.fullscreen
		fullscreen.on("open", _callback_open)
		fullscreen.on("close", _callback_close)
		fullscreen.on("change", _callback_change)

func open():
	if OS.get_name() == "Web":
		fullscreen.open()
	else:
		push_warning("Not Web")
		
func close():
	if OS.get_name() == "Web":
		fullscreen.close()
	else:
		push_warning("Not Web")
		
func toggle():
	if OS.get_name() == "Web":
		fullscreen.toggle()
	else:
		push_warning("Not Web")
		
func is_enabled() -> bool:
	if OS.get_name() == "Web":
		return fullscreen.isEnabled
	else:
		push_warning("Not Web")
		return false

func _open(args): opened.emit()
func _close(args): closed.emit()
func _change(args): changed.emit()
