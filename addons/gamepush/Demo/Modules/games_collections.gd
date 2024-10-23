extends Control


@onready var id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id"
@onready var tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag"
@onready var key_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/key"
@onready var value_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/param"

# Called when the node enters the scene tree for the first time.
func _ready():
	GP.GamesCollections.opened.connect(func(): GP.Logger.info("open"))
	GP.GamesCollections.closed.connect(func(): GP.Logger.info("close"))
	GP.GamesCollections.fetched.connect(func(collection): GP.Logger.info("fetch", collection.name))
	GP.GamesCollections.error_fetch.connect(func(): GP.Logger.info("error fetch"))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_open_pressed():
	var d := { key_node.text: value_node.text }
	GP.GamesCollections.open(tag_node.text, int(id_node.text), d)


func _on_fetch_pressed():
	GP.GamesCollections.fetch(tag_node.text, int(id_node.text))
