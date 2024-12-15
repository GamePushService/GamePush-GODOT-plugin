extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var events:JavaScriptObject

signal after_ready

signal joined(event:Event, player_event:PlayerEvent)
signal error_join(error:String)

var _callback_joined := JavaScriptBridge.create_callback(_join)
var _callback_error_join := JavaScriptBridge.create_callback(_error_join)

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		gp = GP.gp
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.01).timeout
		events = gp.events
		events.on("join", _callback_joined)
		events.on("error:join", _callback_error_join)
	after_ready.emit()
	

func join(id_or_tag:Variant) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if _is_valid_id(id_or_tag):
			conf["id"] = id_or_tag
			events.join(conf)
			return
		else:
			conf["tag"] = id_or_tag
			events.join(conf)
			return
		push_error("No id or tag")
		return
	push_warning("Not running on Web")
	
func list() -> Array:
	var result := []
	if OS.get_name() == "Web":
		var callback := JavaScriptBridge.create_callback(func(args):
			result.append(Event.new()._from_js(args[0])))
		events.list.forEach(callback)
	else:
		push_warning("Not running on Web")
	return result
	
func active_list() -> Array:
	var result := []
	if OS.get_name() == "Web":
		var callback := JavaScriptBridge.create_callback(func(args):
			result.append(PlayerEvent.new()._from_js(args[0])))
		events.activeList.forEach(callback)
	else:
		push_warning("Not running on Web")
	return result
	
func get_event(id_or_tag:Variant) -> Event:
	var result := Event.new()
	if OS.get_name() == "Web":
		if id_or_tag is String and id_or_tag.is_valid_int():
			id_or_tag = int(id_or_tag)
		var _res = events.getEvent(id_or_tag)
		result._from_js(_res.event)
		return result
	push_warning("Not running on Web")
	return result
	
func has(id_or_tag:Variant) -> bool:
	if OS.get_name() == "Web":
		if id_or_tag is String and id_or_tag.is_valid_int():
			id_or_tag = int(id_or_tag)
		return events.has(id_or_tag)
	push_warning("Not running on Web")
	return false


func is_joined(id_or_tag:Variant) -> bool:
	if OS.get_name() == "Web":
		if id_or_tag is String and id_or_tag.is_valid_int():
			id_or_tag = int(id_or_tag)
		return events.isJoined(id_or_tag)
	push_warning("Not running on Web")
	return false


func _join(args):
	var js_object = args[0]
	var event = Event.new()._from_js(js_object.event)
	var player_event = PlayerEvent.new()._from_js(js_object.playerEvent)
	joined.emit(event, player_event)


func _error_join(args):
	error_join.emit(args[0])


func _is_valid_id(id:Variant):
	if id is int or id is float or id is String:
		var id_int := int(id)
		var list_id := []
		for a in list():
			list_id.append(a.id)
		if id_int in list_id:
			return true
	return false

class Event:
	extends GP.GPObject
	
	var id: int
	var tag: String
	var name: String
	var description: String
	var icon: String
	var icon_small: String
	var date_start: String
	var date_end: String
	var is_active: bool
	var time_left: int
	var is_auto_join: bool
	var triggers: Array

	func _from_js(js_object: JavaScriptObject) -> Event:
		id = js_object["id"]
		tag = js_object["tag"]
		name = js_object["name"]
		description = js_object["description"]
		icon = js_object["icon"]
		icon_small = js_object["iconSmall"]
		date_start = js_object["dateStart"]
		date_end = js_object["dateEnd"]
		is_active = js_object["isActive"]
		time_left = js_object["timeLeft"]
		is_auto_join = js_object["isAutoJoin"]
		triggers = []
		var _callback := JavaScriptBridge.create_callback(func(args):
			triggers.append(GP.Triggers.Trigger.new()._from_js(args[0])))
		js_object["triggers"].forEach(_callback)
		return self

	func _to_js() -> JavaScriptObject:
		var js_object: = JavaScriptBridge.create_object("Object")
		js_object["id"] = id
		js_object["tag"] = tag
		js_object["name"] = name
		js_object["description"] = description
		js_object["icon"] = icon
		js_object["iconSmall"] = icon_small
		js_object["dateStart"] = date_start
		js_object["dateEnd"] = date_end
		js_object["isActive"] = is_active
		js_object["timeLeft"] = time_left
		js_object["isAutoJoin"] = is_auto_join
		var js_triggers := JavaScriptBridge.create_object("Array")
		for t in triggers:
			js_triggers.push(t._to_js())
		js_object["triggers"] = triggers
		return js_object
		
class PlayerEvent:
	extends GP.GPObject
	
	var event_id: int
	var stats: PlayerStats

	func _from_js(js_object: JavaScriptObject) -> PlayerEvent:
		event_id = js_object["eventId"]
		stats = PlayerStats.new()._from_js(js_object["stats"])
		return self

	func _to_js() -> JavaScriptObject:
		var js_object: = JavaScriptBridge.create_object("Object")
		js_object["eventId"] = event_id
		js_object["stats"] = stats._to_js()
		return js_object

		
class PlayerStats:
	extends GP.GPObject
	
	var active_days: int
	var active_days_consecutive: int

	func _from_js(js_object: JavaScriptObject) -> PlayerStats:
		active_days = js_object["activeDays"]
		active_days_consecutive = js_object["activeDaysConsecutive"]
		return self

	func _to_js() -> JavaScriptObject:
		var js_object: = JavaScriptBridge.create_object("Object")
		js_object["activeDays"] = active_days
		js_object["activeDaysConsecutive"] = active_days_consecutive
		return js_object
