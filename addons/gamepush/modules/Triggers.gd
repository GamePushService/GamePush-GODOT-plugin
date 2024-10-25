extends Node

var window:JavaScriptObject
var gp:JavaScriptObject

signal activated(trigger: Trigger)
signal claimed(trigger: Trigger)
signal _inner_claimed(res:Dictionary)
signal error_claim(err: String)

var _callback_claimed := JavaScriptBridge.create_callback(func(args):
	var response: Dictionary = {
			"trigger": Trigger.new()._from_js(args[0].trigger),
			"isActivated": args[0].isActivated,
			"isClaimed": args[0].isClaimed
		}
	_inner_claimed.emit(response))

var _callback_claim := JavaScriptBridge.create_callback(_claimed)
var _callback_activate := JavaScriptBridge.create_callback(_claimed)
var _callback_error_claim := JavaScriptBridge.create_callback(_claimed)

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.1).timeout
		gp.triggers.on("activate", _callback_activate)
		gp.triggers.on("claim", _callback_claim)
		gp.triggers.on("error:claim", _callback_error_claim)

func claim(id_or_tag: Variant) -> Dictionary:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id_or_tag is int:
			conf["id"] = id_or_tag
		else:
			conf["tag"] = id_or_tag
		gp.triggers.claim(conf).then(_callback_claimed)
		var response = await _inner_claimed
		return response
	else:
		push_warning("Not running on Web")
		return {"trigger": null, "isActivated": false, "isClaimed": false}

func list() -> Array:
	var trigger_list: Array = []
	if OS.get_name() == "Web":
		var triggers = gp.triggers.list
		var callback = JavaScriptBridge.create_callback(func(args):
			var trigger = Trigger.new()._from_js(args[0])
			trigger_list.append(trigger)
		)
		triggers.forEach(callback)
	else:
		push_warning("Not running on Web")
	return trigger_list
	
func activated_list() -> Array:
	var activated_triggers: Array = []
	if OS.get_name() == "Web":
		var activated_list = gp.triggers.activatedList
		var callback = JavaScriptBridge.create_callback(func(args):
			activated_triggers.append(GP._js_to_dict(args[0]))
		)
		activated_list.forEach(callback)
	else:
		push_warning("Not running on Web")
	return activated_triggers	
	
	
func get_trigger(trigger_id: String) -> Dictionary:
	var trigger_info: Dictionary = {}
	if OS.get_name() == "Web":
		var result = gp.triggers.getTrigger(trigger_id)
		if result:
			trigger_info["trigger"] = Trigger.new()._from_js(result.trigger)
			trigger_info["isActivated"] = result.isActivated
			trigger_info["isClaimed"] = result.isClaimed
		else:
			push_warning("Failed to retrieve trigger with ID: " + trigger_id)
	else:
		push_warning("Not running on Web")
	return trigger_info

func is_trigger_activated(id_or_tag: Variant) -> bool:
	if OS.get_name() == "Web":
		return gp.triggers.isActivated(id_or_tag)
	push_warning("Not running on Web")
	return false

func is_claimed(id_or_tag: Variant) -> bool:
	if OS.get_name() == "Web":
		return gp.triggers.isClaimed(id_or_tag)
	push_warning("Not running on Web")
	return false

func _activated(args) -> void:
	var trigger = Trigger.new()._from_js(args[0].trigger)
	activated.emit(trigger)  # Emit the signal with the trigger information

func _claimed(args) -> void:
	var trigger = Trigger.new()._from_js(args[0].trigger)
	claimed.emit(trigger)  # Emit the signal with the trigger information

func _error_claim(args) -> void:
	error_claim.emit(args[0])  # Emit the error signal with the error code

class Trigger:
	var id: String
	var tag: String
	var description: String
	var is_auto_claim: bool
	var conditions: Array # Array of arrays of Condition objects
	var bonuses: Array # Array of Bonus objects

	# Method to convert the trigger to a JSON object
	func _to_js() -> JavaScriptObject:
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["id"] = id
		js_object["tag"] = tag
		js_object["description"] = description
		js_object["isAutoClaim"] = is_auto_claim
		
		# Convert conditions to JavaScript
		var js_conditions := JavaScriptBridge.create_object("Array")
		for condition_list in conditions:
			var js_condition_list := JavaScriptBridge.create_object("Array")
			for condition in condition_list:
				js_condition_list.push(condition._to_js())
			js_conditions.push(js_condition_list)
		js_object["conditions"] = js_conditions
		
		# Convert bonuses to JavaScript
		var js_bonuses := JavaScriptBridge.create_object("Array")
		for bonus in bonuses:
			js_bonuses.push(bonus._to_js())
		js_object["bonuses"] = js_bonuses
		
		return js_object

	# Method to initialize the trigger from a JSON object
	func _from_js(js_object: JavaScriptObject) -> Trigger:
		id = js_object["id"]
		tag = js_object["tag"]
		description = js_object["description"]
		is_auto_claim = js_object["isAutoClaim"]
		
		# Initialize conditions from JavaScript
		conditions = Array()
		var callback_conditions := JavaScriptBridge.create_callback(func(args):
			var condition_list := Array()
			var callback_condition_list := JavaScriptBridge.create_callback(func(args):
				condition_list.append(Condition.new()._from_js(args[0])))
			args[0].forEach(callback_condition_list)
			conditions.append(condition_list))
		js_object["conditions"].forEach(callback_conditions)
		
		# Initialize bonuses from JavaScript
		bonuses = Array()
		var callback_bonuses := JavaScriptBridge.create_callback(func(args):
			bonuses.append(Bonus.new()._from_js(args[0])))
		js_object["bonuses"].forEach(callback_bonuses)
		return self

class Bonus:
	var type: String
	var id: int
	# Method to convert the bonus to a JSON object
	func _to_js() -> JavaScriptObject:
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["type"] = type
		js_object["id"] = id
		return js_object

	# Method to initialize the bonus from a JSON object
	func _from_js(js_object: JavaScriptObject) -> Bonus:
		type = js_object["type"]
		id = js_object["id"]
		return self

class Condition:
	var type: String
	var key: String
	var operator: String
	var value: Variant  # Could be an array of numbers, strings, or booleans

	# Method to convert the condition to a JSON object
	func _to_js() -> JavaScriptObject:
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["type"] = type
		js_object["key"] = key
		js_object["operator"] = operator
		js_object["value"] = value  # Assumes value is already in an appropriate format
		return js_object

	# Method to initialize the condition from a JSON object
	func _from_js(js_object: JavaScriptObject) -> Condition:
		type = js_object["type"]
		key = js_object["key"]
		operator = js_object["operator"]
		value = js_object["value"]
		return self
		
