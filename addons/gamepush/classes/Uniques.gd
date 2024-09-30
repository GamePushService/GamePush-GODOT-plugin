extends Node

var window: JavaScriptObject
var gp: JavaScriptObject

signal registered(unique_value: UniqueValue)
signal register_error(error: String)
signal checked(unique_value: UniqueValue)
signal check_error(error: String)
signal deleted(unique_value: UniqueValue)
signal delete_error(error: String)

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		gp.uniques.on("register", JavaScriptBridge.create_callback(_registered))
		gp.uniques.on("error:register", JavaScriptBridge.create_callback(_registration_error))
		gp.uniques.on("check", JavaScriptBridge.create_callback(_checked))
		gp.uniques.on("error:check", JavaScriptBridge.create_callback(_check_error))
		gp.uniques.on("delete", JavaScriptBridge.create_callback(_deleted))
		gp.uniques.on("error:delete", JavaScriptBridge.create_callback(_delete_error))

# Method to register or update unique data by tag and value
func register(tag: String, value: String) -> bool:
	var result := false
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["tag"] = tag
		conf["value"] = value
		result = await gp.uniques.register(conf)
	else:
		push_warning("Not running on Web")
	return result
	
# Get a unique value by tag
func get_value(tag: String) -> String:
	if OS.get_name() == "Web":
		return await gp.uniques.get(tag)
	push_warning("Not running on Web")
	return ""
	
# List all unique values
func list() -> Array:
	if OS.get_name() == "Web":
		var unique_values = []
		var values_list = gp.uniques.list
		for js_object in values_list:
			var unique_value = UniqueValue.new()
			unique_value._from_js(js_object)
			unique_values.append(unique_value)
		return unique_values
	push_warning("Not running on Web")
	return []
	
# Check if a unique value exists (by tag and value)
func check(tag: String, value: String) -> bool:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["tag"] = tag
		conf["value"] = value
		var result = await gp.uniques.check(conf)
		return result.success
	push_warning("Not running on Web")
	return false
	
# Method to delete a unique value by tag
func delete_unique(tag: String) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["tag"] = tag
		gp.uniques.delete(conf)
	else:
		push_warning("Not running on Web")
		
# Callback for successful unique registration
func _registered(args) -> void:
	var unique_value = UniqueValue.new()._from_js(args[0])
	emit_signal("unique_registered", unique_value)

# Callback for registration error
func _registration_error(args) -> void:
	emit_signal("unique_registration_error", args[0])
	
# Callback for successful unique value check
func _checked(args) -> void:
	var unique_value = UniqueValue.new()
	unique_value._from_js(args[0])
	checked.emit(unique_value)

# Callback for error during unique value check
func _check_error(args) -> void:
	check_error.emit(args[0])

# Callback for successful deletion
func _deleted(args) -> void:
	var unique_value = UniqueValue.new()
	unique_value._from_js(args[0])
	deleted.emit(unique_value)

# Callback for error during deletion
func _delete_error(args) -> void:
	delete_error.emit(args[0])
	
	
# UniqueValue class structure
class UniqueValue:
	var tag: String
	var value: String

	func _from_js(js_obj: JavaScriptObject) -> UniqueValue:
		tag = js_obj.tag
		value = js_obj.value
		return self
		
	func _to_js() -> JavaScriptObject:
		var js_object = JavaScriptBridge.create_object("Object")
		js_object["tag"] = tag
		js_object["value"] = value
		return js_object
