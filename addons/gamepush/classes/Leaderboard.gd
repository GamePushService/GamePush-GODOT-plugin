extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var leaderboard:JavaScriptObject

signal opened
signal closed

var callback_open := JavaScriptBridge.create_callback(_open)
var callback_close := JavaScriptBridge.create_callback(_close)

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		leaderboard = gp.leaderboard
		leaderboard.on("open", callback_open)
		leaderboard.on("close", callback_close)

func open(order_by:Array[String], order:String, limit:int,
 include_fields:Array[String], display_fields:Array[String],
 with_me:String, show_nearest:int):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		var _order_by := JavaScriptBridge.create_object("Array")
		for t in order_by:
			_order_by.push(t)
		conf["orderBy"] = _order_by
		conf['order'] = order
		conf['limit'] = limit
		var _include_fields := JavaScriptBridge.create_object("Array")
		for t in include_fields:
			_include_fields.push(t)
		conf["includeFields"] = _include_fields
		var _display_fields := JavaScriptBridge.create_object("Array")
		for t in display_fields:
			_display_fields.push(t)
		conf["displayFields"] = _display_fields
		conf['withMe'] = with_me
		conf['showNearest'] = show_nearest
		leaderboard.open(conf)
	else:
		push_warning("Not Web")
		

func fetch(order_by:Array[String], order:String, limit:int,
 include_fields:Array[String], display_fields:Array[String],
 with_me:String, show_nearest:int):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		var _order_by := JavaScriptBridge.create_object("Array")
		for t in order_by:
			_order_by.push(t)
		conf["orderBy"] = _order_by
		conf['order'] = order
		conf['limit'] = limit
		var _include_fields := JavaScriptBridge.create_object("Array")
		for t in include_fields:
			_include_fields.push(t)
		conf["includeFields"] = _include_fields
		var _display_fields := JavaScriptBridge.create_object("Array")
		for t in display_fields:
			_display_fields.push(t)
		conf["displayFields"] = _display_fields
		conf['withMe'] = with_me
		conf['showNearest'] = show_nearest
		var _result = await leaderboard.fetch(conf)
			#TODO
	else:
		push_warning("Not Web")
		
func _open(args): opened.emit()
func _close(args): closed.emit()


class LeaderboardPlayer:
	var id:int
	var name:String
	var avatar:String
	var position:int
	#TODO
	
