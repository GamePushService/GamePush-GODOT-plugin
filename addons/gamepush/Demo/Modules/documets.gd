extends Control

@onready var type_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/type"
@onready var format_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/format"


# Called when the node enters the scene tree for the first time.
func _ready():
	GP.Documents.opened.connect(func(): GP.Logger.info("open"))
	GP.Documents.closed.connect(func(): GP.Logger.info("close"))
	GP.Documents.fetched.connect(func(a): GP.Logger.info("fetch", a))
	GP.Documents.error_fetch.connect(func(a): GP.Logger.info("error", a,))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_open_pressed():
	GP.Documents.open(type_node.text)


func _on_fetch_pressed():
	GP.Documents.fetch(type_node.text, format_node.text)
