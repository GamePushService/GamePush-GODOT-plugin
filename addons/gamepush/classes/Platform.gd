extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var platform:JavaScriptObject

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		platform = gp.platform

# Проверка типа платформы, например Yandex или Vk
func type():
	if OS.get_name() == "Web":
		return platform.type
	push_warning("Not Web")

# Проверка, доступна ли интегрированная аутентификация
func has_integrated_auth():
	if OS.get_name() == "Web":
		return platform.hasIntegratedAuth
	push_warning("Not Web")

# Проверка, можно ли выйти из системы
func is_logout_available():
	if OS.get_name() == "Web":
		return platform.isLogoutAvailable
	push_warning("Not Web")

# Проверка, разрешено ли открытие внешних ссылок
func is_external_links_allowed():
	if OS.get_name() == "Web":
		return platform.isExternalLinksAllowed
	push_warning("Not Web")

# Проверка, доступна ли аутентификация через секретный код
func is_secret_code_auth_available():
	if OS.get_name() == "Web":
		return platform.isSecretCodeAuthAvailable
	push_warning("Not Web")

func get_SDK():
	if OS.get_name() == "Web":
		return await platform.getSDK()
	push_warning("Not Web")
	
func get_native_SDK():
	if OS.get_name() == "Web":
		return await platform.getNativeSDK()
	push_warning("Not Web")
