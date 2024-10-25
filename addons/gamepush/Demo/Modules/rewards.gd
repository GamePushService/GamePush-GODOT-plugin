extends Control

@onready var id_or_tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id_or_tag"

# Called when the node enters the scene tree for the first time.
func _ready():
	GP.Rewards.reward_accepted.connect(func(reward, player_reward): GP.Logger.info("accepted"))
	GP.Rewards.reward_given.connect(func(reward, player_reward): GP.Logger.info("given"))
	GP.Rewards.reward_error.connect(func(err): GP.Logger.info("reward_error", err))
	GP.Rewards.reward_accept_error.connect(func(err): GP.Logger.info("reward_accept_error", err))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_give_pressed():
	GP.Logger.info(await GP.Rewards.give(id_or_tag_node.text))


func _on_accept_pressed():
	GP.Logger.info(await GP.Rewards.accept(id_or_tag_node.text))


func _on_list_pressed():
	GP.Logger.info(GP.Rewards.list())


func _on_given_list_pressed():
	GP.Logger.info(GP.Rewards.given_list())


func _on_get_reward_pressed():
	GP.Logger.info(GP.Rewards.get_reward(id_or_tag_node.text))


func _on_has_pressed():
	GP.Logger.info(GP.Rewards.has(id_or_tag_node.text))



func _on_has_accepted_pressed():
	GP.Logger.info(GP.Rewards.has_accepted(id_or_tag_node.text))



func _on_has_unaccepted_pressed():
	GP.Logger.info(GP.Rewards.has_unaccepted(id_or_tag_node.text))
