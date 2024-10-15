extends Control

@onready var id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id"
@onready var tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag"
@onready var id_or_tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id_or_tag"
@onready var progress_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/progress"


func _ready():
	GP.Achievements.opened.connect(func(): GP.Logger.info("open"))
	GP.Achievements.closed.connect(func(): GP.Logger.info("close"))
	GP.Achievements.fetched.connect(func(a, b, c): GP.Logger.info("fetch"))
	GP.Achievements.unlocked.connect(func(a): GP.Logger.info("unlock", a))
	GP.Achievements.progress.connect(func(a): GP.Logger.info("progress", a))
	GP.Achievements.error_unlock.connect(func(a): GP.Logger.info("error", a))
	GP.Achievements.error_progress.connect(func(a): GP.Logger.info("error", a))
	GP.Achievements.error_fetch.connect(func(a): GP.Logger.info("error", a))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_open_pressed():
	GP.Achievements.open()


func _on_fetch_pressed():
	GP.Achievements.fetch()


func _on_unlock_pressed():
	GP.Achievements.unlock(id_node.text, tag_node.text)


func _on_set_progress_pressed():
	GP.Achievements.set_progress(progress_node.text, id_node.text, tag_node.text)


func _on_get_progress_pressed():
	GP.Logger.info(GP.Achievements.get_progress(id_or_tag_node.text))


func _on_has_pressed():
	GP.Logger.info(GP.Achievements.has(id_or_tag_node.text))


func _on_list_pressed():
	GP.Logger.info(GP.Achievements.list())


func _on_player_achievements_list_pressed():
	GP.Logger.info(GP.Achievements.player_achievements_list())


func _on_groups_list_pressed():
	GP.Logger.info(GP.Achievements.groups_list())
