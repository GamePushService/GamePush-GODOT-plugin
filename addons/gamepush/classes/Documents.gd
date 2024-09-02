extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var documents:JavaScriptObject

signal opened
signal closed
signal fetched
signal error_fetch

var callback_open = JavaScriptBridge.create_callback(_open)
var callback_close = JavaScriptBridge.create_callback(_close)
var callback_fetch = JavaScriptBridge.create_callback(_fetch)
var callback_error_fetch = JavaScriptBridge.create_callback(_error_fetch)

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		documents = gp.documents
		documents.on("open", callback_open)
		documents.on("close", callback_close)
		documents.on("fetch", callback_fetch)
		documents.on("error:fetch", callback_error_fetch)
		

func open(type=null):
	var conf := JavaScriptBridge.create_object("Object")
	if type:
		conf["type"] = type
	documents.open(conf)
		
	
func fetch(type=null, format=null):
	var conf := JavaScriptBridge.create_object("Object")
	if type:
		conf["type"] = type
	if format:
		conf["format"] = format
	return await documents.fetch(conf)


func _open(args): opened.emit()
func _close(args): closed.emit()
func _fetch(args): fetched.emit(args[0])
func _error_fetch(args): error_fetch.emit(args[0])
