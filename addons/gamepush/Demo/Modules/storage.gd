extends Control

@onready var storage_type_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/storage_type"
@onready var key_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/key"
@onready var value_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/value"



func _ready():
	GP.Storage.set_success.connect(func(k, v): GP.Logger.info("set_success", k, v))
	GP.Storage.get_success.connect(func(k, v): GP.Logger.info("get_success", k, v))
	GP.Storage.set_global_success.connect(func(k, v): GP.Logger.info("set_global_success", k, v))
	GP.Storage.get_global_success.connect(func(k, v): GP.Logger.info("get_global_success", k, v))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_set_storage_pressed():
	if storage_type_node.text in ["local", "platform"]:
		GP.Storage.set_storage(storage_type_node.text)
		GP.Logger.info("set storage:", storage_type_node.text)
		return
	GP.Logger.error("Bad storage type")


func _on_set_value_pressed():
	GP.Storage.set_value(key_node.text, value_node.text)


func _on_get_value_pressed():
	GP.Logger.info(await GP.Storage.get_value(key_node.text))


func _on_set_global_value_pressed():
	GP.Storage.set_global_value(key_node.text, value_node.text)


func _on_get_global_value_pressed():
	GP.Logger.info(await GP.Storage.get_global_value(key_node.text))
