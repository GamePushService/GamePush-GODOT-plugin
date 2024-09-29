extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func test():
	pass

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
		
