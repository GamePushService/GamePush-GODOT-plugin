extends Control

@onready var id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id"
@onready var tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag"


func _ready():
	GP.Payments.fetched_products.connect(func(res):
		var id := []
		for p in res[0]:
			id.append(p.to_dict())
		GP.Logger.info(id)
		id = []
		for p in res[1]:
			id.append(p.to_dict())
		GP.Logger.info(id)
		GP.Logger.info("fetched_products")
		)
	GP.Payments.purchased.connect(func(res): GP.Logger.info("purchased", res[0].to_dict(), res[1].to_dict()))
	GP.Payments.consumed.connect(func(res): GP.Logger.info("consumed", res[0].to_dict(), res[1].to_dict()))
	GP.Payments.error_purchase.connect(func(res): GP.Logger.info("error_purchase", res))
	GP.Payments.error_consume.connect(func(res): GP.Logger.info("error_purchase", res))
	GP.Payments.error_fetch_products.connect(func(res): GP.Logger.info("error_purchase", res))
	GP.Payments.subscribed.connect(func(res): GP.Logger.info("subscribed", res[0].to_dict(), res[1].to_dict()))
	GP.Payments.unsubscribed.connect(func(res): GP.Logger.info("unsubscribed", res[0].to_dict(), res[1].to_dict()))
	GP.Payments.error_subscribe.connect(func(res): GP.Logger.info("error_subscribe", res))
	GP.Payments.error_unsubscribe.connect(func(res): GP.Logger.info("error_unsubscribe", res))

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
	var result := []
	for p in GP.Payments.get_products():
		result.append(p.to_dict())
	GP.Logger.info(result)


func _on_get_purchases_pressed():
	var result := []
	for p in GP.Payments.get_purchases():
		result.append(p.to_dict())
	GP.Logger.info(result)
