extends Control

@onready var orderby1_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/order_by/orderby1
@onready var orderby2_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/order_by/orderby2
@onready var orderby3_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/order_by/orderby3
@onready var order_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/VBoxContainer2/order
@onready var limit_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/VBoxContainer2/limit
@onready var with_me_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/VBoxContainer2/with_me
@onready var show_nearest := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/VBoxContainer2/show_nearest
@onready var include_fields1_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/include_fields/include_fields1
@onready var include_fields2_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/include_fields/include_fields2
@onready var include_fields3_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/include_fields/include_fields3
@onready var dislplay_fields1_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/display_fields/display_fields1
@onready var dislplay_fields2_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/display_fields/display_fields2
@onready var dislplay_fields3_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/display_fields/display_fields3
@onready var variant_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/VBoxContainer3/variant
@onready var id_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/VBoxContainer3/id
@onready var tag_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/VBoxContainer3/tag
@onready var override_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/VBoxContainer3/override

func _ready():
	GP.Leaderboard.opened.connect(func(): GP.Logger.info("open"))
	GP.Leaderboard.closed.connect(func(): GP.Logger.info("close"))
	GP.Leaderboard.fetched.connect(func(result):
		GP.Logger.info("fetch")
		GP.Logger.info(result)
		)
	GP.Leaderboard.fetched_player_rating.connect(func(result):
		GP.Logger.info("fetched_player_rating")
		GP.Logger.info(result)
		)
	GP.Leaderboard.fetched_scoped.connect(func(result):
		GP.Logger.info("fetched_scoped")
		GP.Logger.info(result)
		)
	GP.Leaderboard.fetched_player_rating_scoped.connect(func(result):
		GP.Logger.info("fetched_player_rating_scoped")
		GP.Logger.info(result)
		)
	GP.Leaderboard.yandex_lb_score_setted.connect(func():
		GP.Logger.info("yandex_lb_score_setted"))

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_fetch_pressed():
	var order_by := []
	if orderby1_node.text:
		order_by.append(orderby1_node.text)
	if orderby2_node.text:
		order_by.append(orderby2_node.text)
	if orderby3_node.text:
		order_by.append(orderby3_node.text)
	var includes := []
	var display := []
	if include_fields1_node.text:
		includes.append(include_fields1_node.text)
	if include_fields2_node.text:
		includes.append(include_fields2_node.text)
	if include_fields3_node.text:
		includes.append(include_fields3_node.text)
	if dislplay_fields1_node.text:
		display.append(dislplay_fields1_node.text)
	if dislplay_fields2_node.text:
		display.append(dislplay_fields2_node.text)
	if dislplay_fields3_node.text:
		display.append(dislplay_fields3_node.text)
	GP.Leaderboard.fetch(order_by, order_node.text, int(limit_node.text), includes, display, with_me_node.text, int(show_nearest.text))


func _on_open_pressed():
	var order_by := []
	if orderby1_node.text:
		order_by.append(orderby1_node.text)
	if orderby2_node.text:
		order_by.append(orderby2_node.text)
	if orderby3_node.text:
		order_by.append(orderby3_node.text)
	var includes := []
	var display := []
	if include_fields1_node.text:
		includes.append(include_fields1_node.text)
	if include_fields2_node.text:
		includes.append(include_fields2_node.text)
	if include_fields3_node.text:
		includes.append(include_fields3_node.text)
	if dislplay_fields1_node.text:
		display.append(dislplay_fields1_node.text)
	if dislplay_fields2_node.text:
		display.append(dislplay_fields2_node.text)
	if dislplay_fields3_node.text:
		display.append(dislplay_fields3_node.text)
	GP.Leaderboard.open(order_by, order_node.text, int(limit_node.text), includes, display, with_me_node.text, int(show_nearest.text))


func _on_fetch_player_rating_pressed():
	var order_by := []
	if orderby1_node.text:
		order_by.append(orderby1_node.text)
	if orderby2_node.text:
		order_by.append(orderby2_node.text)
	if orderby3_node.text:
		order_by.append(orderby3_node.text)
	var includes := []
	var display := []
	if include_fields1_node.text:
		includes.append(include_fields1_node.text)
	if include_fields2_node.text:
		includes.append(include_fields2_node.text)
	if include_fields3_node.text:
		includes.append(include_fields3_node.text)
	if dislplay_fields1_node.text:
		display.append(dislplay_fields1_node.text)
	if dislplay_fields2_node.text:
		display.append(dislplay_fields2_node.text)
	if dislplay_fields3_node.text:
		display.append(dislplay_fields3_node.text)
	GP.Leaderboard.fetch_player_rating(order_by, order_node.text, includes, int(show_nearest.text))


func _on_open_scoped_pressed():
	var includes := []
	var display := []
	if include_fields1_node.text:
		includes.append(include_fields1_node.text)
	if include_fields2_node.text:
		includes.append(include_fields2_node.text)
	if include_fields3_node.text:
		includes.append(include_fields3_node.text)
	if dislplay_fields1_node.text:
		display.append(dislplay_fields1_node.text)
	if dislplay_fields2_node.text:
		display.append(dislplay_fields2_node.text)
	if dislplay_fields3_node.text:
		display.append(dislplay_fields3_node.text)
	GP.Leaderboard.open_scoped(variant_node.text, int(id_node.text), tag_node.text, order_node.text, int(limit_node.text), includes, display, with_me_node.text, int(show_nearest.text))
	
	
func _on_fetch_scoped_pressed():
	var includes := [include_fields1_node.text, include_fields2_node.text, include_fields3_node.text]
	var display := [dislplay_fields1_node.text, dislplay_fields2_node.text, dislplay_fields3_node.text]
	GP.Leaderboard.fetch_scoped(variant_node.text, int(id_node.text), tag_node.text, order_node.text, int(limit_node.text), includes, with_me_node.text, int(show_nearest.text))
	
	
func _on_publish_record_pressed():
	var record := {}
	record[$MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/record/HBoxContainer/keys/key1.text] = $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/record/HBoxContainer/valuse/value1.text
	record[$MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/record/HBoxContainer/keys/key2.text] = $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/record/HBoxContainer/valuse/value2.text
	record[$MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/record/HBoxContainer/keys/key3.text] = $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/record/HBoxContainer/valuse/value3.text
		
	GP.Leaderboard.publish_record(variant_node.text, record, int(id_node.text), tag_node.text, override_node.button_pressed)


func _on_fetch_player_rating_scoped_pressed():
	var includes := [include_fields1_node.text, include_fields2_node.text, include_fields3_node.text]
	var display := [dislplay_fields1_node.text, dislplay_fields2_node.text, dislplay_fields3_node.text]
	GP.Leaderboard.fetch_player_rating_scoped(variant_node.text, int(id_node.text), tag_node.text,
	 [orderby1_node.text, orderby2_node.text, orderby3_node.text], order_node.text, includes, int(show_nearest.text))
	

func _on_set_yandex_lb_score_pressed() -> void:
	GP.Leaderboard.set_yandex_lb_score(tag_node.text, int($MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/HBoxContainer/record/HBoxContainer/valuse/value1.text))
