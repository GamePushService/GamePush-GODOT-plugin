extends Node

var window: JavaScriptObject
var gp: JavaScriptObject
var platform: JavaScriptObject

signal after_ready

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		await _yield_until_gp_ready()
	else:
		push_warning("Not running on Web")
	after_ready.emit()
	

func _yield_until_gp_ready():
	gp = GP.gp
	while not gp:
		gp = GP.gp
		await get_tree().create_timer(0.01).timeout
	platform = gp.platform

func _get_platform_property(property_name: String) -> Variant:
	if OS.get_name() == "Web" and platform:
		return platform[property_name]
	push_warning("Not running on Web")
	return false

# Проверка типа платформы, например Yandex или Vk
func type() -> String:
	return str(_get_platform_property("type"))

# Проверка, доступна ли интегрированная аутентификация
func has_integrated_auth() -> bool:
	return _get_platform_property("hasIntegratedAuth")

# Проверка, можно ли выйти из системы
func is_logout_available() -> bool:
	return _get_platform_property("isLogoutAvailable")

# Проверка, разрешено ли открытие внешних ссылок
func is_external_links_allowed() -> bool:
	return _get_platform_property("isExternalLinksAllowed")

# Проверка, доступна ли аутентификация через секретный код
func is_secret_code_auth_available() -> bool:
	return _get_platform_property("isSecretCodeAuthAvailable")

func get_SDK() -> JavaScriptObject:
	return platform.getSDK()

func get_native_SDK() -> JavaScriptObject:
	return platform.getNativeSDK()
