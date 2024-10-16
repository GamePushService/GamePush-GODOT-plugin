extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var documents:JavaScriptObject

signal opened
signal closed
signal fetched(document:Dictionary)
signal error_fetch(error:String)

var _callback_open = JavaScriptBridge.create_callback(_open)
var _callback_close = JavaScriptBridge.create_callback(_close)
var _callback_fetch = JavaScriptBridge.create_callback(_fetch)
var _callback_error_fetch = JavaScriptBridge.create_callback(_error_fetch)

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		documents = gp.documents
		documents.on("open", _callback_open)
		documents.on("close", _callback_close)
		documents.on("fetch", _callback_fetch)
		documents.on("error:fetch", _callback_error_fetch)
		

func open(type:String) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["type"] = type
		documents.open(conf)
	else:
		push_warning("Not running on Web")
		
	
func fetch(type:String, format:String="HTML") -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["type"] = type
		conf["format"] = format
		documents.fetch(conf)
	else:
		push_warning("Not running on Web")



func _open(args): opened.emit()
func _close(args): closed.emit()
func _fetch(args): fetched.emit(GP._js_to_dict(args[0]))
func _error_fetch(args): error_fetch.emit(args[0].message)
