extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var players:JavaScriptObject


func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		players = gp.players


# Fetch players by their IDs
func fetch(ids: Array) -> Dictionary:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		var _ids := JavaScriptBridge.create_object("Array")
		for id in ids:
			_ids.push(id)
		conf["ids"] = _ids
		var _result = await players.fetch(conf)
		#_result.forEach()
		#TODO
		
	push_warning("Not Web")
	return {}
