extends Control

@onready var id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id"
@onready var tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag"


func _ready():
	GP.Payments.fetched_products.connect(func(res): GP.Logger.info(res[0].size(), res[1].size()))

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_is_available_pressed():
	GP.Logger.info(GP.Payments.is_available())


func _on_consume_pressed():
	GP.Payments.consume(id_node.text, tag_node.text)


func _on_purchase_pressed():
	GP.Payments.purchase(id_node.text, tag_node.text)


func _on_fetch_products_pressed():
	GP.Payments.fetch_products()


func _on_is_subscriptions_available_pressed():
	GP.Logger.info(GP.Payments.is_subscriptions_available())


func _on_subscribe_pressed():
	GP.Payments.subscribe(id_node.text, tag_node.text)


func _on_unsubscribe_pressed():
	GP.Payments.unsubscribe(id_node.text, tag_node.text)


func _on_get_products_pressed():
	GP.Logger.info(GP.Payments.get_products().size())


func _on_get_purchases_pressed():
	GP.Logger.info(GP.Payments.get_purchases().size())
