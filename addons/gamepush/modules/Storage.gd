extends Node

var window: JavaScriptObject
var gp: JavaScriptObject


signal set_success(key: String, value: Variant)
signal get_success(value: Variant)
signal set_global_success(key: String, value: Variant)
signal get_global_success(value: Variant)


func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.1).timeout
		gp.storage.on("set", JavaScriptBridge.create_callback(_set_success))
		gp.storage.on("get", JavaScriptBridge.create_callback(_get_success))
		gp.storage.on("set:global", JavaScriptBridge.create_callback(_set_global_success))
		gp.storage.on("get:global", JavaScriptBridge.create_callback(_get_global_success))

# Set storage type
func set_storage(storage_type: String) -> void:
	if OS.get_name() == "Web":
		gp.storage.setStorage(storage_type)
	else:
		push_warning("Not running on Web")

# Set a value in storage
func set_value(key: String, value: Variant) -> void:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["key"] = key
		conf["value"] = value
		gp.storage.set(conf)
	else:
		push_warning("Not running on Web")
		
		
var _callback_get := JavaScriptBridge.create_callback(_get_success)

# Get a value from storage
func get_value(key: String) -> String:
	if OS.get_name() == "Web":
		gp.storage.get(key).then(_callback_get)
		var a = await get_success
		return a
	else:
		push_warning("Not running on Web")
		return ""
		

# Set a global value in storage
func set_global_value(key: String, value: Variant) -> void:
	if OS.get_name() == "Web":
		gp.storage.setGlobal(key, value)
	else:
		push_warning("Not running on Web")

var _callback_get_global := JavaScriptBridge.create_callback(_get_global_success)

# Get a global value from storage
func get_global_value(key: String) -> String:
	if OS.get_name() == "Web":
		gp.storage.getGlobal(key).then(_callback_get_global)
		var a = await get_global_success
		return a
	else:
		push_warning("Not running on Web")
		return ""
		
		
# Callback for successful value set
func _set_success(args) -> void:
	var key:String = args[0]["key"]
	var value:String = args[0]["value"]
	set_success.emit(key, value)
	
# Callback for successful value retrieval
func _get_success(args) -> void:
	get_success.emit(args[0])
	
# Callback for successful global value set
func _set_global_success(args) -> void:
	var key = args[0]["key"]
	var value = args[0]["value"]
	set_global_success.emit(key, value)
	
# Callback for successful global value retrieval
func _get_global_success(args) -> void:
	get_global_success.emit(args[0])
