extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var player:JavaScriptObject


signal synced(success:bool)
signal loaded(success:bool)
signal logged_in(success:bool)
signal logged_out(success:bool)
signal fields_fetched(success:bool)
signal window_connected
signal player_state_changed
signal field_maximum_reached
signal field_minimum_reached
signal field_incremented


var callback_field_incremented := JavaScriptBridge.create_callback(_on_field_incremented)
var callback_maximum_reached := JavaScriptBridge.create_callback(_on_maximum_reached)
var callback_minimum_reached := JavaScriptBridge.create_callback(_on_minimum_reached)
var callback_logout := JavaScriptBridge.create_callback(_logout)
var callback_login := JavaScriptBridge.create_callback(_login)
var callback_load := JavaScriptBridge.create_callback(_load)
var callback_sync := JavaScriptBridge.create_callback(_sync)
var callback_fetch_fields := JavaScriptBridge.create_callback(_fetch_fields)
var callback_window_connected := JavaScriptBridge.create_callback(_on_window_connected)
var callback_state_changed := JavaScriptBridge.create_callback(_on_state_changed)

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		player = gp.player
		player.on("sync", callback_sync)
		player.on("load", callback_load)
		player.on("login", callback_login)
		player.on("logout", callback_logout)
		player.on("fetchFields", callback_fetch_fields)
		gp.on("event:connect", callback_window_connected)
		player.on("change", callback_state_changed)
		player.on("field:maximum", callback_maximum_reached)
		player.on("field:minimum", callback_minimum_reached)
		player.on("field:increment", callback_field_incremented)
		

# ID игрока
func get_id():
	if OS.get_name() == "Web":
		return player.id
	push_warning("Not Web")

# Очки игрока
func get_score():
	if OS.get_name() == "Web":
		return player.score
	push_warning("Not Web")

# Имя игрока
func get_name():
	if OS.get_name() == "Web":
		if player.name:
			return player.name
		else:
			return ""
	push_warning("Not Web")
	return ""

# Ссылка на аватар игрока
func get_avatar():
	if OS.get_name() == "Web":
		return player.avatar
	push_warning("Not Web")

# Проверка, является ли игрок заглушкой (данные по умолчанию)
func is_stub():
	if OS.get_name() == "Web":
		return player.isStub
	push_warning("Not Web")

## Поля игрока
#func get_fields():
	#if OS.get_name() == "Web":
		#return player.fields
	#push_warning("Not Web")

# The player is logged in
func is_logged_in():
	if OS.get_name() == "Web":
		return player.isLoggedIn
	push_warning("Not Web")

# The player uses one of the login methods (authorization, secret code)
func has_any_credentials():
	if OS.get_name() == "Web":
		return player.hasAnyCredentials
	push_warning("Not Web")

# Player waiting promise
func is_ready():
	if OS.get_name() == "Web":
		return await player.ready
	push_warning("Not Web")

func sync(override=null, storage=null) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if override:
			conf["override"] = override
		if storage:
			conf["storage"] = storage
		player.sync(conf)
		return
	push_warning("Not Web")
	
# Enable synchronization
func enable_auto_sync(interval: int = 30, storage: String = "preferred") -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["interval"] = interval
		conf["storage"] = storage
		player.enableAutoSync(conf)
		return
	push_warning("Not Web")

# Disable synchronization
func disable_auto_sync(storage: String = "preferred") -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["storage"] = storage
		player.disableAutoSync(conf)
		return
	push_warning("Not Web")
	
func load() -> void:
	if OS.get_name() == "Web":
		player.load()
		return
	push_warning("Not Web")
	
# Login player
func login() -> void:
	if OS.get_name() == "Web":
		player.login()
		return
	push_warning("Not Web")

# Logout player
func logout() -> void:
	if OS.get_name() == "Web":
		player.logout()
		return
	push_warning("Not Web")
	
# Fetch fields list
func fetch_fields() -> void:
	if OS.get_name() == "Web":
		player.fetchFields()
		return
	push_warning("Not Web")

# Get the value of the key field
func get_value(key: String) -> Variant:
	if OS.get_name() == "Web":
		return player.get(key)
	push_warning("Not Web")
	return

# Set the value of the key field to value, the value is cast to the type
func set_value(key: String, value: Variant) -> void:
	if OS.get_name() == "Web":
		player.set(key, value)
		return
	push_warning("Not Web")

# Add the value to the key field
func add_value(key: String, value: Variant) -> void:
	if OS.get_name() == "Web":
		player.add(key, value)
		return
	push_warning("Not Web")
	
# Toggle the value of the key field
func toggle(key: String) -> void:
	if OS.get_name() == "Web":
		player.toggle(key)
		return
	push_warning("Not Web")
	
# Check if the key field is present and not empty
func has(key: String) -> bool:
	if OS.get_name() == "Web":
		return player.has(key)
	push_warning("Not Web")
	return false

# Return the player state as an object
func to_json() -> JavaScriptObject:
	if OS.get_name() == "Web":
		return await player.toJSON()
	push_warning("Not Web")
	return JavaScriptBridge.create_object("Object")

# Set the state from the object
func from_json(data: Dictionary) -> void:
	if OS.get_name() == "Web":
		var js_object := JavaScriptBridge.create_object("Object")
		for key in data:
			js_object[key] = data[key]
		player.fromJSON(js_object)
		return
	push_warning("Not Web")

# Reset the player state to default
func reset() -> void:
	if OS.get_name() == "Web":
		player.reset()
		return
	push_warning("Not Web")

# Remove the player – reset fields and clear ID
func remove() -> void:
	if OS.get_name() == "Web":
		player.remove()
		return
	push_warning("Not Web")
	
# Get the minimum value of the field key
func get_min_value(key: String) -> int:
	if OS.get_name() == "Web":
		return player.getMinValue(key)
	push_warning("Not Web")
	return 0


# Set the minimum value for the field key
func set_min_value(key: String, value: Variant) -> void:
	if OS.get_name() == "Web":
		player.set(key + ":min", value)
		return
	push_warning("Not Web")

# Get the maximum value of the field key
func get_max_value(key: String) -> int:
	if OS.get_name() == "Web":
		return player.getMaxValue(key)
	push_warning("Not Web")
	return 0

# Set the maximum value for the field key
func set_max_value(key: String, value: Variant) -> void:
	if OS.get_name() == "Web":
		player.set(key + ":max", value)
		return
	push_warning("Not Web")

# Get the number of active days in the game
func get_active_days() -> int:
	if OS.get_name() == "Web":
		return player.stats.activeDays
	push_warning("Not Web")
	return 0

# Get the number of consecutive active days in the game
func get_active_days_consecutive() -> int:
	if OS.get_name() == "Web":
		return player.stats.activeDaysConsecutive
	push_warning("Not Web")
	return 0  # Default value

# Get the number of seconds spent in the game today
func get_playtime_today() -> int:
	if OS.get_name() == "Web":
		return player.stats.playtimeToday
	push_warning("Not Web")
	return 0  # Default value

# Get the total number of seconds spent in the game overall
func get_playtime_all() -> int:
	if OS.get_name() == "Web":
		return player.stats.playtimeAll
	push_warning("Not Web")
	return 0  # Default value

# Get the field by key
func get_field(key: String) -> Variant:
	if OS.get_name() == "Web":
		var _result = player.getField(key)
		return Field.new()._from_js(_result)
	push_warning("Not Web")
	return null

# Get the translated field name by key
func get_field_name(key: String) -> String:
	if OS.get_name() == "Web":
		return player.getFieldName(key)
	push_warning("Not Web")
	return ""

# Get the translated name of the field variant by the key and its value
func get_field_variant_name(key: String, value: Variant) -> String:
	if OS.get_name() == "Web":
		return player.getFieldVariantName(key, value)
	push_warning("Not Web")
	return ""


func _sync(args):  # Emit signal with success status
	synced.emit(args[0])
func _load(args):
	loaded.emit(args[0])  # Emit signal with success status
func _login(args):
	logged_in.emit(args[0])  # Emit signal with success status
func _logout(args):
	logged_out.emit(args[0])  # Emit signal with success status
	
func _fetch_fields(args):
	fields_fetched.emit(args[0]) 
# Callback function for when the player opens another window
func _on_window_connected(args):
	window_connected.emit()  # Emit signal indicating a new window connection
# Callback function for when the player state changes
func _on_state_changed(args):
	player_state_changed.emit()  # Emit signal indicating player state has changed
# Callback function for when the maximum value is reached
func _on_maximum_reached(args):
	var field = Field.new()._from_js(args[0])
	field_maximum_reached.emit(field)  # Emit signal with the field that reached maximum
# Callback function for when the minimum value is reached
func _on_minimum_reached(args):
	var field = Field.new()._from_js(args[0])
	field_minimum_reached.emit(field)  # Emit signal with the field that reached minimum	
func _on_field_incremented(args):
	var field = Field.new()._from_js(args[0][0])
	var old_value = args[0][1] # TODO need test
	var new_value = args[0][2]
	field_incremented.emit(field, old_value, new_value)  # Emit signal with field and its old and new values


class Field:
	var name: String
	var key: String
	var type: String  # 'stats' | 'data' | 'flag' | 'service' | 'accounts'
	var important: bool
	var public: bool
	var default_value: Variant  # Может быть String, int, bool
	var variants: Array[FieldVariant]  # Массив объектов FieldVariant
	var limits: FieldLimits  # Может быть FieldLimits или null
	var interval_increment: IntervalIncrement  # Может быть IntervalIncrement или null


	# Преобразование в JavaScript объект
	func _to_js() -> JavaScriptObject:
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["name"] = name
		js_object["key"] = key
		js_object["type"] = type
		js_object["important"] = important
		js_object["public"] = public
		js_object["default"] = default_value

		# Преобразование variants
		var js_variants := JavaScriptBridge.create_object("Array")
		for variant in variants:
			js_variants.push(variant._to_js())
		js_object["variants"] = js_variants

		# Преобразование limits, если не null
		if limits:
			js_object["limits"] = limits._to_js()
		else:
			js_object["limits"] = null

		# Преобразование intervalIncrement, если не null
		if interval_increment:
			js_object["intervalIncrement"] = interval_increment._to_js()
		else:
			js_object["intervalIncrement"] = null

		return js_object

	# Загрузка данных из JavaScript объекта
	func _from_js(js_object:JavaScriptObject) -> Field:
		name = js_object["name"]
		key = js_object["key"]
		type = js_object["type"]
		important = js_object["important"]
		public = js_object["public"]
		default_value = js_object["default"]
		# Загрузка variants
		variants = []
		js_object["variants"].forEach(JavaScriptBridge.create_callback(_load_variant))
		# Загрузка limits, если оно есть
		if js_object["limits"]:
			limits = FieldLimits.new()
			limits._from_js(js_object["limits"])
		else:
			limits = FieldLimits.new()
		# Загрузка intervalIncrement, если оно есть
		if js_object["intervalIncrement"]:
			interval_increment = IntervalIncrement.new()
			interval_increment._from_js(js_object["intervalIncrement"])
		else:
			interval_increment = IntervalIncrement.new()
		return self

	func _load_variant(args):
		var variant_js = args[0] #Need test
		var variant = FieldVariant.new()
		variant._from_js(variant_js)
		variants.append(variant)


class FieldVariant:
	var name: String
	var value: Variant  # Может быть String, int или bool

	# Преобразование в JavaScript объект
	func _to_js():
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["name"] = name
		js_object["value"] = value
		return js_object

	# Загрузка данных из JavaScript объекта
	func _from_js(js_object):
		name = js_object["name"]
		value = js_object["value"]

class FieldLimits:
	var min: float
	var max: float
	var could_go_over_limit: bool


	# Преобразование в JavaScript объект
	func _to_js():
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["min"] = min
		js_object["max"] = max
		js_object["couldGoOverLimit"] = could_go_over_limit
		return js_object

	# Загрузка данных из JavaScript объекта
	func _from_js(js_object):
		min = js_object["min"]
		max = js_object["max"]
		could_go_over_limit = js_object["couldGoOverLimit"]
		return self

class IntervalIncrement:
	var interval: float  
	var increment: float  


	# Преобразование в JavaScript объект
	func _to_js():
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["interval"] = interval
		js_object["increment"] = increment
		return js_object

	# Загрузка данных из JavaScript объекта
	func _from_js(js_object):
		interval = js_object["interval"]
		increment = js_object["increment"]
		return self
