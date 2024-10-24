extends Control

@onready var id_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id 
@onready var id2_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id2 
@onready var id3_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id3


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_fetch_pressed():
	var conf := []
	if id_node.text:
		conf.append(id_node.text)
	if id2_node.text:
		conf.append(id2_node.text)
	if id3_node.text:
		conf.append(id3_node.text)
	GP.Logger.info(await GP.Players.fetch(conf))
