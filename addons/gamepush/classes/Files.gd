extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var files:JavaScriptObject

signal uploaded
signal error_upload

var callback_upload = JavaScriptBridge.create_callback(_upload)
var callback_error_upload = JavaScriptBridge.create_callback(_error_upload)
# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		files = gp.files
		files.on("upload", )
		
func upload(file=null, accept=null, tags=null):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["file"] = file
		conf["accept"] = accept
		conf["tags"] = tags
		files.upload(conf)
	push_warning("Not Web")
	
func upload_url(url:String, tags=null):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["url"] = url
		conf["tags"] = tags
		files.uploadUrl(conf)
	push_warning("Not Web")
	
func upload_content(file_name:String, content:String="", tags:String=""):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["file_name"] = file_name
		conf["content"] = content
		files.uploadContent(conf)
	push_warning("Not Web")
	
func loadContent(url:String):
	if OS.get_name() == "Web":
		pass

func _upload(args):
	var js_object = args[0]
	var event = js_object.event
	#NEED TEST
	uploaded.emit()
	
func _error_upload(args): error_upload.emit(args[0])
