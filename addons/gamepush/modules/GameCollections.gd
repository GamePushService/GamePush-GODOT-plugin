extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var games_collections:JavaScriptObject

signal after_ready

signal opened
signal closed
signal fetched(rsdult:Dictionary)
signal error_fetch(error:String)

var callback_open := JavaScriptBridge.create_callback(_open)
var callback_close := JavaScriptBridge.create_callback(_close)
var callback_fetch := JavaScriptBridge.create_callback(_fetch)
var callback_error_fetch := JavaScriptBridge.create_callback(_error_fetch)

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		gp = GP.gp
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.01).timeout
		games_collections = gp.gamesCollections
		games_collections.on("open", callback_open)
		games_collections.on("close", callback_close)
		games_collections.on("fetch", callback_fetch)
		games_collections.on("error:fetch", callback_error_fetch)
	after_ready.emit()
		
		
func open(tag:String="", id:int=0, share_params:Dictionary={}) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		var _share_params := JavaScriptBridge.create_object("Object")
		if tag:
			conf['tag'] = tag
		if id:
			conf['id'] = id
		if share_params:
			for key in share_params:
				_share_params[key] = share_params[key]
			conf['shareParams'] = _share_params
		games_collections.open(conf)
	else:
		push_warning("Not Web")
		
func fetch(tag:String="", id:int=0) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if tag:
			conf['tag'] = tag
		if id:
			conf['id'] = id
		games_collections.fetch(conf)
	else:
		push_warning("Not Web")

func _open(args): opened.emit()
func _close(args): closed.emit()
func _fetch(args): fetched.emit(GP._js_to_dict(args[0]))
func _error_fetch(args): error_fetch.emit(args[0])


class Collection:
	extends GP.GPObject
	
	var id:int
	var tag:String
	var name:String
	var description:String
	var games: Array
	
	
	
	func _to_js():
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["id"] = id
		js_object["tag"] = tag
		js_object["name"] = name
		js_object["description"] = description
		var _games := JavaScriptBridge.create_object("Array")
		for t in games:
			_games.push(t)
		js_object["games"] = _games
		return js_object
		
	func _from_js(js_object) -> Collection:
		var callback_f_e := JavaScriptBridge.create_callback(_f_e)
		id = js_object["id"]
		tag =js_object["tag"]
		name = js_object["name"]
		description = js_object["description"]
		games = Array()
		js_object["games"].forEach(callback_f_e)
		return self
		
	func _f_e(args):
		games.append(Game.new()._from_js(args[0]))
		

class Game:
	extends GP.GPObject
	
	var id:int
	var name:String
	var description:String
	var icon:String
	var url:String
	
	func _to_js():
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["id"] = id
		js_object["name"] = name
		js_object["description"] = description
		js_object["icon"] = icon
		js_object["url"] = url
		return js_object
		
	func _from_js(js_object):
		id = js_object["id"]
		name = js_object["name"]
		description = js_object["description"]
		icon = js_object["icon"]
		url = js_object["url"]
