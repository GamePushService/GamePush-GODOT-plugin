extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var fullscreen:JavaScriptObject

signal opened
signal closed
signal changed

var callback_open := JavaScriptBridge.create_callback(_open)
var callback_close := JavaScriptBridge.create_callback(_close) 
var callback_change := JavaScriptBridge.create_callback(_change) 


func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		fullscreen = gp.fullscreen
	else:
		push_warning("Not Web")
		

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
		
func is_enabled():
	if OS.get_name() == "Web":
		return fullscreen.isEnabled
	else:
		push_warning("Not Web")

func _open(args): opened.emit()
func _close(args): closed.emit()
func _change(args): changed.emit()
