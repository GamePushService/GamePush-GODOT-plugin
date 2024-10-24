extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var players:JavaScriptObject


func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.1).timeout
		players = gp.players

signal __fetch(a:JavaScriptObject)

# Fetch players by their IDs
func fetch(ids: Array) -> Dictionary:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		var _ids := JavaScriptBridge.create_object("Array")
		for id in ids:
			_ids.push(id)
		conf["ids"] = _ids
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch.emit(args[0]))
		players.fetch(conf).then(callback)
		var _result = await __fetch
		return GP._js_to_dict(_result)
	push_warning("Not Web")
	return {}
