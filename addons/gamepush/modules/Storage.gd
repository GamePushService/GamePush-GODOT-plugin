extends Node

var window: JavaScriptObject
var gp: JavaScriptObject


signal set_success(key: String, value: Variant)
signal get_success(key: String, value: Variant)
signal set_global_success(key: String, value: Variant)
signal get_global_success(key: String, value: Variant)

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
		await gp.storage.set(conf)
	else:
		push_warning("Not running on Web")
		
# Get a value from storage
func get_value(key: String) -> Variant:
	if OS.get_name() == "Web":
		return await gp.storage.get(key)
	else:
		push_warning("Not running on Web")
		return null
		
# Set a global value in storage
func set_global_value(key: String, value: Variant) -> void:
	if OS.get_name() == "Web":
		await gp.storage.setGlobal(key, value)
	else:
		push_warning("Not running on Web")

# Get a global value from storage
func get_global_value(key: String) -> Variant:
	if OS.get_name() == "Web":
		return await gp.storage.getGlobal(key)
	else:
		push_warning("Not running on Web")
		return null
		
		
# Callback for successful value set
func _set_success(args) -> void:
	var key:String = args[0]["key"]
	var value:String = args[0]["value"]
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
