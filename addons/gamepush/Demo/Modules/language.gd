extends Control

@onready var lang_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/value"



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_current_pressed():
	GP.Logger.info(GP.Language.current())


func _on_change_pressed():
	GP.Language.change(lang_node.text)
