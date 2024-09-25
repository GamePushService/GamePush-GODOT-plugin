extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var games_collections:JavaScriptObject

signal opened
signal closed
signal fetched
signal error_fetch

var callback_open := JavaScriptBridge.create_callback(_open)
var callback_close := JavaScriptBridge.create_callback(_close)
var callback_fetch := JavaScriptBridge.create_callback(_fetch)
var callback_error_fetch := JavaScriptBridge.create_callback(_error_fetch)

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		games_collections = gp.gamesCollections
		games_collections.on("open", callback_open)
		games_collections.on("close", callback_close)
		games_collections.on("fetch", callback_fetch)
		games_collections.on("error:fetch", callback_error_fetch)
		
		
func open(tag=null, id=null, share_params=null):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		var _share_params := JavaScriptBridge.create_object("Object")
		conf['tag'] = tag
		conf['id'] = id
		if share_params and share_params is Dictionary:
			for key in share_params:
				var value = share_params[key]
				_share_params[key] = value
			conf['shareParams'] = share_params
		gp.open(conf)
	else:
		push_warning("Not Web")
		
func fetch(tag=null, id=null):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf['tag'] = tag
		conf['id'] = id
		return await games_collections.fetch(conf)
	else:
		push_warning("Not Web")

func _open(args): opened.emit()
func _close(args): closed.emit()
func _fetch(args): fetched.emit(Collection.new()._from_js(args[0]))
func _error_fetch(args): error_fetch.emit(args[0])


class Collection:
	var id:int
	var tag:String
	var name:String
	var description:String
	var games: Array[Game]
	
	var callback_f_e := JavaScriptBridge.create_callback(_f_e)
	
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
		
	func _from_js(js_object):
		id = js_object["id"]
		tag =js_object["tag"]
		name = js_object["name"]
		description = js_object["description"]
		games = Array()
		js_object["games"].forEach(callback_f_e)
		
	func _f_e(cValue, index, arr):
		games.append(Game.new()._from_js(cValue))
		

class Game:
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
