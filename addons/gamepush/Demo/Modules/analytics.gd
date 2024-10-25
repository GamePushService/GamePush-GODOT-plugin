extends Control

@onready var url_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/url"
@onready var name_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/name"
@onready var value_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/value"


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")



func _on_hit_pressed():
	GP.Analytics.hit(url_node.text)


func _on_goal_pressed():
	GP.Analytics.goal(name_node.text, value_node.text)
