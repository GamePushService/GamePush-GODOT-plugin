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

var _callback_upload = JavaScriptBridge.create_callback(_upload)
var _callback_error_upload = JavaScriptBridge.create_callback(_error_upload)
var _callback_load_content = JavaScriptBridge.create_callback(_load_content)
var _callback_error_load_content = JavaScriptBridge.create_callback(_error_load_content)
var _callback_choose = JavaScriptBridge.create_callback(_choose)
var _callback_error_choose = JavaScriptBridge.create_callback(_error_choose)
var _callback_fetch = JavaScriptBridge.create_callback(_fetch)
var _callback_error_fetch = JavaScriptBridge.create_callback(_error_fetch)
var _callback_fetch_more = JavaScriptBridge.create_callback(_fetch_more)
var _callback_error_fetch_more = JavaScriptBridge.create_callback(_error_fetch_more)

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		files = gp.files
		files.on("upload", _callback_upload)
		files.on("error:upload", _callback_error_upload)
		files.on("loadContent", _callback_load_content)
		files.on("error:loadContent", _callback_error_load_content)
		files.on("choose", _callback_choose)
		files.on("error:choose", _callback_error_choose)
		files.on("fetch", _callback_fetch)
		files.on("error:fetch", _callback_error_fetch)
		files.on("fetchMore", _callback_fetch_more)
		files.on("error:fetchMore", _callback_error_fetch_more)


func upload(tags=null):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		var _tags := JavaScriptBridge.create_object("Array")
		for t in tags:
			_tags.push(t)
		conf["tags"] = _tags
		files.upload(conf)
	else:
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
	else:
		push_warning("Not Web")
	
func upload_content(file_name:String, content:String="", tags=null):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["file_name"] = file_name
		conf["content"] = content
		files.uploadContent(conf)
	else:
		push_warning("Not Web")
	
func load_сontent(url:String):
	if OS.get_name() == "Web":
		return await files.loadContent(url)
	else:
		push_warning("Not Web")

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
	else:
		push_warning("Not Web")

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
		var result:Array
		var _result
		_result = await files.fetch(conf)
		var arr_file:Array
		for i in _result[0]:
			#Need test
			arr_file.append(File.new()._from_js(i))
		result.append(arr_file)
		result.append(_result[1])
		return result
	else:
		push_warning("Not Web")

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
		_result = await files.fetchMore(conf)
		var arr_file:Array
		for i in _result[0]:
			#Need test
			arr_file.append(File.new()._from_js(i))
		result.append(arr_file)
		result.append(_result[1])
		return result
	else:
		push_warning("Not Web")
		
		
func _upload(args):
	uploaded.emit(File.new()._from_js(args[0]))
func _error_upload(args): error_upload.emit(args[0]) #String
func _load_content(args): loaded_content.emit(args[0]) #String
func _error_load_content(args): error_load_content.emit(args[0]) #String
func _choose(args): choosed.emit(args[0]) # ?
func _error_choose(args): error_choose.emit(args[0]) #String
func _fetch(args):
	var result
	var arr_file:Array
	for i in args[0][0]:
		#Need test
		arr_file.append(File.new()._from_js(i))
	result.append(arr_file)
	result.append(args[0][1])
	fetched.emit(result)
func _error_fetch(args): error_fetch.emit(args[0]) #String
func _fetch_more(args):
	var result
	var arr_file:Array
	for i in args[0][0]:
		#Need test
		arr_file.append(File.new()._from_js(i))
	result.append(arr_file)
	result.append(args[0][1])
	fetched_more.emit(result)
func _error_fetch_more(args): error_fetch_more.emit(args[0]) #String

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
		return js_object
		
		
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
