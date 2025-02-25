extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var payments:JavaScriptObject

signal after_ready

signal purchased(result:Array)
signal error_purchase(error:String)
signal consumed(result:Array)
signal error_consume(error:String)
signal fetched_products(result:Array)
signal error_fetch_products(error:String)
signal subscribed(result:Array)
signal error_subscribe(error:String)
signal unsubscribed(result:Array)
signal error_unsubscribe(error:String)

var _callback_purchase := JavaScriptBridge.create_callback(_purchase)
var _callback_error_purchase := JavaScriptBridge.create_callback(_error_purchase)
var _callback_consume := JavaScriptBridge.create_callback(_consume)
var _callback_error_consume := JavaScriptBridge.create_callback(_error_consume)
var _callback_fetch_products := JavaScriptBridge.create_callback(_fetch)
var _callback_error_fetch_products := JavaScriptBridge.create_callback(_error_fetch)
var _callback_subscribe := JavaScriptBridge.create_callback(_subscribe)
var _callback_error_subscribe := JavaScriptBridge.create_callback(_error_subscribe)
var _callback_unsubscribe := JavaScriptBridge.create_callback(_unsubscribe)
var _callback_error_unsubscribe := JavaScriptBridge.create_callback(_error_unsubscribe)

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		gp = GP.gp
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.01).timeout
		payments = gp.payments
		payments.on("consume", _callback_consume)
		payments.on("error:consume", _callback_error_consume)
		payments.on("purchase", _callback_purchase)
		payments.on("error:purchase", _callback_error_purchase)
		payments.on('fetchProducts', _callback_fetch_products)
		payments.on('error:fetchProducts', _callback_error_fetch_products)
		payments.on("subscribe", _callback_subscribe)
		payments.on("error:subscribe", _callback_error_subscribe)
		payments.on("unsubscribe", _callback_unsubscribe)
		payments.on("error:unsubscribe", _callback_error_unsubscribe)
	after_ready.emit()
		
		
func is_available() -> bool:
	if OS.get_name() == "Web":
		return payments.isAvailable
	push_warning("Not Web")
	return false

func consume(id=null, tag=null) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id:
			conf['id'] = id
		elif tag:
			conf["tag"] = tag
		else:
			push_error("No id or tag")
			return
		payments.consume(conf)
	else:
		push_warning("Not Web")
	
	
func purchase(id=null, tag=null) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id:
			conf['id'] = id
		elif tag:
			conf["tag"] = tag
		else:
			push_error("No id or tag")
		payments.purchase(conf)
	else:
		push_warning("Not Web")

	
func has(id=null, tag=null) -> bool:
	if OS.get_name() == "Web":
		var id_or_tag
		if id:
			id_or_tag = id
		elif tag:
			id_or_tag = tag
		else:
			push_error("No id or tag")
		return payments.has(id_or_tag)
	else:
		push_warning("Not Web")
		return false
	

func get_products():
	var result:Array
	if OS.get_name() == "Web":
		var _result = payments.products
		var callback = func(arg): result.append(Purchase.new()._from_js(arg[0]))
		_result.forEach(JavaScriptBridge.create_callback(callback))
		return result
	push_warning("Not Web")
	return result
	
func get_purchases():
	var result:Array
	if OS.get_name() == "Web":
		var _result = payments.purchases
		var callback = func(arg): result.append(PlayerPurchase.new()._from_js(arg[0]))
		_result.forEach(JavaScriptBridge.create_callback(callback))
		return result
	push_warning("Not Web")
	return result


func fetch_products() -> void:
	if OS.get_name() == "Web":
		payments.fetchProducts()
	else:
		push_warning("Not Web")

	
func is_subscriptions_available() -> bool:
	if OS.get_name() == "Web":
		return payments.isSubscriptionsAvailable
	push_warning("Not Web")
	return false
	
func subscribe(id=null, tag=null) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id:
			conf['id'] = id
		elif tag:
			conf["tag"] = tag
		else:
			push_error("No id or tag")
			return 
		payments.subscribe(conf)
	else:
		push_warning("Not Web")
	
func unsubscribe(id=null, tag=null) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id:
			conf['id'] = id
		elif tag:
			conf["tag"] = tag
		else:
			push_error("No id or tag")
			return 
		payments.unsubscribe(conf)
	else:
		push_warning("Not Web")
	
	
func _purchase(args): purchased.emit([Purchase.new()._from_js(args[0].product), PlayerPurchase.new()._from_js(args[0].purchase)])
func _error_purchase(args): error_purchase.emit(args[0])
func _consume(args): consumed.emit([Purchase.new()._from_js(args[0].product), PlayerPurchase.new()._from_js(args[0].purchase)])
func _error_consume(args): error_consume.emit(args[0])
func _fetch(args):
	var result:Array
	var products:Array
	var callback0 = func(arg): products.append(Purchase.new()._from_js(arg[0]))
	args[0].products.forEach(JavaScriptBridge.create_callback(callback0))
	result.append(products)
	var player_purchases:Array
	var callback1 = func(arg): player_purchases.append(PlayerPurchase.new()._from_js(arg[0]))
	args[0].playerPurchases.forEach(JavaScriptBridge.create_callback(callback1))
	result.append(player_purchases)
	fetched_products.emit(result)
func _error_fetch(args): error_fetch_products.emit(args[0])
func _subscribe(args): subscribed.emit([Purchase.new()._from_js(args[0].product), PlayerPurchase.new()._from_js(args[0].purchase)])
func _error_subscribe(args): error_subscribe.emit(args[0])
func _unsubscribe(args): unsubscribed.emit([Purchase.new()._from_js(args[0].product), PlayerPurchase.new()._from_js(args[0].purchase)])
func _error_unsubscribe(args): error_unsubscribe.emit(args[0])


class Purchase:
	extends GP.GPObject
	
	var id:int
	var tag:String
	var name:String
	var description:String
	var icon:String
	var icon_small:String
	var price:int
	var currency:String
	var currency_symbol:String
	var is_subscription:bool
	var period:int
	var trial_period:int

	func _to_js():
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["id"] = id
		js_object["tag"] = tag
		js_object["name"] = name
		js_object["description"] = description
		js_object["icon"] = icon
		js_object["iconSmall"] = icon_small
		js_object["price"] = price
		js_object["currency"] = currency
		js_object["currencySymbol"] = currency_symbol
		js_object["isSubscription"] = is_subscription
		js_object["period"] = period
		js_object["trialPeriod"] = trial_period
		return js_object

	func _from_js(js_object) -> Purchase:
		id = js_object["id"]
		tag = js_object["tag"]
		name = js_object["name"]
		description = js_object["description"]
		icon = js_object["icon"]
		icon_small = js_object["iconSmall"]
		price = js_object["price"]
		currency = js_object["currency"]
		currency_symbol = js_object["currencySymbol"]
		is_subscription = js_object["isSubscription"]
		period = js_object["period"]
		trial_period = js_object["trialPeriod"]
		return self

class PlayerPurchase:
	extends GP.GPObject
	
	var product_id: int
	var payload: Dictionary
	var created_at: String
	var gift: bool
	var subscribed: bool
	var expired_at: String

	func _to_js():
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["productId"] = product_id
		for p in payload:
			js_object["payload"][p] = payload[p]
		js_object["createdAt"] = created_at
		js_object["gift"] = gift
		js_object["subscribed"] = subscribed
		js_object["expiredAt"] = expired_at
		return js_object

	func _from_js(js_object) -> PlayerPurchase:
		product_id = js_object["productId"]
		payload = GP._js_to_dict(js_object["payload"])
		created_at = js_object["createdAt"]
		gift = js_object["gift"]
		subscribed = js_object["subscribed"]
		expired_at = js_object["expiredAt"]
		return self
