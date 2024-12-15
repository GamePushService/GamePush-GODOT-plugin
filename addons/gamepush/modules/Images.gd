extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var images:JavaScriptObject

signal after_ready

signal uploaded(image:GPImage)
signal error_upload(error:Dictionary)
signal choosed(image:GPImage, temp_url:String)
signal error_choose(error:Dictionary)
signal fetched(result:Array)
signal error_fetch(error:Dictionary)
signal fetched_more(result:Array)
signal error_fetch_more(error:Dictionary)

var _callback_upload = JavaScriptBridge.create_callback(_upload)
var _callback_error_upload = JavaScriptBridge.create_callback(_error_upload)
var _callback_choose = JavaScriptBridge.create_callback(_choose)
var _callback_error_choose = JavaScriptBridge.create_callback(_error_choose)
var _callback_fetch = JavaScriptBridge.create_callback(_fetch)
var _callback_error_fetch = JavaScriptBridge.create_callback(_error_fetch)
var _callback_fetch_more = JavaScriptBridge.create_callback(_fetch_more)
var _callback_error_fetch_more = JavaScriptBridge.create_callback(_error_fetch_more)

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		gp = GP.gp
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.01).timeout
		images = gp.images
		images.on("upload", _callback_upload)
		images.on("error:upload", _callback_error_upload)
		images.on("choose", _callback_choose)
		images.on("error:choose", _callback_error_choose)
		images.on("fetch", _callback_fetch)
		images.on("error:fetch", _callback_error_fetch)
		images.on("fetchMore", _callback_fetch_more)
		images.on("error:fetchMore", _callback_error_fetch_more)
	after_ready.emit()

func upload(tags:Array=[]) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		var _tags := JavaScriptBridge.create_object("Array")
		for t in tags:
			_tags.push(t)
		conf["tags"] = _tags
		images.upload(conf)
	else:
		push_warning("Not Web")
		
func upload_url(url:String, tags:Array=[]) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		var _tags := JavaScriptBridge.create_object("Array")
		conf["url"] = url
		for t in tags:
			_tags.push(t)
		conf["tags"] = _tags
		images.uploadUrl(conf)
	else:
		push_warning("Not Web")

signal __choose_file(a)

func choose_file(type_file:String="") -> Array:
	if OS.get_name() == "Web":
		var result:Array
		var callback := JavaScriptBridge.create_callback(func(args): __choose_file.emit(args[0]))
		if type_file:
			images.chooseFile(type_file).then(callback)
		else:
			images.chooseFile().then(callback)
		var _result = await __choose_file
		if _result.file.id:
			result.append(GPImage.new()._from_js(_result.file))
		else:
			result.append(GPImage.new())
		result.append(_result.tempUrl)
		return result
	else:
		push_warning("Not Web")
		return []


signal __fetch(a)

func fetch(player_id=null, tags=null, limit=null, offset=null) -> Array:
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
		var callback := JavaScriptBridge.create_callback(func(args): __fetch.emit(args[0]))
		images.fetch(conf).then(callback)
		var _result = await __fetch
		var arr_file:Array =[]
		callback = JavaScriptBridge.create_callback(func(args):
			arr_file.append(GPImage.new()._from_js(args[0])))
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
		images.fetchMore(conf).then(callback)
		var _result = await __fetch_more
		var arr_file:Array =[]
		callback = JavaScriptBridge.create_callback(func(args):
			arr_file.append(GPImage.new()._from_js(args[0])))
		_result.items.forEach(callback)
		result.append(arr_file)
		result.append(_result.canLoadMore)
		return result
	else:
		push_warning("Not Web")
		return []


signal  __resize(a)

func resize(url:String, width:int, height:int, crop:bool) -> String:
	if OS.get_name() == "Web":
		return images.resize(url, width, height, crop)
	else:
		push_warning("Not Web")
		return ""
	
	
func _upload(args):
	uploaded.emit(GPImage.new()._from_js(args[0]))
func _error_upload(args): error_upload.emit(GP._js_to_dict(args[0]))
func _choose(args):
	var file : = GPImage.new()
	if args[0].file.id:
		file._from_js(args[0].file)
	choosed.emit(file, args[0].tempUrl)
func _error_choose(args): error_choose.emit(GP._js_to_dict(args[0])) 
func _fetch(args):
	var result := []
	var arr_file:Array =[]
	var callback = JavaScriptBridge.create_callback(func(arg):
		arr_file.append(GPImage.new()._from_js(arg[0])))
	args[0].items.forEach(callback)
	result.append(arr_file)
	result.append(args[0].canLoadMore)
	fetched.emit(result)
func _error_fetch(args): error_fetch.emit(GP._js_to_dict(args[0])) 
func _fetch_more(args):
	var result := []
	var arr_file:Array =[]
	var callback = JavaScriptBridge.create_callback(func(arg):
		arr_file.append(GPImage.new()._from_js(arg[0])))
	args[0].items.forEach(callback)
	result.append(arr_file)
	result.append(args[0].canLoadMore)
	fetched_more.emit(result)
func _error_fetch_more(args): error_fetch_more.emit(GP._js_to_dict(args[0]))


class GPImage:
	extends GP.GPObject
	
	var id:String
	var player_id:int
	var src:String
	var width:int
	var height:int
	var tags:Array
	
	
	func _to_js() -> JavaScriptObject:
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["id"] = id
		js_object["playerId"] = player_id
		js_object["src"] = src
		js_object["width"] = width
		js_object["height"] = height
		var _tags := JavaScriptBridge.create_object("Array")
		for t in tags:
			_tags.push(t)
		js_object["tags"] = _tags
		return js_object
		
		
	func _from_js(js_object) -> GPImage:
		var callback_f_e := JavaScriptBridge.create_callback(_f_e)
		id = js_object["id"]
		player_id =js_object["playerId"]
		src = js_object["src"]
		width = js_object["width"]
		height = js_object["height"]
		tags = Array()
		js_object["tags"].forEach(callback_f_e)
		return self
		
		
	func _f_e(args):
		tags.append(args[0])
