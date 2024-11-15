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
	var result := []
	var res = await GP.Rewards.give(id_or_tag_node.text)
	for r in res:
		result.append(r.to_dict())
	GP.Logger.info(result)


func _on_accept_pressed():
	var result := []
	var res = await GP.Rewards.accept(id_or_tag_node.text)
	for r in res:
		result.append(r.to_dict())
	GP.Logger.info(result)


func _on_list_pressed():
	var res := []
	for r in GP.Rewards.list():
		res.append(r.to_dict())
	GP.Logger.info(res)


func _on_given_list_pressed():
	var res := []
	for r in GP.Rewards.given_list():
		res.append(r.to_dict())
	GP.Logger.info(res)


func _on_get_reward_pressed():
	var res := []
	for r in GP.Rewards.get_reward(id_or_tag_node.text):
		res.append(r.to_dict())
	GP.Logger.info(res)


func _on_has_pressed():
	GP.Logger.info(GP.Rewards.has(id_or_tag_node.text))



func _on_has_accepted_pressed():
	GP.Logger.info(GP.Rewards.has_accepted(id_or_tag_node.text))



func _on_has_unaccepted_pressed():
	GP.Logger.info(GP.Rewards.has_unaccepted(id_or_tag_node.text))
