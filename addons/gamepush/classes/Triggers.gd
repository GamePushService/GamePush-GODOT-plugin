extends Node

var window:JavaScriptObject
var gp:JavaScriptObject

signal activated(trigger: Trigger)
signal claimed(trigger: Trigger)
signal error_claim(err: String)

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		gp.triggers.on("activate", JavaScriptBridge.create_callback(_activated))
		gp.triggers.on("claim", JavaScriptBridge.create_callback(_claimed))
		gp.triggers.on("error:claim", JavaScriptBridge.create_callback(_error_claim))

func claim(id: String="", tag: String="") -> Dictionary:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id:
			conf["id"] = id
		elif tag:
			conf["tag"] = tag
		else:
			push_warning("No id or tag")
			return {"trigger": null, "isActivated": false, "isClaimed": false}
		var result = await gp.triggers.claim(conf)
		var response: Dictionary = {
			"trigger": Trigger.new()._from_js(result.trigger),
			"isActivated": result.isActivated,
			"isClaimed": result.isClaimed
		}
		return response
	else:
		push_warning("Not running on Web")
		return {"trigger": null, "isActivated": false, "isClaimed": false}

func list() -> Array:
	var trigger_list: Array = []
	if OS.get_name() == "Web":
		var triggers = gp.triggers.list
		triggers.forEach(JavaScriptBridge.create_callback(func(trigger_js):
			var trigger = Trigger.new()._from_js(trigger_js)
			trigger_list.append(trigger)
		))
	else:
		push_warning("Not running on Web")
	return trigger_list
	
func activated_list() -> Array:
	var activated_triggers: Array = []
	if OS.get_name() == "Web":
		var activated_list = gp.triggers.activatedList
		activated_list.forEach(JavaScriptBridge.create_callback(func(trigger_js):
			var trigger = Trigger.new()._from_js(trigger_js)
			activated_triggers.append(trigger)
		))
	else:
		push_warning("Not running on Web")
	return activated_triggers
	
	
func get_trigger(trigger_id: String) -> Dictionary:
	var trigger_info: Dictionary = {}
	if OS.get_name() == "Web":
		var result = gp.triggers.getTrigger(trigger_id)
		if result:
			trigger_info["trigger"] = result.trigger
			trigger_info["isActivated"] = result.isActivated
			trigger_info["isClaimed"] = result.isClaimed
		else:
			push_warning("Failed to retrieve trigger with ID: " + trigger_id)
	else:
		push_warning("Not running on Web")
	return trigger_info

func is_trigger_activated(id_or_tag: String) -> bool:
	if OS.get_name() == "Web":
		return await gp.triggers.isActivated(id_or_tag)
	push_warning("Not running on Web")
	return false

func is_claimed(id_or_tag: String) -> bool:
	if OS.get_name() == "Web":
		return await gp.triggers.isClaimed(id_or_tag)
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
		for js_condition_list in js_object["conditions"]:
			var condition_list = Array()
			for js_condition in js_condition_list:
				var condition = Condition.new()
				condition._from_js(js_condition)
				condition_list.append(condition)
			conditions.append(condition_list)
		
		# Initialize bonuses from JavaScript
		bonuses = Array()
		for js_bonus in js_object["bonuses"]:
			var bonus = Bonus.new()
			bonus._from_js(js_bonus)
			bonuses.append(bonus)
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
		
