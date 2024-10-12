extends Node

var window: JavaScriptObject
var gp: JavaScriptObject
var app: JavaScriptObject

signal review_requested(review)
signal shortcut_added(sucess:bool)

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		await yield_until_app_ready()
	else:
		push_warning("Not running on Web")

func yield_until_app_ready():
	while not gp:
		gp = window.gp
		await get_tree().create_timer(0.1).timeout
	app = gp.app

func get_app_property(property_name: String) -> Variant:
	if OS.get_name() == "Web" and app:
		return app[property_name]
	push_warning("Not running on Web")
	return null

func title() -> String:
	return get_app_property("title")

func description() -> String:
	return get_app_property("description")

func image() -> String:
	return get_app_property("image")

func url() -> String:
	return get_app_property("url")

var _callback_request_review = JavaScriptBridge.create_callback(_request_review)

func request_review() -> void:
	if OS.get_name() == "Web" and app:
		app.requestReview().then(_callback_request_review)
		return
	push_warning("Not running on Web")
	
func _request_review(args):
	var result ={
		"success" : args[0]["success"],
		"rating" : args[0]["rating"],
		"error" : args[0]["error"],
	}
	review_requested.emit(result)

func can_request_review() -> bool:
	return get_app_property("canRequestReview")

func is_already_reviewed() -> bool:
	return get_app_property("isAlreadyReviewed")

var _callback_add_shortcut = JavaScriptBridge.create_callback(_add_shortcut)

func add_shortcut() -> void:
	if OS.get_name() == "Web" and app:
		app.addShortcut().then(_callback_add_shortcut)
		return
	push_warning("Not running on Web")
	
func _add_shortcut(args):
	shortcut_added.emit(args[0])

func can_add_shortcut() -> bool:
	return get_app_property("canAddShortcut")
