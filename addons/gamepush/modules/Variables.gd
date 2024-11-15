extends Node


signal fetched(Variables: Array)
signal fetched_error(error: String)
signal platform_variables_fetched(variables: Dictionary)
signal platform_variables_error(error: String)

var window: JavaScriptObject
var gp: JavaScriptObject

var _callback_fetch := JavaScriptBridge.create_callback(_fetched)
var _callback_fetched_error := JavaScriptBridge.create_callback(_fetched_error)
var _callback_fetch_platform_variables := JavaScriptBridge.create_callback(_fetch_platform_variables)
var _callback_error_fetch_platform_variables := JavaScriptBridge.create_callback(_error_fetch_platform_variables)

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.1).timeout
		gp.variables.on("fetch", _callback_fetch)
		gp.variables.on("error:fetch", _callback_fetched_error)
		gp.variables.on("fetchPlatformVariables", _callback_fetch_platform_variables)
		gp.variables.on("error:fetchPlatformVariables", _callback_error_fetch_platform_variables)


func fetch() -> void:
	if OS.get_name() == "Web":
		gp.variables.fetch()
	else:
		push_warning("Not running on Web")
		

func get_variable(variable_name: String) -> Variant:
	if OS.get_name() == "Web":
		var result = gp.variables.get(variable_name)
		if result:
			return result
		push_warning("Variable not found: " + variable_name)
		return null
	else:
		push_warning("Not running on Web")
		return null

func has_variable(variable_name: String) -> bool:
	if OS.get_name() == "Web":
		return gp.variables.has(variable_name)
	else:
		push_warning("Not running on Web")
		return false

func type(variable_name: String) -> String:
	if OS.get_name() == "Web":
		return gp.variables.type(variable_name)
	else:
		push_warning("Not running on Web")
		return ""

func is_platform_variables_available() -> bool:
	if OS.get_name() == "Web":
		return gp.variables.isPlatformVariablesAvailable
	push_warning("Not running on Web")
	return false
	
	
signal _fetched_platform_variables(result:Dictionary)

var __callback_fetch_platform_variables := JavaScriptBridge.create_callback(func(args):
	_fetched_platform_variables.emit(GP._js_to_dict(args[0])))
	
func fetch_platform_variables(client_params:Dictionary={}) -> Dictionary:
	if OS.get_name() == "Web":
		var params := JavaScriptBridge.create_object("Object")
		var conf := JavaScriptBridge.create_object("Object")
		if client_params:
			for k in client_params:
				params[k] = client_params[k]
			conf["clientParams"] = params

		gp.variables.fetchPlatformVariables(conf).then(__callback_fetch_platform_variables)
		return await _fetched_platform_variables
	push_warning("Not running on Web")
	return {}


func _fetched(args) -> void:
	fetched.emit(GP._js_to_dict(args[0]))


func _fetched_error(args) -> void:
	fetched.emit(args[0])
	

func _fetch_platform_variables(args) -> void:
	var variables = GP._js_to_dict(args[0]) 
	platform_variables_fetched.emit(variables)


func _error_fetch_platform_variables(args) -> void:
	platform_variables_error.emit(args[0])
