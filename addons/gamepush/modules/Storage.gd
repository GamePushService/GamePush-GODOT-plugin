extends Node

var window: JavaScriptObject
var gp: JavaScriptObject


signal set_success(key, value)
signal get_success(key, value)
signal set_global_success(key, value)
signal get_global_success(key, value)


var callback_set := JavaScriptBridge.create_callback(_set_success)
var callback_get := JavaScriptBridge.create_callback(_get_success)
var callback_global_set := JavaScriptBridge.create_callback(_set_global_success)
var callback_global_get := JavaScriptBridge.create_callback(_get_global_success)


func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.1).timeout
		gp.storage.on("set", callback_set)
		gp.storage.on("get", callback_get)
		gp.storage.on("set:global", callback_global_set)
		gp.storage.on("get:global", callback_global_get)


# Set storage type
func set_storage(storage_type: String) -> void:
	if OS.get_name() == "Web":
		gp.storage.setStorage(storage_type)
	else:
		push_warning("Not running on Web")


signal __inner_set(arg)

# Set a value in storage
func set_value(key: String, value: Variant) -> void:
	if OS.get_name() == "Web":
		var callback := JavaScriptBridge.create_callback(func(args):
			__inner_set.emit())
		gp.storage.set(key, value).then(callback)
		await __inner_set
		return 
	else:
		push_warning("Not running on Web")
		

signal __inner_get(arg)
var _callback_get := JavaScriptBridge.create_callback(func(args):
	__inner_get.emit(args[0]))

# Get a value from storage
func get_value(key: String) -> Variant:
	if OS.get_name() == "Web":
		gp.storage.get(key).then(_callback_get)
		var value = await __inner_get
		return value
	else:
		push_warning("Not running on Web")
		return ""
		

signal __inner_global_set(a)
# Set a global value in storage
func set_global_value(key: String, value: Variant) -> void:
	if OS.get_name() == "Web":
		gp.storage.setGlobal(key, value).then(JavaScriptBridge.create_callback(func():
			__inner_global_set.emit()))
		await __inner_global_set
		return
		
	else:
		push_warning("Not running on Web")


signal __inner_global_get(arg)

var _callback_get_global := JavaScriptBridge.create_callback(func(args):
	__inner_global_get.emit(args[0]))

# Get a global value from storage
func get_global_value(key: String) -> Variant:
	if OS.get_name() == "Web":
		gp.storage.getGlobal(key).then(_callback_get_global)
		var a = await __inner_global_get
		return a
	else:
		push_warning("Not running on Web")
		return null
		
		
# Callback for successful value set
func _set_success(args) -> void:
	var key = args[0]["key"]
	var value = args[0]["value"]
	set_success.emit(key, value)
	
# Callback for successful value retrieval
func _get_success(args) -> void:
	var key = args[0]["key"]
	var value = args[0]["value"]
	get_success.emit(key, value)
	
# Callback for successful global value set
func _set_global_success(args) -> void:
	var key = args[0]["key"]
	var value = args[0]["value"]
	set_global_success.emit(key, value)
	
# Callback for successful global value retrieval
func _get_global_success(args) -> void:
	var key = args[0]["key"]
	var value = args[0]["value"]
	get_global_success.emit(key, value)
