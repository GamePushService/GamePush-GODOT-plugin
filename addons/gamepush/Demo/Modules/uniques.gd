extends Control

@onready var tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag"
@onready var value_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/value"


func _ready():
	GP.Uniques.checked.connect(_checked)
	GP.Uniques.registered.connect(_registered)
	GP.Uniques.register_error.connect(_register_error)
	GP.Uniques.check_error.connect(_check_error)
	GP.Uniques.deleted.connect(_deleted)
	GP.Uniques.delete_error.connect(_delete_error)


func _checked(unique_value):
	GP.Logger.info("check", unique_value)
	
func _registered(unique_value):
	GP.Logger.info("registered", unique_value)
	
func _register_error(err):
	GP.Logger.info("register_error", err)
	
func _check_error(err):
	GP.Logger.info("check_error", err)
	
func _deleted(unique_value):
	GP.Logger.info("deleted", unique_value)
	
func _delete_error(err):
	GP.Logger.info("delete_error", err)
	

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_register_pressed():
	GP.Uniques.register(tag_node.text, value_node.text)


func _on_get_value_pressed():
	GP.Logger.info(GP.Uniques.get_value(tag_node.text))


func _on_list_pressed():
	GP.Logger.info(GP.Uniques.list())


func _on_check_pressed():
	GP.Uniques.check(tag_node.text, value_node.text)


func _on_delete_unique_pressed():
	GP.Uniques.delete_unique(tag_node.text)
