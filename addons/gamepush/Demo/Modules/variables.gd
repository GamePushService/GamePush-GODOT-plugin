extends Control

@onready var var_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/variable_name"
@onready var key_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/key"
@onready var value_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/value"


# Called when the node enters the scene tree for the first time.
func _ready():
	GP.Variables.fetched.connect(func(args): GP.Logger.info("fetched", args))
	GP.Variables.fetched_error.connect(func(err): GP.Logger.info("fetched_error", err))
	GP.Variables.platform_variables_fetched.connect(func(d): GP.Logger.info("platform_variables_fetched", d))
	GP.Variables.platform_variables_error.connect(func(err): GP.Logger.info("platform_variables_error", err))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_fetch_pressed():
	GP.Variables.fetch()


func _on_get_variable_pressed():
	GP.Logger.info(GP.Variables.get_variable(var_node.text))


func _on_has_variable_pressed():
	GP.Logger.info(GP.Variables.has_variable(var_node.text))


func _on_type_pressed():
	GP.Logger.info(GP.Variables.type(var_node.text))


func _on_is_platform_variables_available_pressed():
	GP.Logger.info(GP.Variables.is_platform_variables_available())


func _on_fetch_platform_variables_pressed():
	GP.Variables.fetch_platform_variables({key_node.text: value_node.text})
