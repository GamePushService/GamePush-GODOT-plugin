extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var events:JavaScriptObject

signal joined
signal error_join


# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		events = gp.events
		events.on("join", JavaScriptBridge.create_callback(_join))
		events.on("error:join", JavaScriptBridge.create_callback(_error_join))
		
		
func join(id=null, tag=null):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id:
			conf["id"] = id
			events.join(conf)
			return
		if tag:
			conf["tag"] = tag
			events.join(conf)
			return
		push_error("No id or tag")
		return
	push_warning("Not running on Web")
	
func list():
	if OS.get_name() == "Web":
		#NEED DATA STRUCTURE
		return await events.list
	push_warning("Not running on Web")
	
func active_list():
	if OS.get_name() == "Web":
		#NEED DATA STRUCTURE
		return events.activeList
	push_warning("Not running on Web")
	
func get_event(id_or_tag:String):
	if OS.get_name() == "Web":
		#NEED DATA STRUCTURE
		return await events.getEvent(id_or_tag)
	push_warning("Not running on Web")
	
func has(id_or_tag:String):
	if OS.get_name() == "Web":
		return await events.has(id_or_tag)
	push_warning("Not running on Web")
	
func is_joined(id_or_tag:String):
	if OS.get_name() == "Web":
		return await events.isJoined(id_or_tag)
	push_warning("Not running on Web")


func _join(args):
	var js_object = args[0]
	var event = js_object.event
	#NEED DATA STRUCTURE
	joined.emit()
	
func _error_join(args):
	error_join.emit(args[0])
