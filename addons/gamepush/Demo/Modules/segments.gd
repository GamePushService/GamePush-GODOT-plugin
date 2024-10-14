extends Control

@onready var tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag"

# Called when the node enters the scene tree for the first time.
func _ready():
	GP.Segments.entered.connect(_log_par)
	GP.Segments.left.connect(_log_par)

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_has_pressed():
	GP.Logger.info(GP.Segments.has(tag_node.text))


func _on_list_pressed():
	_log_par("List Segments:")
	for f in GP.Segments.list():
		_log_par(f)
	
func _log_par(p):
	GP.Logger.info(p)
