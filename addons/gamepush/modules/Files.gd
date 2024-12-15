extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var files:JavaScriptObject

signal after_ready

signal uploaded(file:File)
signal error_upload(err:Dictionary)
signal loaded_content
signal error_load_content(err:Dictionary) 
signal choosed(file:File, temp_url:String)
signal error_choose(err:Dictionary)
signal fetched(result:Array)
signal error_fetch(err:Dictionary)
signal fetched_more(result:Array)
signal error_fetch_more(err:Dictionary)

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
		gp = GP.gp
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.01).timeout
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
	after_ready.emit()
	

func upload(tags:Array=[]):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		var _tags := JavaScriptBridge.create_object("Array")
		for t in tags:
			_tags.push(t)
		conf["tags"] = _tags
		files.upload(conf)
	else:
		push_warning("Not Web")
	
func upload_url(file_name:String, url:String, tags:Array=[]) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		var _tags := JavaScriptBridge.create_object("Array")
		conf["filename"] = file_name
		conf["url"] = url
		for t in tags:
			_tags.push(t)
		conf["tags"] = _tags
		files.uploadUrl(conf)
	else:
		push_warning("Not Web")
	
func upload_content(file_name:String, content:String="", tags:Array=[]) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["filename"] = file_name
		conf["content"] = content
		var _tags := JavaScriptBridge.create_object("Array")
		for t in tags:
			_tags.push(t)
		conf["tags"] = _tags
		files.uploadContent(conf)
	else:
		push_warning("Not Web")
	
signal __load_сontent(a:Variant)

func load_сontent(url:String) -> String:
	if OS.get_name() == "Web":
		var callback := JavaScriptBridge.create_callback(func(args): __load_сontent.emit(args[0]))
		files.loadContent(url).then(callback)
		var result = await __load_сontent
		return result
	else:
		push_warning("Not Web")
		return ""


signal __choose_file(a)

func choose_file(type_file:String="") -> Array:
	if OS.get_name() == "Web":
		var result:Array
		var callback := JavaScriptBridge.create_callback(func(args): __choose_file.emit(args[0]))
		if type_file:
			files.chooseFile(type_file).then(callback)
		else:
			files.chooseFile().then(callback)
		var _result = await __choose_file
		var file := File.new()
		if _result.file.id:
			file._from_js(_result.file)
		result.append(file)
		result.append(_result.tempUrl)
		return result
	else:
		push_warning("Not Web")
		return []


signal __fetch(a)

func fetch(player_id=null, tags=null, limit=null, offset=null) -> Array:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if tags:
			var _tags := JavaScriptBridge.create_object("Array")
			for t in tags:
				_tags.push(t)
			conf["tags"] = _tags
		if player_id:
			conf["playerId"] = player_id
		if limit:
			conf["limit"] = limit
		if offset:
			conf["offset"] = offset
		var result:Array
		var callback := JavaScriptBridge.create_callback(func(args): __fetch.emit(args[0]))
		files.fetch(conf).then(callback)
		var _result = await __fetch
		var arr_file:Array =[]
		callback = JavaScriptBridge.create_callback(func(args):
			arr_file.append(File.new()._from_js(args[0])))
		_result.items.forEach(callback)
		result.append(arr_file)
		result.append(_result.canLoadMore)
		return result
	else:
		push_warning("Not Web")
		return []


signal __fetch_more(a)

func fetch_more(player_id=null, tags=null, limit=null, offset=null) -> Array:
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
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_more.emit(args[0]))
		files.fetchMore(conf).then(callback)
		var _result = await __fetch_more
		var arr_file:Array =[]
		callback = JavaScriptBridge.create_callback(func(args):
			arr_file.append(File.new()._from_js(args[0])))
		_result.items.forEach(callback)
		result.append(arr_file)
		result.append(_result.canLoadMore)
		return result
	else:
		push_warning("Not Web")
		return []
		
		
func _upload(args):
	uploaded.emit(File.new()._from_js(args[0]))
func _error_upload(args): error_upload.emit(GP._js_to_dict(args[0])) 
func _load_content(args): loaded_content.emit(args[0])
func _error_load_content(args): error_load_content.emit(GP._js_to_dict(args[0]))
func _choose(args):
	var file : = File.new()
	if args[0].file.id:
		file._from_js(args[0].file)
	choosed.emit(file, args[0].tempUrl)
func _error_choose(args): error_choose.emit(GP._js_to_dict(args[0])) 
func _fetch(args):
	var result := []
	var arr_file:Array =[]
	var callback = JavaScriptBridge.create_callback(func(args):
		arr_file.append(File.new()._from_js(args[0])))
	args[0].items.forEach(callback)
	result.append(arr_file)
	result.append(args[0].canLoadMore)
	fetched.emit(result)
func _error_fetch(args): error_fetch.emit(GP._js_to_dict(args[0])) 
func _fetch_more(args):
	var result := []
	var arr_file:Array =[]
	var callback = JavaScriptBridge.create_callback(func(args):
		arr_file.append(File.new()._from_js(args[0])))
	args[0].items.forEach(callback)
	result.append(arr_file)
	result.append(args[0].canLoadMore)
	fetched_more.emit(result)
func _error_fetch_more(args): error_fetch_more.emit(GP._js_to_dict(args[0])) 

class File:
	extends GP.GPObject
	
	var id:String
	var player_id:int
	var name:String
	var src:String
	var size:int
	var tags:Array
	
	
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
		var callback_f_e := JavaScriptBridge.create_callback(_f_e)
		id = js_object["id"]
		player_id =js_object["playerId"]
		name = js_object["name"]
		src = js_object["src"]
		size = js_object["size"]
		tags = Array()
		js_object["tags"].forEach(callback_f_e)
		return self
		
	func _f_e(args):
		tags.append(args[0])
