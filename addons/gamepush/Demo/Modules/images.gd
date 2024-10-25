extends Control

@onready var url_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/url"
@onready var file_name_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/file_name"
@onready var content_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/content"
@onready var player_id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/player_id"
@onready var limit_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/limit"
@onready var offset_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/offset"
@onready var tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag"
@onready var tag2_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag2"
@onready var tag3_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag3"
@onready var width_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/width"
@onready var height_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/height"
@onready var crop_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/crop"


# Called when the node enters the scene tree for the first time.
func _ready():
	GP.Images.uploaded.connect(func(arg): GP.Logger.info("uploaded", arg))
	GP.Images.error_upload.connect(func(arg): GP.Logger.info("error_upload", arg))
	GP.Images.choosed.connect(func(arg): GP.Logger.info("choosed", arg))
	GP.Images.error_choose.connect(func(arg): GP.Logger.info("error_choose", arg))
	GP.Images.fetched.connect(func(arg): GP.Logger.info("fetched", arg))
	GP.Images.error_fetch.connect(func(arg): GP.Logger.info("error_fetch", arg))
	GP.Images.fetched_more.connect(func(arg): GP.Logger.info("fetched_more", arg))
	GP.Images.error_fetch_more.connect(func(arg): GP.Logger.info("error_fetch_more", arg))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_upload_pressed():
	GP.Images.upload([tag_node.text, tag2_node.text, tag3_node.text])


func _on_upload_url_pressed():
	GP.Images.upload_url(url_node.text, [tag_node.text, tag2_node.text, tag3_node.text])



func _on_choose_file_pressed():
	GP.Logger.info(await GP.Images.choose_file())


func _on_fetch_pressed():
	GP.Logger.info(await GP.Images.fetch(player_id_node.text, [tag_node.text, tag2_node.text, tag3_node.text], limit_node.text, offset_node.text))


func _on_fetch_more_pressed():
	GP.Logger.info(await GP.Images.fetch_more(player_id_node.text, [tag_node.text, tag2_node.text, tag3_node.text], limit_node.text, offset_node.text))


func _on_resize_pressed():
	GP.Logger.info(GP.Images.resize(url_node.text, int(width_node.text), int(height_node.text), crop_node.button_pressed))
