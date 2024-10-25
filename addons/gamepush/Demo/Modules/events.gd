extends Control


@onready var id_or_tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id_or_tag"


# Called when the node enters the scene tree for the first time.
func _ready():
	GP.Events.joined.connect(func(event, player_event): GP.Logger.info("join", event, player_event))
	GP.Events.error_join.connect(func(err): GP.Logger.info("error", err))



func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_join_pressed():
	GP.Events.join(id_or_tag_node.text)


func _on_list_pressed():
	GP.Logger.info(GP.Events.list())


func _on_active_list_pressed():
	GP.Logger.info(GP.Events.active_list())


func _on_get_event_pressed():
	GP.Logger.info(GP.Events.get_event(id_or_tag_node.text))


func _on_has_pressed():
	GP.Logger.info(GP.Events.has(id_or_tag_node.text))


func _on_is_joined_pressed():
	GP.Logger.info(GP.Events.is_joined(id_or_tag_node.text))
