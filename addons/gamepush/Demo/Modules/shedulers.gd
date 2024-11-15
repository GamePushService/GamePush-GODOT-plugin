extends Control

@onready var id_or_tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id_or_tag"
@onready var day_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/day"
@onready var trigger_id_or_tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/trigger_id_or_tag"


func _ready():
	GP.Schedulers.signal_claim_day.connect(func(scheduler_day_info): GP.Logger.info("signal_claim_day"))
	GP.Schedulers.signal_register.connect(func(scheduler_info): GP.Logger.info("signal_register"))
	GP.Schedulers.signal_claim_day_additional.connect(func(scheduler_day_info): GP.Logger.info("signal_claim_day_additional"))
	GP.Schedulers.signal_claim_all_day.connect(func(scheduler_day_info): GP.Logger.info("signal_claim_all_day"))
	GP.Schedulers.signal_claim_all_days.connect(func(scheduler_info): GP.Logger.info("signal_claim_all_days"))
	GP.Schedulers.signal_join.connect(func(scheduler_info): GP.Logger.info("signal_join"))

	GP.Schedulers.error_claim_day.connect(func(err): GP.Logger.info("error_claim_day", err))
	GP.Schedulers.error_register.connect(func(err): GP.Logger.info("error_register", err))
	GP.Schedulers.error_claim_day_additional.connect(func(err): GP.Logger.info("error_claim_day_additional", err))
	GP.Schedulers.error_claim_all_day.connect(func(err): GP.Logger.info("error_claim_all_day", err))
	GP.Schedulers.error_claim_all_days.connect(func(err): GP.Logger.info("error_claim_all_days", err))
	GP.Schedulers.error_join.connect(func(err): GP.Logger.info("error_join", err))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_register_pressed():
	var res = await GP.Schedulers.register(id_or_tag_node.text)
	GP.Logger.info(res.to_dict())


func _on_claim_day_pressed():
	var res = await GP.Schedulers.claim_day(id_or_tag_node.text, int(day_node.text))
	GP.Logger.info(res.to_dict())
	

func _on_claim_day_additional_pressed():
	var res = await GP.Schedulers.claim_day_additional(id_or_tag_node.text, int(day_node.text), trigger_id_or_tag_node.text)
	GP.Logger.info(res.to_dict())
	

func _on_claim_all_day_pressed():
	var res = await GP.Schedulers.claim_all_day(id_or_tag_node.text, int(day_node.text))
	GP.Logger.info(res.to_dict())


func _on_claim_all_days_pressed():
	var res = await GP.Schedulers.claim_all_days(id_or_tag_node.text)
	GP.Logger.info(res.to_dict())
	

func _on_list_pressed():
	var res := []
	for i in GP.Schedulers.list():
		res.append(i.to_dict())
	GP.Logger.info(res)


func _on_active_list_pressed():
	var res := []
	for i in GP.Schedulers.active_list():
		res.append(i.to_dict())
	GP.Logger.info(res)


func _on_get_scheduler_pressed():
	GP.Logger.info(GP.Schedulers.get_scheduler(id_or_tag_node.text).to_dict())


func _on_get_scheduler_day_pressed():
	GP.Logger.info(GP.Schedulers.get_scheduler_day(id_or_tag_node.text, int(day_node.text)).to_dict())


func _on_get_scheduler_current_day_pressed():
	GP.Logger.info(GP.Schedulers.get_scheduler_current_day(id_or_tag_node.text).to_dict())


func _on_is_registered_pressed():
	GP.Logger.info(GP.Schedulers.is_registered(id_or_tag_node.text))


func _on_is_today_reward_claimed_pressed():
	GP.Logger.info(GP.Schedulers.is_today_reward_claimed(id_or_tag_node.text))


func _on_can_claim_day_pressed():
	GP.Logger.info(GP.Schedulers.can_claim_day(id_or_tag_node.text, int(day_node.text)))


func _on_can_claim_day_additional_pressed():
	GP.Logger.info(GP.Schedulers.can_claim_day_additional(id_or_tag_node.text, int(day_node.text), trigger_id_or_tag_node.text))


func _on_can_claim_all_day_pressed():
	GP.Logger.info(GP.Schedulers.can_claim_all_day(id_or_tag_node.text, int(day_node.text)))
