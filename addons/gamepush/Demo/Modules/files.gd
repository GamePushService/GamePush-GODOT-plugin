extends Control

@onready var url_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/url"
@onready var file_name_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/file_name"
@onready var content_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/content"
@onready var type_file_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/type_file"
@onready var player_id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/player_id"
@onready var limit_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/limit"
@onready var offset_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/offset"
@onready var tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag"
@onready var tag2_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag2"
@onready var tag3_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag3"


# Called when the node enters the scene tree for the first time.
func _ready():
	GP.Files.uploaded.connect(func(arg): GP.Logger.info("uploaded", arg))
	GP.Files.error_upload.connect(func(arg): GP.Logger.info("error_upload", arg))
	GP.Files.loaded_content.connect(func(arg): GP.Logger.info("loaded_content", arg))
	GP.Files.error_load_content.connect(func(arg): GP.Logger.info("error_load_content", arg))
	GP.Files.choosed.connect(func(arg): GP.Logger.info("choosed", arg))
	GP.Files.error_choose.connect(func(arg): GP.Logger.info("error_choose", arg))
	GP.Files.fetched.connect(func(arg): GP.Logger.info("fetched", arg))
	GP.Files.error_fetch.connect(func(arg): GP.Logger.info("error_fetch", arg))
	GP.Files.fetched_more.connect(func(arg): GP.Logger.info("fetched_more", arg))
	GP.Files.error_fetch_more.connect(func(arg): GP.Logger.info("error_fetch_more", arg))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_upload_pressed():
	GP.Files.upload([tag_node.text, tag2_node.text, tag3_node.text])


func _on_upload_url_pressed():
	GP.Files.upload_url(url_node.text, [tag_node.text, tag2_node.text, tag3_node.text])


func _on_upload_content_pressed():
	GP.Files.upload_content(file_name_node.text, content_node.text, [tag_node.text, tag2_node.text, tag3_node.text])


func _on_load_сontent_pressed():
	GP.Logger.info(await GP.Files.load_сontent(url_node.text))


func _on_choose_file_pressed():
	GP.Logger.info(await GP.Files.choose_file(type_file_node.text))


func _on_fetch_pressed():
	GP.Logger.info(await GP.Files.fetch(player_id_node.text, [tag_node.text, tag2_node.text, tag3_node.text], limit_node.text, offset_node.text))


func _on_fetch_more_pressed():
	GP.Logger.info(await GP.Files.fetch_more(player_id_node.text, [tag_node.text, tag2_node.text, tag3_node.text], limit_node.text, offset_node.text))
