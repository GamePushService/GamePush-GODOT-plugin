extends Node

var window: JavaScriptObject
var gp: JavaScriptObject

signal registered(unique_value: UniqueValue)
signal register_error(error: String)
signal checked(unique_value: UniqueValue)
signal check_error(error: String)
signal deleted(unique_value: UniqueValue)
signal delete_error(error: String)

var _callback_registered := JavaScriptBridge.create_callback(_registered)
var _callback_registration_error := JavaScriptBridge.create_callback(_registration_error)
var _callback_checked := JavaScriptBridge.create_callback(_checked)
var _callback_check_error := JavaScriptBridge.create_callback(_check_error)
var _callback_deleted := JavaScriptBridge.create_callback(_deleted)
var _callback_delete_error := JavaScriptBridge.create_callback(_delete_error)


func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.1).timeout
		gp.uniques.on("register", _callback_registered)
		gp.uniques.on("error:register", _callback_registration_error)
		gp.uniques.on("check", _callback_checked)
		gp.uniques.on("error:check", _callback_check_error)
		gp.uniques.on("delete", _callback_deleted)
		gp.uniques.on("error:delete", _callback_delete_error)


func register(tag: String, value: String) -> void:

	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["tag"] = tag
		conf["value"] = value
		gp.uniques.register(conf)
	else:
		push_warning("Not running on Web")
	

func get_value(tag: String) -> String:
	if OS.get_name() == "Web":
		return gp.uniques.get(tag)
	push_warning("Not running on Web")
	return ""
	

func list() -> Array:
	if OS.get_name() == "Web":
		var unique_values = GP._js_to_dict(gp.uniques.list)
		return unique_values
	push_warning("Not running on Web")
	return []
	
signal _check(a:bool)

func check(tag: String, value: String) -> bool:
	if OS.get_name() == "Web":
		var result
		var conf = JavaScriptBridge.create_object("Object")
		conf["tag"] = tag
		conf["value"] = value
		var callback := JavaScriptBridge.create_callback(func(args):
			_check.emit(args[0])
			)
		gp.uniques.check(conf).then(callback)
		result = await _check
		return result
	else:
		push_warning("Not running on Web")
		return false
	

func delete_unique(tag: String) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["tag"] = tag
		gp.uniques.delete(conf)
	else:
		push_warning("Not running on Web")


func _registered(args) -> void:
	var unique_value = UniqueValue.new()._from_js(args[0])
	registered.emit(unique_value)


func _registration_error(args) -> void:
	register_error.emit(args[0])
	

func _checked(args) -> void:
	var unique_value = UniqueValue.new()
	unique_value._from_js(args[0])
	checked.emit(unique_value)


func _check_error(args) -> void:
	check_error.emit(args[0])


func _deleted(args) -> void:
	var unique_value = UniqueValue.new()
	unique_value._from_js(args[0])
	deleted.emit(unique_value)


func _delete_error(args) -> void:
	delete_error.emit(args[0])
	
	

class UniqueValue:
	extends GP.GPObject
	
	var tag: String
	var value: Variant

	func _from_js(js_obj: JavaScriptObject) -> UniqueValue:
		tag = js_obj.tag
		value = js_obj.value
		return self
		
	func _to_js() -> JavaScriptObject:
		var js_object = JavaScriptBridge.create_object("Object")
		js_object["tag"] = tag
		js_object["value"] = value
		return js_object
