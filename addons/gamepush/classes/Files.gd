extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var files:JavaScriptObject

signal uploaded
signal error_upload
signal loaded_content
signal error_load_content 
signal choosed
signal error_choose
signal fetched
signal error_fetch
signal fetched_more
signal error_fetch_more

var callback_upload = JavaScriptBridge.create_callback(_upload)
var callback_error_upload = JavaScriptBridge.create_callback(_error_upload)
var callback_load_content = JavaScriptBridge.create_callback(_load_content)
var callback_error_load_content = JavaScriptBridge.create_callback(_error_load_content)
var callback_choose = JavaScriptBridge.create_callback(_choose)
var callback_error_choose = JavaScriptBridge.create_callback(_error_choose)
var callback_fetch = JavaScriptBridge.create_callback(_fetch)
var callback_error_fetch = JavaScriptBridge.create_callback(_error_fetch)
var callback_fetch_more = JavaScriptBridge.create_callback(_fetch_more)
var callback_error_fetch_more = JavaScriptBridge.create_callback(_error_fetch_more)

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		files = gp.files
		files.on("upload", callback_upload)
		files.on("error:upload", callback_error_upload)
		files.on("loadContent", callback_load_content)
		files.on("error:loadContent", callback_error_load_content)
		files.on("choose", callback_choose)
		files.on("error:choose", callback_error_choose)
		files.on("fetch", callback_fetch)
		files.on("error:fetch", callback_error_fetch)


func upload(file=null, accept=null, tags=null):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		var _tags := JavaScriptBridge.create_object("Array")
		if file and file is File:
			conf["file"] = file._to_js()
		conf["accept"] = accept
		for t in tags:
			_tags.push(t)
		conf["tags"] = _tags
		files.upload(conf)
	push_warning("Not Web")
	
func upload_url(url:String, tags=null):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		var _tags := JavaScriptBridge.create_object("Array")
		conf["url"] = url
		for t in tags:
			_tags.push(t)
		conf["tags"] = _tags
		files.uploadUrl(conf)
	push_warning("Not Web")
	
func upload_content(file_name:String, content:String="", tags=null):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["file_name"] = file_name
		conf["content"] = content
		files.uploadContent(conf)
	push_warning("Not Web")
	
func load_сontent(url:String):
	if OS.get_name() == "Web":
		return await files.loadContent(url)

func choose_file(type_file=null):
	if OS.get_name() == "Web":
		var result:Array
		var _result
		if type_file:
			_result = await files.chooseFile(type_file)
		else:
			_result = await files.chooseFile()
		result.append(File.new()._from_js(_result[0]))
		result.append(_result[1])
		return result


func fetch(player_id=null, tags=null, limit=null, offset=null):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		var _tags := JavaScriptBridge.create_object("Array")
		for t in tags:
			_tags.push(t)
		conf["tags"] = _tags
		conf["playerId"] = player_id
		conf["limit"] = limit
		conf["offset"] = offset
		return await files.fetch(conf)

func fetch_more(player_id=null, tags=null, limit=null, offset=null):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		var _tags := JavaScriptBridge.create_object("Array")
		for t in tags:
			_tags.push(t)
		conf["tags"] = _tags
		conf["playerId"] = player_id
		conf["limit"] = limit
		conf["offset"] = offset
		var result:Array
		var _result
		_result = await files.fetch(conf)
		result.append(_result[0])
		result.append(_result[1])
		return result
		
		
func _upload(args):
	var js_object = args[0]
	#NEED TEST
	uploaded.emit(js_object)
	
func _error_upload(args): error_upload.emit(args[0])
func _load_content(args): loaded_content.emit(args[0])
func _error_load_content(args): error_load_content.emit(args[0])
func _choose(args): choosed.emit(args[0])
func _error_choose(args): error_choose.emit(args[0])
func _fetch(args): fetched.emit(args[0])
func _error_fetch(args): error_fetch.emit(args[0])
func _fetch_more(args): fetched_more.emit(args[0])
func _error_fetch_more(args): error_fetch_more.emit(args[0])

class File:
	var id:String
	var player_id:int
	var name:String
	var src:String
	var size:int
	var tags:Array[String]
	
	var callback_f_e := JavaScriptBridge.create_callback(_f_e)
	
	func _to_js():
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["id"] = id
		js_object["playerId"] = player_id
		js_object["name"] = name
		js_object["src"] = src
		js_object["size"] = size
		var _tags := JavaScriptBridge.create_object("Array")
		for t in tags:
			_tags.push(t)
		js_object["tags"] = _tags
		
		
	func _from_js(js_object):
		id = js_object["id"]
		player_id =js_object["playerId"]
		name = js_object["name"]
		src = js_object["src"]
		size = js_object["size"]
		tags = Array()
		js_object["tags"].forEach(callback_f_e)
		
	func _f_e(cValue, index, arr):
		tags.append(cValue)
